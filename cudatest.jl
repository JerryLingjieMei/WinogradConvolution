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
ITERATIONS = 2

include("conv_2d_cuda.jl")

img=CuArray(rand(Float32,64,144,144,64))
fil_trans=CuArray(rand(Float32,64,3,3,64))
dest=CuArray(rand(Float32,64,144,144,64))
shmem = sizeof(Float32) *((4 * 4)+32*(10*10))

# CUDAnative.@device_code_typed @cuda (10,10,shmem) fil_trans_kernel(fil,fil_trans)

function benchmark_fil_trans()
    NVTX.@range "kernel" begin
        @cuda blocks=(18 * 18,2,64) threads=(32,4,4) shmem=shmem maxregs=64 img_trans_kernel(img,fil_trans,dest,144,144,64)
#         @cuda blocks=(72 * 72,2,64) threads=32 shmem=shmem img_trans_kernel(img,fil_trans,dest,144,144,64,64)
#         @cuda blocks=(496,64,64) threads=(32,4,4) shmem=shmem img_trans_kernel(img,fil_trans,dest,(24,24),(144,144),64)
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