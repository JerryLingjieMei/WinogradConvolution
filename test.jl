using CUDAnative
using CUDAdrv
include("conv_2d.jl")
include("conv_2d_cuda.jl")

img_lena=rand(Float32,32,72,72,32)
fil_lena=rand(Float32,32,3,3,32)
dest_lena=zeros(Float32,32,72,72,32)
conv_2d_combined!(img_lena,fil_lena,dest_lena,(1,1),(1,1))

img_cuda=CuArray(img_lena)
fil_cuda=CuArray(fil_lena)
layer=conv2dWinograd(fil_cuda,img_cuda)
debug=forward(layer,img_cuda)
dest=Array(layer.dest)

