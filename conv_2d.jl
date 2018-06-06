function conv_2d_combined!(img::AbstractArray{T,4}, fil::AbstractArray{T,4}, dest::AbstractArray{T,4}, pad::Tuple{Int,Int}=(0,0), stride::Tuple{Int,Int}=(1,1)) where T
    img_c, img_h, img_w, img_n =size(img)
    fil_c, fil_h, fil_w, fil_k=size(fil)
    pad_h, pad_w = pad
    stride_h, stride_w = stride
    out_h = fld(img_h - fil_h + 2 * pad_h , stride_h) + 1
    out_w = fld(img_w - fil_w + 2 * pad_w , stride_w) + 1
    offset_h=cld(pad_h, stride_h)
    offset_w=cld(pad_w, stride_w)
    @assert img_c == fil_c
    @inbounds for n in 1:img_n
        for k in 1:fil_k
            for c in 1:img_c
                @inbounds for x in 1:offset_h, y in 1:out_w
                    x_in =(x - 1) * stride_h - pad_h
                    y_in =(y - 1) * stride_w - pad_w
                    temp =zero(T)
                    for xx in 1:fil_h, yy in 1:fil_w
                        if 0 < x_in + xx <= out_h && 0 < y_in + yy <= out_w
                            temp += img[c,x_in + xx,y_in + yy,n] * fil[c,xx,yy,k]
                        end
                    end
                    dest[k,x,y,n] += temp
                end

                @inbounds for x in out_h - offset_h + 1:out_h, y in 1:out_w
                    x_in =(x - 1) * stride_h - pad_h
                    y_in =(y - 1) * stride_w - pad_w
                    temp =zero(T)
                    for xx in 1:fil_h, yy in 1:fil_w
                        if 0 < x_in + xx <= out_h && 0 < y_in + yy <= out_w
                            temp += img[c,x_in + xx,y_in + yy,n] * fil[c,xx,yy,k]
                        end
                    end
                    dest[k,x,y,n] += temp
                end

                @inbounds for x in offset_h + 1:out_h - offset_h, y in 1:offset_w
                    x_in =(x - 1) * stride_h - pad_h
                    y_in =(y - 1) * stride_w - pad_w
                    temp =zero(T)
                    for xx in 1:fil_h, yy in 1:fil_w
                        if 0 < x_in + xx <= out_h && 0 < y_in + yy <= out_w
                            temp += img[c,x_in + xx,y_in + yy,n] * fil[c,xx,yy,k]
                        end
                    end
                    dest[k,x,y,n] += temp
                end

                @inbounds for x in offset_h + 1:out_h - offset_h, y in out_w - offset_w+1:out_w
                    x_in =(x - 1) * stride_h - pad_h
                    y_in =(y - 1) * stride_w - pad_w
                    temp =zero(T)
                    for xx in 1:fil_h, yy in 1:fil_w
                        if 0 < x_in + xx <= out_h && 0 < y_in + yy <= out_w
                           temp += img[c,x_in + xx,y_in + yy,n] * fil[c,xx,yy,k]
                        end
                    end
                    dest[k,x,y,n] += temp
                end


                @inbounds for x in offset_h + 1:out_h - offset_h, y in offset_w + 1:out_w - offset_w
                    x_in =(x - 1) * stride_h - pad_h
                    y_in =(y - 1) * stride_w - pad_w
                    temp =zero(T)
                    for xx in 1:fil_h, yy in 1:fil_w
                        temp += img[c,x_in + xx,y_in + yy,n] * fil[c,xx,yy,k]
                    end
                    dest[k,x,y,n] += temp
                end
            end
        end
    end
end

