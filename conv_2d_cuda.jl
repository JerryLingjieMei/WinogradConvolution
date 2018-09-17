using CUDAnative
import CUDAdrv: CuArray
using StaticArrays

mutable struct conv2dWinograd{T}
    fil::AbstractArray{T,4}
    fil_trans::AbstractArray{T,4}
    img::AbstractArray{T,4}
    dest::AbstractArray{T,4}
    function conv2dWinograd(fil::AbstractArray{T,4}, img::AbstractArray{T,4}) where T
        fil_k, fil_w, fil_h, fil_c=size(fil)
        img_n, img_w, img_h, img_c =size(img)
        @assert img_c == fil_c
        fil_trans=similar(img,fil_k,4,4,fil_c)
        dest=similar(img,img_n,img_w,img_h ,fil_k)
        return new{T}(fil,fil_trans,img,dest)
    end
end

@inbounds function fil_trans_kernel(fil::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, channels) where T
    c= (blockIdx().x - 1) * blockDim().x + threadIdx().x
    k= blockIdx().y
    if c > channels
        return
    end
    fil_ck=zeros(MMatrix{4,4,T})
    for i in 1:3
        for j in 1:3
            fil_ck[j,i]=fil[k,j,i,c]
        end
    end
    mid = zeros(MMatrix{4,3,T})
    for i=1:3
        mid[1,i]= fil_ck[1,i]
        mid[2,i]= T(.5) * (fil_ck[1,i] + fil_ck[2,i] + fil_ck[3,i])
        mid[3,i]= mid[2,i] - fil_ck[2,i]
        mid[4,i]= fil_ck[3,i]
    end
    for i=1:4
        fil_ck[i,1]=mid[i,1]
        fil_ck[i,2]=T(.5) * (mid[i,1] + mid[i,2] + mid[i,3])
        fil_ck[i,3]=fil_ck[i,2] - mid[i,2]
        fil_ck[i,4]=mid[i,3]
    end
    for i in 1 % UInt32:4 % UInt32
        for j in 1 % UInt32:4 % UInt32
            fil_trans[k,j,i,c]=fil_ck[j,i]
        end
    end
    return
end

function forward(layer::conv2dWinograd, img::AbstractArray{T,4}) where T
    layer.img=img
    img_n,img_w,img_h,img_c=size(img)
    fil_k,fil_w,fil_h,fil_c=size(layer.fil)
    @cuda blocks=(cld(fil_c,32),fil_k) threads =32 fil_trans_kernel(layer.fil,layer.fil_trans,fil_c)
    synchronize()
    @cuda blocks=(cld(img_w,8) * cld(img_h,8),cld(img_n,32),fil_k) threads=(32,4,4) shmem=sizeof(T) * (32 * (10 * 10) + 4 * 4)  img_trans_kernel(layer.img,layer.fil_trans,layer.dest,img_w,img_h,img_c)
end
#
# function forward_new(layer::conv2dWinograd, img::AbstractArray{T,4}) where T
#     layer.img=img
#     img_c,img_w,img_h,img_n=size(img)
#     fil_c,fil_w,fil_h,fil_k=size(layer.fil)
#     @cuda blocks=(cld(fil_c,32),fil_k) threads =32 fil_trans_kernel(layer.fil,layer.fil_trans,fil_c)
#     synchronize()
#     @cuda blocks=(fld(img_w,8) * fld(img_h,8),fil_k,img_n) threads=(32,4,4) shmem=sizeof(T) * 32 * (12 * 12 + 4 * 4) img_trans_kernel(layer.img,layer.fil_trans,layer.dest,(fld(img_w,12),fld(img_h,12)),(img_w,img_h),img_c)
# end

# @inbounds function img_trans_kernel(img::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, dest::AbstractArray{T,4}, superTile_sz::NTuple{2,Int}, img_sz::NTuple{2,Int}, channels::Int) where T
#     temp=zeros(MMatrix{4,4,T})
#     csum=zeros(MMatrix{2,2,T})
#     mid=zeros(MMatrix{4,4,T})
#     superTile_h,superTile_w=superTile_sz
#     img_h,img_w=img_sz
#     n=blockIdx().z
#     k=blockIdx().y
#     z=threadIdx().z
#     y=threadIdx().y
#     tile_id_h=2 * (threadIdx().z - 1)
#     tile_id_w=2 * (threadIdx().y - 1)
#     sTile_id_h= 6 * div(blockIdx().x - 1,superTile_w) + tile_id_h
#     sTile_id_w= 6 * rem(blockIdx().x - 1,superTile_w) + tile_id_w
#     c=threadIdx().x
#     img_n_shared = @cuStaticSharedMem(T, (32, 8, 8))
#     fil_k_shared = @cuStaticSharedMem(T, (32, 4, 4))
#     for ch in c:32:channels
#         for i in 1:2, j in 1:2
#             x_h=sTile_id_h + i - 1
#             x_w=sTile_id_w + j - 1
#             if 0 < x_w <= img_w && 0 < x_h <= img_h
#                 img_n_shared[c,tile_id_w + j,tile_id_h + i]=img[ch,x_w,x_h,n]
#             else
#                 img_n_shared[c,tile_id_w + j,tile_id_h + i]=zero(T)
#             end
#         end
#         fil_k_shared[c,z,y]=fil_trans[ch,z,y]
#         sync_threads()
#         if y < 4 && z < 4
#             for i in 1:4, j in 1:4
#                 temp[j,i]=img_n_shared[c,tile_id_w + j,tile_id_h + i]
#             end
#             for i in 1:4
#                 mid[1,i]= temp[1,i] - temp[3,i]
#                 mid[2,i]= temp[2,i] + temp[3,i]
#                 mid[3,i]= temp[3,i] - temp[2,i]
#                 mid[4,i]= temp[2,i] - temp[4,i]
#             end
#             for i in 1:4
#                 temp[i,1]=(mid[i,1] - mid[i,3]) * fil_k_shared[c,i,1]
#                 temp[i,2]=(mid[i,2] + mid[i,3]) * fil_k_shared[c,i,2]
#                 temp[i,3]=(mid[i,3] - mid[i,2]) * fil_k_shared[c,i,3]
#                 temp[i,4]=(mid[i,2] - mid[i,4]) * fil_k_shared[c,i,4]
#             end
#             for i in 1:4
#                 mid[1,i]= temp[1,i] + temp[2,i] + temp[3,i]
#                 mid[2,i]= temp[2,i] - temp[3,i] - temp[4,i]
#             end
#             for i in 1:2
#                 csum[i,1] += mid[i,1] + mid[i,2] + mid[i,3]
#                 csum[i,2] += mid[i,2] - mid[i,3] - mid[i,4]
#             end
#         end
#     end
#     sync_threads()
#     for i in 1:2,j in 1:2
#         if z < 4 && y < 4
#             csum[j,i] = csum[j,i] + shfl_down(csum[j,i],16)
#             csum[j,i] = csum[j,i] + shfl_down(csum[j,i],8)
#             csum[j,i] = csum[j,i] + shfl_down(csum[j,i],4)
#             csum[j,i] = csum[j,i] + shfl_down(csum[j,i],2)
#             csum[j,i] = csum[j,i] + shfl_down(csum[j,i],1)
#             if c == 1
#                 x_w= sTile_id_w + j
#                 x_h= sTile_id_h + i
#                 if x_w <= img_w && x_h <= img_h
#                     dest[k,x_w,x_h,n]=csum[j,i]
#                 end
#             end
#         end
#     end
#     return
# end

# @inbounds function img_trans_kernel(img::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, dest::AbstractArray{T,4}, img_w::Int, img_h::Int, channels::Int, filters::Int) where T
#     tile_x, tile_y=divrem(blockIdx().x - 1, cld(img_w,2))
#     tile_x += 1
#     tile_y += 1
#     n=(blockIdx().y - 1) * blockDim().x + threadIdx().x
#     k=blockIdx().z
#     nx=threadIdx().x
#     fil_k=@cuDynamicSharedMem(T,(4,4,channels))
#     temp=zeros(MMatrix{4,4,T})
#     csum=zeros(MMatrix{2,2,T})
#     mid=zeros(MMatrix{4,4,T})
#     for c in 1:channels
#         if nx <= 16
#             fil_k[nx + (c - 1) * 16]=fil_trans[k + filters * (nx - 1 + (c - 1) * 16)]
#         end
#         for i in 1:4, j in 1:4
#             x_h=2 * tile_x + i - 1
#             x_w=2 * tile_y + j - 1
#             if 0 < x_h <= img_h && 0 < x_w <= img_w
#                 temp[j,i]=img[n,x_w,x_h,c]
#             else
#                 temp[j,i]=zero(T)
#             end
#         end
#         for i in 1:4
#             mid[1,i]= temp[1,i] - temp[3,i]
#             mid[2,i]= temp[2,i] + temp[3,i]
#             mid[3,i]= temp[3,i] - temp[2,i]
#             mid[4,i]= temp[2,i] - temp[4,i]
#         end
#         for i in 1:4
#             temp[i,1]=(mid[i,1] - mid[i,3]) * fil_k[i,1,c]
#             temp[i,2]=(mid[i,2] + mid[i,3]) * fil_k[i,2,c]
#             temp[i,3]=(mid[i,3] - mid[i,2]) * fil_k[i,3,c]
#             temp[i,4]=(mid[i,2] - mid[i,4]) * fil_k[i,4,c]
#         end
#         for i in 1:4
#             mid[1,i]= temp[1,i] + temp[2,i] + temp[3,i]
#             mid[2,i]= temp[2,i] - temp[3,i] - temp[4,i]
#         end
#         for i in 1:2
#             csum[i,1] += mid[i,1] + mid[i,2] + mid[i,3]
#             csum[i,2] += mid[i,2] - mid[i,3] - mid[i,4]
#         end
#     end
#     for i in 1:2,j in 1:2
#         x_h=2 * tile_x + i
#         x_w=2 * tile_y + j
#         if 0 < x_h <= img_h && 0 < x_w <= img_w
#             dest[n,x_w,x_h,k]=csum[j,i]
#         end
#     end
#     return
# end


@inbounds function img_trans_kernel(img::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, dest::AbstractArray{T,4}, stride_w::Int) where T
    _, img_w, img_h, _ =size(img)
    channels =size(fil_trans,4)
    n=(blockIdx().x - 1) * blockDim().x + threadIdx().x - 1
    nn=threadIdx().x - 1
    k=blockIdx().z - 1
    z=threadIdx().z - 1
    y=threadIdx().y - 1
    t_h,t_w= divrem(blockIdx().y - 1,stride_w)
    img_n= @cuStaticSharedMem(T, (32,12,12))
    fil_k = @cuStaticSharedMem(T,(4,4))
    csum=zeros(MMatrix{2,2,T})
    temp1=zeros(MMatrix{4,4,T})
    temp2=zeros(MMatrix{4,4,T})
    temp3=zeros(MMatrix{4,4,T})
    temp4=zeros(MMatrix{2,4,T})
    for c in 0:channels - 1
        for i in 0:2, j in 0:2
            x_h=8 * t_h + 3 * y + i - 1
            x_w=8 * t_w + 3 * z + j - 1
            img_n[nn + 1, 3 * z + j + 1 ,3 * y + i + 1]= 0 <= x_h < img_h && 0 <= x_w < img_w ? img[n + 1,x_w + 1,x_h + 1,c + 1] : zero(T)
        end
        if threadIdx().x - 1 == 0
            fil_k[z + 1,y + 1]=fil_trans[k + 1,z + 1,y + 1,c + 1]
        end
        sync_threads()
        for i in 1:4, j in 1:4
            temp1[j,i]=img_n[nn + 1,2 * z + j,2 * y + i]
        end
        for i in 1:4
            temp2[1,i]= temp1[1,i] - temp1[3,i]
            temp2[2,i]= temp1[2,i] + temp1[3,i]
            temp2[3,i]= temp1[3,i] - temp1[2,i]
            temp2[4,i]= temp1[2,i] - temp1[4,i]
        end
        for i in 1:4
            temp3[i,1]=(temp2[i,1] - temp2[i,3]) * fil_k[i,1]
            temp3[i,2]=(temp2[i,2] + temp2[i,3]) * fil_k[i,2]
            temp3[i,3]=(temp2[i,3] - temp2[i,2]) * fil_k[i,3]
            temp3[i,4]=(temp2[i,2] - temp2[i,4]) * fil_k[i,4]
        end
        for i in 1:4
            temp4[1,i]= temp3[1,i] + temp3[2,i] + temp3[3,i]
            temp4[2,i]= temp3[2,i] - temp3[3,i] - temp3[4,i]
        end
        for i in 1:2
            csum[i,1] += temp4[i,1] + temp4[i,2] + temp4[i,3]
            csum[i,2] += temp4[i,2] - temp4[i,3] - temp4[i,4]
        end
    end
    for i in 0:1,j in 0:1
        x_w=8 * t_w + 2 * z + j
        x_h=8 * t_h + 2 * y + i
        if x_w < img_w && x_h < img_h
            dest[n + 1,x_w + 1,x_h + 1,k + 1]=csum[j,i]
        end
    end
    return
end