using CUDAnative
using CUDAdrv
include("conv_2d.jl")
include("conv_2d_cuda.jl")

img_lena=rand(Float32,32,72,72,32)
fil_lena=rand(Float32,32,3,3,32)
dest_lena=zeros(Float32,32,72,72,32)
conv_2d_combined!(img_lena,fil_lena,dest_lena,(1,1),(1,1))

img_cuda=CuArray(permutedims(img_lena,(4,2,3,1)))
fil_cuda=CuArray(permutedims(fil_lena,(4,2,3,1)))
layer=conv2dWinograd(fil_cuda,img_cuda)
forward(layer,img_cuda)
dest=permutedims(Array(layer.dest),(4,2,3,1))

