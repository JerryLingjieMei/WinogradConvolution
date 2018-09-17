#=
cudatest:
- Julia version:
- Author: jerrymei
- Date: 2018-05-29
=#
using CUDAdrv
using CUDAnative
import NVTX
import CUDNN

NVTX.stop() # Use `--profile-from-start=off`
ITERATIONS = 5

img=CuArray(rand(Float32,144,144,64,64))
fil=CuArray(rand(Float32,3,3,64,64))
dest=CuArray(rand(Float32,144,144,64,64))

# CUDAnative.@device_code_typed @cuda (10,10,shmem) fil_trans_kernel(fil,fil_trans)

function benchmark_fil_trans()
    NVTX.@range "kernel" begin
        CUDNN.conv2d!(dest,img,fil)
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