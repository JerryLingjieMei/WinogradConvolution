#=
cudatest:
- Julia version:
- Author: jerrymei
- Date: 2018-05-29
=#
using CUDAdrv
using CUDAnative
import NVTX

NVTX.stop() # Use `--profile-from-start=off`
ITERATIONS = 5

include("conv_2d_cuda.jl")

img=CuArray(rand(Float32,64,144,144,64))
fil=CuArray(rand(Float32,64,3,3,64))
dest=CuArray(rand(Float32,64,144,144,64))
layer=conv2dWinograd(fil, img)

# CUDAnative.@device_code_typed @cuda (10,10,shmem) fil_trans_kernel(fil,fil_trans)

function benchmark_fil_trans()
    NVTX.@range "kernel" begin
        forward(layer,img)
        CUDAdrv.synchronize()
    end
end

#warmup
NVTX.mark("Warmup benchmark")
benchmark_fil_trans()

NVTX.@activate CUDAdrv.@profile begin
    for i in 1:ITERATIONS
        benchmark_fil_trans()
    end
end