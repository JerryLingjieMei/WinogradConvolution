using CUDAnative
import CUDAdrv: CuArray
using StaticArrays

mutable struct conv2dWinograd{T}
    fil::AbstractArray{T,4}
    fil_trans::AbstractArray{T,4}
    img::AbstractArray{T,4}
    dest::AbstractArray{T,4}
    function conv2dWinograd(fil::AbstractArray{T,4}, img::AbstractArray{T,4}) where T
        fil_c, fil_w, fil_h, fil_k=size(fil)
        img_c, img_w, img_h, img_n =size(img)
        @assert img_c == fil_c
        fil_trans=similar(img,fil_c,4,4,fil_k)
        tile_h=cld(img_h,2)
        tile_w=cld(img_w,2)
        dest=similar(img,fil_k,img_w,img_h ,img_n)
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
            fil_ck[j,i]=fil[c,j,i,k]
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
            fil_trans[c,j,i,k]=fil_ck[j,i]
        end
    end
    return
end

function forward(layer::conv2dWinograd, img::AbstractArray{T,4}) where T
    layer.img=img
    img_c,img_w,img_h,img_n=size(img)
    fil_c,fil_w,fil_h,fil_k=size(layer.fil)
    @cuda blocks=(cld(fil_c,32),fil_k) threads =32 fil_trans_kernel(layer.fil,layer.fil_trans,fil_c)
    synchronize()
    @cuda blocks=(fld(img_w,6) * fld(img_h,6),fil_k,img_n) threads=(32,4,4) shmem=sizeof(T)*32*(8*8+4*4) img_trans_kernel(layer.img,layer.fil_trans,layer.dest,(fld(img_w,6),fld(img_h,6)),(img_w,img_h),img_c)
end

@inbounds function img_trans_kernel(img::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, dest::AbstractArray{T,4}, superTile_sz, img_sz, channels) where T
    superTile_h,superTile_w=superTile_sz
    img_h,img_w=img_sz
    n=blockIdx().z
    k=blockIdx().y
    sTile_id_h= div(blockIdx().x - 1,superTile_w) + 1
    sTile_id_w= rem(blockIdx().x - 1,superTile_w) + 1
    tile_id_h=threadIdx().z
    tile_id_w=threadIdx().y
    c=threadIdx().x
    img_n_shared = @cuStaticSharedMem(T, (32, 8, 8))
    fil_k_shared = @cuStaticSharedMem(T, (32, 4, 4))
    csum=zeros(MMatrix{2,2,T})
    for ch in c:32:channels
        for i in 1:2
			for j in 1:2
				h=2 * (tile_id_h - 1) + i
				x_h=6 * (sTile_id_h - 1) + h - 1
				w=2 * (tile_id_w - 1) + j
				x_w=6 * (sTile_id_w - 1) + w - 1
				if 0 < x_w <= img_w && 0< x_h<=img_h
					img_n_shared[c,w,h]=img[ch,x_w,x_h,n]
				else
					img_n_shared[c,w,h]=zero(T)
				end
            end
        end
        fil_k_shared[c,tile_id_w,tile_id_h]=fil_trans[ch,tile_id_w,tile_id_h,k]
        sync_threads()
        if tile_id_h < 4 && tile_id_w < 4
            temp=zeros(MMatrix{4,4,T})
            for i in 1:4
                for j in 1:4
                    temp[j,i]=img_n_shared[c,2 * (tile_id_w - 1) + j,2 * (tile_id_h - 1) + i ]
                end
            end
            mid=zeros(MMatrix{4,4,T})
            for i in 1:4
                mid[1,i]= temp[1,i] - temp[3,i]
                mid[2,i]= temp[2,i] + temp[3,i]
                mid[3,i]= temp[3,i] - temp[2,i]
                mid[4,i]= temp[2,i] - temp[4,i]
            end
            for i in 1:4
                temp[i,1]=(mid[i,1] - mid[i,3]) * fil_k_shared[c,i,1]
                temp[i,2]=(mid[i,2] + mid[i,3]) * fil_k_shared[c,i,2]
                temp[i,3]=(mid[i,3] - mid[i,2]) * fil_k_shared[c,i,3]
                temp[i,4]=(mid[i,2] - mid[i,4]) * fil_k_shared[c,i,4]
            end
            for i in 1:4
                mid[1,i]= temp[1,i] + temp[2,i] + temp[3,i]
                mid[2,i]= temp[2,i] - temp[3,i] - temp[4,i]
            end
            for i in 1:2
                csum[i,1] += mid[i,1] + mid[i,2] + mid[i,3]
                csum[i,2] += mid[i,2] - mid[i,3] - mid[i,4]
            end
        end
    end
    sync_threads()
    for i in 1:2
        for j in 1:2
            if tile_id_h < 4 && tile_id_w < 4
                csum[j,i] += shfl_down(csum[j,i],16)
                csum[j,i] += shfl_down(csum[j,i],8)
                csum[j,i] += shfl_down(csum[j,i],4)
                csum[j,i] += shfl_down(csum[j,i],2)
                csum[j,i] += shfl_down(csum[j,i],1)
                if c == 1
                    x_w= 6 * (sTile_id_w - 1) + 2 * (tile_id_w - 1) + j
                    x_h= 6 * (sTile_id_h - 1) + 2 * (tile_id_h - 1) + i
                    if x_w <= img_w && x_h <= img_h
                        dest[k,x_w,x_h,n]=csum[j,i]
                    end
                end
            end
        end
    end
    return
end
@inbounds function img_trans_kernel_new(img::AbstractArray{T,4}, fil_trans::AbstractArray{T,4}, dest::AbstractArray{T,4}, superTile_sz, img_sz, channels) where T
    superTile_h,superTile_w=superTile_sz
    img_h,img_w=img_sz
    n=blockIdx().z
    k=blockIdx().y
    sTile_id_h= div(blockIdx().x - 1,superTile_w) + 1
    sTile_id_w= rem(blockIdx().x - 1,superTile_w) + 1
    tile_id_h=threadIdx().z
    tile_id_w=threadIdx().y
    c=threadIdx().x
    img_n_shared = @cuStaticSharedMem(T, (32, 10, 10))
    fil_k_shared = @cuStaticSharedMem(T, (32, 4, 4))
    csum=zeros(MMatrix{2,2,T})
    for ch in c:32:channels
        for i in 1:2
			for j in 1:2
				h=2 * (tile_id_h - 1) + i
				x_h=8 * (sTile_id_h - 1) + h - 1
				w=2 * (tile_id_w - 1) + j
				x_w=8 * (sTile_id_w - 1) + w - 1
				if 0 < x_w <= img_w && 0< x_h<=img_h
					img_n_shared[c,w,h]=img[ch,x_w,x_h,n]
				else
					img_n_shared[c,w,h]=zero(T)
				end
            end
        end
        fil_k_shared[c,tile_id_w,tile_id_h]=fil_trans[ch,tile_id_w,tile_id_h,k]
        sync_threads()
        if tile_id_h < 4 && tile_id_w < 4
            temp=zeros(MMatrix{4,4,T})
            for i in 1:4
                for j in 1:4
                    temp[j,i]=img_n_shared[c,2 * (tile_id_w - 1) + j,2 * (tile_id_h - 1) + i ]
                end
            end
            mid=zeros(MMatrix{4,4,T})
            for i in 1:4
                mid[1,i]= temp[1,i] - temp[3,i]
                mid[2,i]= temp[2,i] + temp[3,i]
                mid[3,i]= temp[3,i] - temp[2,i]
                mid[4,i]= temp[2,i] - temp[4,i]
            end
            for i in 1:4
                temp[i,1]=(mid[i,1] - mid[i,3]) * fil_k_shared[c,i,1]
                temp[i,2]=(mid[i,2] + mid[i,3]) * fil_k_shared[c,i,2]
                temp[i,3]=(mid[i,3] - mid[i,2]) * fil_k_shared[c,i,3]
                temp[i,4]=(mid[i,2] - mid[i,4]) * fil_k_shared[c,i,4]
            end
            for i in 1:4
                mid[1,i]= temp[1,i] + temp[2,i] + temp[3,i]
                mid[2,i]= temp[2,i] - temp[3,i] - temp[4,i]
            end
            for i in 1:2
                csum[i,1] += mid[i,1] + mid[i,2] + mid[i,3]
                csum[i,2] += mid[i,2] - mid[i,3] - mid[i,4]
            end
        end
    end
    sync_threads()
    for i in 1:2
        for j in 1:2
            if tile_id_h < 4 && tile_id_w < 4
                csum[j,i] += shfl_down(csum[j,i],16)
                csum[j,i] += shfl_down(csum[j,i],8)
                csum[j,i] += shfl_down(csum[j,i],4)
                csum[j,i] += shfl_down(csum[j,i],2)
                csum[j,i] += shfl_down(csum[j,i],1)
                if c == 1
                    x_w= 6 * (sTile_id_w - 1) + 2 * (tile_id_w - 1) + j
                    x_h= 6 * (sTile_id_h - 1) + 2 * (tile_id_h - 1) + i
                    if x_w <= img_w && x_h <= img_h
                        dest[k,x_w,x_h,n]=csum[j,i]
                    end
                end
            end
        end
    end
    return
end