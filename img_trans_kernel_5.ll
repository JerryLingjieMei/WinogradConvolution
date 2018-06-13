; ModuleID = 'Kernel'
source_filename = "Kernel"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%jl_value_t = type opaque

@shmem4 = external addrspace(3) global [16 x float], align 4
@shmem3 = external local_unnamed_addr addrspace(3) global [3200 x float], align 4

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #0

; Function Attrs: noreturn nounwind
declare void @llvm.trap() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.z() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.z() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2

define void @ptxcall_Kernel_5({ [4 x i64], { i64 } }, { [4 x i64], { i64 } }, { [4 x i64], { i64 } }, i64, i64, i64) local_unnamed_addr {
entry:
  %6 = sdiv i64 %3, 8, !dbg !7
  %7 = icmp sgt i64 %3, 0, !dbg !17
  %8 = shl nsw i64 %6, 3, !dbg !23
  %9 = icmp ne i64 %8, %3, !dbg !25
  %10 = and i1 %7, %9, !dbg !30
  %11 = zext i1 %10 to i64, !dbg !33
  %12 = add nsw i64 %6, %11, !dbg !45
  %13 = icmp eq i64 %12, 0, !dbg !47
  br i1 %13, label %fail1.i, label %pass2.i, !dbg !47

L116.L121_crit_edge.i:                            ; preds = %after_srem.i
  %.fca.0.0.extract28 = extractvalue { [4 x i64], { i64 } } %0, 0, 0
  %.fca.0.1.extract29 = extractvalue { [4 x i64], { i64 } } %0, 0, 1
  %.fca.0.2.extract30 = extractvalue { [4 x i64], { i64 } } %0, 0, 2
  %.fca.1.0.extract32 = extractvalue { [4 x i64], { i64 } } %0, 1, 0
  %.fca.0.0.extract14 = extractvalue { [4 x i64], { i64 } } %1, 0, 0
  %.fca.0.1.extract15 = extractvalue { [4 x i64], { i64 } } %1, 0, 1
  %.fca.0.2.extract16 = extractvalue { [4 x i64], { i64 } } %1, 0, 2
  %.fca.1.0.extract18 = extractvalue { [4 x i64], { i64 } } %1, 1, 0
  %14 = zext i32 %288 to i64, !dbg !50
  %15 = zext i32 %289 to i64, !dbg !53
  %16 = shl i64 %290, 3
  %17 = icmp sgt i64 %.fca.0.0.extract28, 0
  %18 = select i1 %17, i64 %.fca.0.0.extract28, i64 0
  %19 = icmp sgt i64 %.fca.0.1.extract29, 0
  %20 = select i1 %19, i64 %.fca.0.1.extract29, i64 0
  %21 = icmp sgt i64 %.fca.0.2.extract30, 0
  %22 = select i1 %21, i64 %.fca.0.2.extract30, i64 0
  %23 = add nsw i64 %285, -1
  %24 = inttoptr i64 %.fca.1.0.extract32 to float*
  %addconv2223 = add nuw nsw i32 %284, 2
  %25 = zext i32 %addconv2223 to i64
  %26 = icmp eq i32 %284, 0
  %27 = icmp sgt i64 %.fca.0.0.extract14, 0
  %28 = select i1 %27, i64 %.fca.0.0.extract14, i64 0
  %29 = icmp sgt i64 %.fca.0.1.extract15, 0
  %30 = select i1 %29, i64 %.fca.0.1.extract15, i64 0
  %31 = icmp sgt i64 %.fca.0.2.extract16, 0
  %32 = select i1 %31, i64 %.fca.0.2.extract16, i64 0
  %33 = inttoptr i64 %.fca.1.0.extract18 to float*
  %34 = shl nuw nsw i32 %289, 2
  %addconv2235 = add nuw nsw i32 %34, %288
  %35 = zext i32 %addconv2235 to i64
  %36 = getelementptr [16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 %35
  %37 = bitcast float addrspace(3)* %36 to i32 addrspace(3)*
  %38 = shl nuw nsw i32 %288, 6
  %39 = shl nuw nsw i32 %289, 1
  %40 = zext i32 %39 to i64
  %41 = add nsw i64 %25, -353
  br label %L121.i, !dbg !55

L121.i:                                           ; preds = %L474.i, %L116.L121_crit_edge.i
  %42 = phi float [ 0.000000e+00, %L116.L121_crit_edge.i ], [ %243, %L474.i ]
  %43 = phi float [ 0.000000e+00, %L116.L121_crit_edge.i ], [ %237, %L474.i ]
  %44 = phi float [ 0.000000e+00, %L116.L121_crit_edge.i ], [ %240, %L474.i ]
  %45 = phi float [ 0.000000e+00, %L116.L121_crit_edge.i ], [ %234, %L474.i ]
  %value_phi8.i = phi i64 [ 1, %L116.L121_crit_edge.i ], [ %245, %L474.i ]
  %46 = add nsw i64 %value_phi8.i, -1
  %47 = mul i64 %46, %22
  br label %L158.i, !dbg !56

L158.i:                                           ; preds = %L378.i, %L121.i
  %value_phi18.i = phi i64 [ 0, %L121.i ], [ %82, %L378.i ]
  %48 = add nuw nsw i64 %value_phi18.i, %15
  %49 = icmp ult i64 %48, 10
  br i1 %49, label %L158.i.split.us, label %L378.i, !dbg !56

L158.i.split.us:                                  ; preds = %L158.i
  %50 = add nsw i64 %48, -1
  %51 = add i64 %50, %16
  %52 = icmp slt i64 %51, 1
  %53 = icmp sle i64 %51, %4
  %54 = add i64 %51, -1
  %reass.add = add i64 %54, %47
  %reass.mul = mul i64 %reass.add, %20
  %55 = mul i64 %48, 320
  %56 = add nsw i64 %55, -1
  %57 = icmp ult i32 %288, 10, !dbg !57
  br i1 %57, label %L206.i.us, label %L366.i.us, !dbg !59

L206.i.us:                                        ; preds = %L158.i.split.us
  %58 = add nsw i64 %14, -1, !dbg !60
  %59 = add i64 %58, %281, !dbg !62
  %60 = icmp slt i64 %59, 1, !dbg !63
  %61 = icmp sgt i64 %59, %3, !dbg !65
  %spec.select.not.us = or i1 %60, %61, !dbg !67
  %or.cond.us = or i1 %52, %spec.select.not.us, !dbg !67
  %or.cond.not.us = xor i1 %or.cond.us, true, !dbg !67
  %or.cond2270.us = and i1 %53, %or.cond.not.us, !dbg !67
  br i1 %or.cond2270.us, label %L231.i.us, label %L320.i.us, !dbg !67

L320.i.us:                                        ; preds = %L206.i.us
  %62 = shl nuw nsw i32 %288, 5, !dbg !68
  %63 = zext i32 %62 to i64, !dbg !68
  %64 = add i64 %56, %63, !dbg !83
  %65 = add i64 %64, %25, !dbg !85
  %66 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %65, !dbg !97
  store float 0.000000e+00, float addrspace(3)* %66, align 4, !dbg !97
  br label %L366.i.us, !dbg !98

L231.i.us:                                        ; preds = %L206.i.us
  %67 = add i64 %59, -1, !dbg !102
  %reass.add2271.us = add i64 %67, %reass.mul
  %reass.mul2272.us = mul i64 %reass.add2271.us, %18
  %68 = add i64 %23, %reass.mul2272.us, !dbg !115
  %69 = getelementptr float, float* %24, i64 %68, !dbg !122
  %70 = bitcast float* %69 to i32*, !dbg !122
  %71 = addrspacecast i32* %70 to i32 addrspace(1)*, !dbg !122
  %72 = load i32, i32 addrspace(1)* %71, align 4, !dbg !122
  %73 = shl nuw nsw i32 %288, 5, !dbg !123
  %74 = zext i32 %73 to i64, !dbg !123
  %75 = add i64 %56, %74, !dbg !131
  %76 = add i64 %75, %25, !dbg !133
  %77 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %76, !dbg !138
  %78 = bitcast float addrspace(3)* %77 to i32 addrspace(3)*, !dbg !138
  store i32 %72, i32 addrspace(3)* %78, align 4, !dbg !138
  br label %L366.i.us, !dbg !139

L366.i.us:                                        ; preds = %L231.i.us, %L320.i.us, %L158.i.split.us
  %79 = add nuw nsw i64 %14, 4, !dbg !140
  %80 = icmp ult i64 %79, 10, !dbg !57
  br i1 %80, label %L206.i.us.1, label %L366.i.us.1, !dbg !59

L378.i:                                           ; preds = %L366.i.us.1, %L320.i.us.2, %L231.i.us.2, %L158.i
  %81 = icmp eq i64 %value_phi18.i, 8, !dbg !98
  %82 = add nuw nsw i64 %value_phi18.i, 4, !dbg !141
  br i1 %81, label %L390.i, label %L158.i, !dbg !143

L390.i:                                           ; preds = %L378.i
  br i1 %26, label %L404.i, label %L474.i, !dbg !144

L404.i:                                           ; preds = %L390.i
  %83 = mul i64 %46, %32, !dbg !145
  %reass.add2273 = add i64 %83, %15
  %reass.mul2274 = mul i64 %reass.add2273, %30
  %reass.add2275 = add i64 %reass.mul2274, %14
  %reass.mul2276 = mul i64 %reass.add2275, %28
  %84 = add i64 %reass.mul2276, %287, !dbg !156
  %85 = getelementptr float, float* %33, i64 %84, !dbg !161
  %86 = bitcast float* %85 to i32*, !dbg !161
  %87 = addrspacecast i32* %86 to i32 addrspace(1)*, !dbg !161
  %88 = load i32, i32 addrspace(1)* %87, align 4, !dbg !161
  store i32 %88, i32 addrspace(3)* %37, align 4, !dbg !162
  br label %L474.i, !dbg !168

L474.i:                                           ; preds = %L390.i, %L404.i
  call void @llvm.nvvm.barrier0(), !dbg !168
  %89 = or i32 %38, 32, !dbg !172
  %90 = zext i32 %89 to i64, !dbg !172
  %91 = add nsw i64 %41, %90, !dbg !181
  %92 = or i64 %40, 1
  %93 = mul nuw nsw i64 %92, 320
  %94 = add nsw i64 %91, %93, !dbg !183
  %95 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %94, !dbg !188
  %96 = load float, float addrspace(3)* %95, align 4, !dbg !188
  %addconv2351 = add nuw nsw i32 %38, 64, !dbg !172
  %97 = zext i32 %addconv2351 to i64, !dbg !172
  %98 = add nsw i64 %41, %97, !dbg !181
  %99 = add nsw i64 %98, %93, !dbg !183
  %100 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %99, !dbg !188
  %101 = load float, float addrspace(3)* %100, align 4, !dbg !188
  %addconv2352 = add nuw nsw i32 %38, 96, !dbg !172
  %102 = zext i32 %addconv2352 to i64, !dbg !172
  %103 = add nsw i64 %41, %102, !dbg !181
  %104 = add nsw i64 %103, %93, !dbg !183
  %105 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %104, !dbg !188
  %106 = load float, float addrspace(3)* %105, align 4, !dbg !188
  %addconv2353 = add nuw nsw i32 %38, 128, !dbg !172
  %107 = zext i32 %addconv2353 to i64, !dbg !172
  %108 = add nsw i64 %41, %107, !dbg !181
  %109 = add nsw i64 %108, %93, !dbg !183
  %110 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %109, !dbg !188
  %111 = load float, float addrspace(3)* %110, align 4, !dbg !188
  %112 = mul nuw nsw i64 %40, 320
  %113 = add nuw nsw i64 %112, 640
  %114 = add nsw i64 %91, %113, !dbg !183
  %115 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %114, !dbg !188
  %116 = load float, float addrspace(3)* %115, align 4, !dbg !188
  %117 = add nsw i64 %98, %113, !dbg !183
  %118 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %117, !dbg !188
  %119 = load float, float addrspace(3)* %118, align 4, !dbg !188
  %120 = add nsw i64 %103, %113, !dbg !183
  %121 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %120, !dbg !188
  %122 = load float, float addrspace(3)* %121, align 4, !dbg !188
  %123 = add nsw i64 %108, %113, !dbg !183
  %124 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %123, !dbg !188
  %125 = load float, float addrspace(3)* %124, align 4, !dbg !188
  %126 = add nuw nsw i64 %112, 960
  %127 = add nsw i64 %91, %126, !dbg !183
  %128 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %127, !dbg !188
  %129 = load float, float addrspace(3)* %128, align 4, !dbg !188
  %130 = add nsw i64 %98, %126, !dbg !183
  %131 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %130, !dbg !188
  %132 = load float, float addrspace(3)* %131, align 4, !dbg !188
  %133 = add nsw i64 %103, %126, !dbg !183
  %134 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %133, !dbg !188
  %135 = load float, float addrspace(3)* %134, align 4, !dbg !188
  %136 = add nsw i64 %108, %126, !dbg !183
  %137 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %136, !dbg !188
  %138 = load float, float addrspace(3)* %137, align 4, !dbg !188
  %139 = add nuw nsw i64 %112, 1280
  %140 = add nsw i64 %98, %139, !dbg !183
  %141 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %140, !dbg !188
  %142 = load float, float addrspace(3)* %141, align 4, !dbg !188
  %143 = add nsw i64 %103, %139, !dbg !183
  %144 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %143, !dbg !188
  %145 = load float, float addrspace(3)* %144, align 4, !dbg !188
  %146 = fsub float %116, %122, !dbg !189
  %147 = fadd float %119, %122, !dbg !193
  %148 = fsub float %122, %119, !dbg !196
  %149 = fsub float %119, %125, !dbg !198
  %150 = fsub float %129, %135, !dbg !189
  %151 = fadd float %132, %135, !dbg !193
  %152 = fsub float %135, %132, !dbg !196
  %153 = fsub float %132, %138, !dbg !198
  %154 = fadd float %142, %145, !dbg !193
  %155 = fadd float %101, %106, !dbg !193
  %156 = fsub float %155, %151, !dbg !200
  %157 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 1), align 4, !dbg !202
  %158 = fmul float %156, %157, !dbg !208
  %159 = fadd float %147, %151, !dbg !210
  %160 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 5), align 4, !dbg !212
  %161 = fmul float %159, %160, !dbg !218
  %162 = fsub float %151, %147, !dbg !219
  %163 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 9), align 4, !dbg !221
  %164 = fmul float %162, %163, !dbg !227
  %165 = fsub float %147, %154, !dbg !228
  %166 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 13), align 4, !dbg !230
  %167 = fmul float %165, %166, !dbg !236
  %168 = fsub float %153, %149, !dbg !219
  %169 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 11), align 4, !dbg !221
  %170 = fmul float %168, %169, !dbg !227
  %171 = fadd float %149, %153, !dbg !210
  %172 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 7), align 4, !dbg !212
  %173 = fmul float %171, %172, !dbg !218
  %174 = fsub float %145, %142, !dbg !196
  %175 = fsub float %148, %174, !dbg !228
  %176 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 14), align 4, !dbg !230
  %177 = fmul float %175, %176, !dbg !236
  %178 = fsub float %152, %148, !dbg !219
  %179 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 10), align 4, !dbg !221
  %180 = fmul float %178, %179, !dbg !227
  %181 = fadd float %148, %152, !dbg !210
  %182 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 6), align 4, !dbg !212
  %183 = fmul float %181, %182, !dbg !218
  %184 = fsub float %106, %101, !dbg !196
  %185 = fsub float %184, %152, !dbg !200
  %186 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 2), align 4, !dbg !202
  %187 = fmul float %185, %186, !dbg !208
  %188 = fsub float %150, %146, !dbg !219
  %189 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 8), align 4, !dbg !221
  %190 = fmul float %188, %189, !dbg !227
  %191 = fadd float %146, %150, !dbg !210
  %192 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 4), align 4, !dbg !212
  %193 = fmul float %191, %192, !dbg !218
  %194 = fadd float %193, %161, !dbg !237
  %195 = fadd float %194, %183, !dbg !237
  %196 = fsub float %161, %183, !dbg !241
  %197 = fsub float %196, %173, !dbg !241
  %198 = fadd float %190, %164, !dbg !237
  %199 = fadd float %198, %180, !dbg !237
  %200 = fsub float %164, %180, !dbg !241
  %201 = fsub float %200, %170, !dbg !241
  %202 = fsub float %167, %177, !dbg !241
  %203 = add nsw i64 %108, %139, !dbg !183
  %204 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %203, !dbg !188
  %205 = load float, float addrspace(3)* %204, align 4, !dbg !188
  %206 = fsub float %142, %205, !dbg !198
  %207 = fsub float %149, %206, !dbg !228
  %208 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 15), align 4, !dbg !230
  %209 = fmul float %207, %208, !dbg !236
  %210 = fsub float %202, %209, !dbg !241
  %211 = add nsw i64 %91, %139, !dbg !183
  %212 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %211, !dbg !188
  %213 = load float, float addrspace(3)* %212, align 4, !dbg !188
  %214 = fsub float %213, %145, !dbg !189
  %215 = fsub float %146, %214, !dbg !228
  %216 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 12), align 4, !dbg !230
  %217 = fmul float %215, %216, !dbg !236
  %218 = fadd float %217, %167, !dbg !237
  %219 = fadd float %218, %177, !dbg !237
  %220 = fsub float %158, %187, !dbg !241
  %221 = fsub float %101, %111, !dbg !198
  %222 = fsub float %221, %153, !dbg !200
  %223 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 3), align 4, !dbg !202
  %224 = fmul float %222, %223, !dbg !208
  %225 = fsub float %220, %224, !dbg !241
  %226 = fsub float %96, %106, !dbg !189
  %227 = fsub float %226, %150, !dbg !200
  %228 = load float, float addrspace(3)* getelementptr inbounds ([16 x float], [16 x float] addrspace(3)* @shmem4, i64 0, i64 0), align 4, !dbg !202
  %229 = fmul float %227, %228, !dbg !208
  %230 = fadd float %229, %158, !dbg !237
  %231 = fadd float %230, %187, !dbg !237
  %232 = fadd float %231, %195, !dbg !243
  %233 = fadd float %232, %199, !dbg !243
  %234 = fadd float %45, %233, !dbg !246
  %235 = fsub float %195, %199, !dbg !247
  %236 = fsub float %235, %219, !dbg !247
  %237 = fadd float %43, %236, !dbg !249
  %238 = fadd float %225, %197, !dbg !243
  %239 = fadd float %238, %201, !dbg !243
  %240 = fadd float %44, %239, !dbg !246
  %241 = fsub float %197, %201, !dbg !247
  %242 = fsub float %241, %210, !dbg !247
  %243 = fadd float %42, %242, !dbg !249
  %244 = icmp eq i64 %value_phi8.i, %5, !dbg !250
  %245 = add nuw i64 %value_phi8.i, 1, !dbg !252
  br i1 %244, label %L1127.L1132_crit_edge.i.loopexit, label %L121.i, !dbg !254

L1127.L1132_crit_edge.i.loopexit:                 ; preds = %L474.i
  %246 = bitcast float %243 to i32, !dbg !255
  %247 = bitcast float %240 to i32, !dbg !268
  %248 = bitcast float %237 to i32, !dbg !255
  %249 = bitcast float %234 to i32, !dbg !268
  br label %L1127.L1132_crit_edge.i, !dbg !273

L1127.L1132_crit_edge.i:                          ; preds = %after_srem.i.L1127.L1132_crit_edge.i_crit_edge, %L1127.L1132_crit_edge.i.loopexit
  %.pre-phi2368 = phi i64 [ %.pre2367, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %23, %L1127.L1132_crit_edge.i.loopexit ]
  %.pre-phi2366 = phi i64 [ %.pre2365, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %40, %L1127.L1132_crit_edge.i.loopexit ]
  %.pre-phi = phi i64 [ %.pre, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %16, %L1127.L1132_crit_edge.i.loopexit ]
  %.sroa.132350.1 = phi i32 [ 0, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %246, %L1127.L1132_crit_edge.i.loopexit ]
  %.sroa.9.1 = phi i32 [ 0, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %248, %L1127.L1132_crit_edge.i.loopexit ]
  %.sroa.5.1 = phi i32 [ 0, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %247, %L1127.L1132_crit_edge.i.loopexit ]
  %.sroa.02346.1 = phi i32 [ 0, %after_srem.i.L1127.L1132_crit_edge.i_crit_edge ], [ %249, %L1127.L1132_crit_edge.i.loopexit ]
  %.fca.0.0.extract = extractvalue { [4 x i64], { i64 } } %2, 0, 0
  %.fca.0.1.extract = extractvalue { [4 x i64], { i64 } } %2, 0, 1
  %.fca.0.2.extract = extractvalue { [4 x i64], { i64 } } %2, 0, 2
  %.fca.1.0.extract = extractvalue { [4 x i64], { i64 } } %2, 1, 0
  %250 = shl nuw nsw i32 %288, 1
  %251 = zext i32 %250 to i64
  %252 = icmp sgt i64 %.fca.0.0.extract, 0
  %253 = select i1 %252, i64 %.fca.0.0.extract, i64 0
  %254 = icmp sgt i64 %.fca.0.1.extract, 0
  %255 = select i1 %254, i64 %.fca.0.1.extract, i64 0
  %256 = icmp sgt i64 %.fca.0.2.extract, 0
  %257 = select i1 %256, i64 %.fca.0.2.extract, i64 0
  %258 = mul i64 %257, %287
  %259 = add i64 %258, -1
  %260 = inttoptr i64 %.fca.1.0.extract to float*
  %261 = or i64 %.pre-phi, 1
  %262 = add i64 %261, %.pre-phi2366
  %263 = icmp sgt i64 %262, %4
  br i1 %263, label %L1250.i, label %L1132.i.split.us, !dbg !273

L1132.i.split.us:                                 ; preds = %L1127.L1132_crit_edge.i
  %reass.add2277 = add i64 %259, %262
  %reass.mul2278 = mul i64 %reass.add2277, %255
  %264 = or i64 %281, 1, !dbg !274
  %265 = add i64 %264, %251, !dbg !274
  %266 = icmp sgt i64 %265, %3, !dbg !277
  br i1 %266, label %L1238.i.us, label %L1187.i.us, !dbg !279

L1187.i.us:                                       ; preds = %L1132.i.split.us
  %267 = add nsw i64 %265, -1, !dbg !280
  %reass.add2279.us = add i64 %267, %reass.mul2278
  %reass.mul2280.us = mul i64 %reass.add2279.us, %253
  %268 = add i64 %.pre-phi2368, %reass.mul2280.us, !dbg !290
  %269 = getelementptr float, float* %260, i64 %268, !dbg !295
  %270 = bitcast float* %269 to i32*, !dbg !295
  %271 = addrspacecast i32* %270 to i32 addrspace(1)*, !dbg !295
  store i32 %.sroa.02346.1, i32 addrspace(1)* %271, align 4, !dbg !295
  br label %L1238.i.us, !dbg !296

L1238.i.us:                                       ; preds = %L1132.i.split.us, %L1187.i.us
  %272 = or i64 %281, 2, !dbg !274
  %273 = add i64 %272, %251, !dbg !274
  %274 = icmp sgt i64 %273, %3, !dbg !277
  br i1 %274, label %L1250.i, label %L1187.i.us.1, !dbg !279

L1250.i:                                          ; preds = %L1238.i.us, %L1187.i.us.1, %L1127.L1132_crit_edge.i
  %275 = or i64 %.pre-phi, 2
  %276 = add i64 %275, %.pre-phi2366
  %277 = icmp sgt i64 %276, %4
  br i1 %277, label %L1250.i.1, label %L1132.i.split.us.1, !dbg !273

fail1.i:                                          ; preds = %entry
  call void @llvm.trap(), !dbg !298
  unreachable, !dbg !47

pass2.i:                                          ; preds = %entry
  %278 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !dbg !299, !range !309
  %279 = zext i32 %278 to i64, !dbg !310
  %cond = icmp eq i64 %12, -1, !dbg !311
  br i1 %cond, label %after_srem.i, label %oksrem.i, !dbg !311

oksrem.i:                                         ; preds = %pass2.i
  %280 = srem i64 %279, %12, !dbg !311
  %phitmp = shl i64 %280, 3, !dbg !311
  br label %after_srem.i, !dbg !311

after_srem.i:                                     ; preds = %pass2.i, %oksrem.i
  %281 = phi i64 [ %phitmp, %oksrem.i ], [ 0, %pass2.i ]
  %282 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y(), !dbg !312, !range !319
  %283 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x(), !dbg !320, !range !327
  %mulconv = mul nuw nsw i32 %283, %282, !dbg !328
  %284 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !dbg !329, !range !336
  %addconv = add nuw nsw i32 %284, 1, !dbg !337
  %addconv2181 = add nuw nsw i32 %addconv, %mulconv, !dbg !338
  %285 = zext i32 %addconv2181 to i64, !dbg !338
  %286 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.z(), !dbg !339, !range !319
  %287 = zext i32 %286 to i64, !dbg !346
  %288 = call i32 @llvm.nvvm.read.ptx.sreg.tid.z(), !dbg !347, !range !336
  %289 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y(), !dbg !353, !range !336
  %290 = sdiv i64 %279, %12, !dbg !47
  %291 = icmp sgt i64 %5, 0, !dbg !359
  br i1 %291, label %L116.L121_crit_edge.i, label %after_srem.i.L1127.L1132_crit_edge.i_crit_edge, !dbg !55

after_srem.i.L1127.L1132_crit_edge.i_crit_edge:   ; preds = %after_srem.i
  %.pre = shl i64 %290, 3
  %.pre2363 = shl nuw nsw i32 %289, 1
  %.pre2365 = zext i32 %.pre2363 to i64
  %.pre2367 = add nsw i64 %285, -1
  br label %L1127.L1132_crit_edge.i, !dbg !55

L1187.i.us.1:                                     ; preds = %L1238.i.us
  %292 = add i64 %273, -1, !dbg !280
  %reass.add2279.us.1 = add i64 %292, %reass.mul2278
  %reass.mul2280.us.1 = mul i64 %reass.add2279.us.1, %253
  %293 = add i64 %.pre-phi2368, %reass.mul2280.us.1, !dbg !290
  %294 = getelementptr float, float* %260, i64 %293, !dbg !295
  %295 = bitcast float* %294 to i32*, !dbg !295
  %296 = addrspacecast i32* %295 to i32 addrspace(1)*, !dbg !295
  store i32 %.sroa.5.1, i32 addrspace(1)* %296, align 4, !dbg !295
  br label %L1250.i, !dbg !296

L1132.i.split.us.1:                               ; preds = %L1250.i
  %reass.add2277.1 = add i64 %259, %276
  %reass.mul2278.1 = mul i64 %reass.add2277.1, %255
  %297 = or i64 %281, 1, !dbg !274
  %298 = add i64 %297, %251, !dbg !274
  %299 = icmp sgt i64 %298, %3, !dbg !277
  br i1 %299, label %L1238.i.us.12285, label %L1187.i.us.12284, !dbg !279

L1187.i.us.12284:                                 ; preds = %L1132.i.split.us.1
  %300 = add nsw i64 %298, -1, !dbg !280
  %reass.add2279.us.12282 = add i64 %300, %reass.mul2278.1
  %reass.mul2280.us.12283 = mul i64 %reass.add2279.us.12282, %253
  %301 = add i64 %.pre-phi2368, %reass.mul2280.us.12283, !dbg !290
  %302 = getelementptr float, float* %260, i64 %301, !dbg !295
  %303 = bitcast float* %302 to i32*, !dbg !295
  %304 = addrspacecast i32* %303 to i32 addrspace(1)*, !dbg !295
  store i32 %.sroa.9.1, i32 addrspace(1)* %304, align 4, !dbg !295
  br label %L1238.i.us.12285, !dbg !296

L1238.i.us.12285:                                 ; preds = %L1187.i.us.12284, %L1132.i.split.us.1
  %305 = or i64 %281, 2, !dbg !274
  %306 = add i64 %305, %251, !dbg !274
  %307 = icmp sgt i64 %306, %3, !dbg !277
  br i1 %307, label %L1250.i.1, label %L1187.i.us.1.1, !dbg !279

L1187.i.us.1.1:                                   ; preds = %L1238.i.us.12285
  %308 = add i64 %306, -1, !dbg !280
  %reass.add2279.us.1.1 = add i64 %308, %reass.mul2278.1
  %reass.mul2280.us.1.1 = mul i64 %reass.add2279.us.1.1, %253
  %309 = add i64 %.pre-phi2368, %reass.mul2280.us.1.1, !dbg !290
  %310 = getelementptr float, float* %260, i64 %309, !dbg !295
  %311 = bitcast float* %310 to i32*, !dbg !295
  %312 = addrspacecast i32* %311 to i32 addrspace(1)*, !dbg !295
  store i32 %.sroa.132350.1, i32 addrspace(1)* %312, align 4, !dbg !295
  br label %L1250.i.1, !dbg !296

L1250.i.1:                                        ; preds = %L1250.i, %L1238.i.us.12285, %L1187.i.us.1.1
  ret void

L206.i.us.1:                                      ; preds = %L366.i.us
  %313 = add nuw nsw i64 %14, 3, !dbg !60
  %314 = add i64 %313, %281, !dbg !62
  %315 = icmp slt i64 %314, 1, !dbg !63
  %316 = icmp sgt i64 %314, %3, !dbg !65
  %spec.select.not.us.1 = or i1 %315, %316, !dbg !67
  %or.cond.us.1 = or i1 %52, %spec.select.not.us.1, !dbg !67
  %or.cond.not.us.1 = xor i1 %or.cond.us.1, true, !dbg !67
  %or.cond2270.us.1 = and i1 %53, %or.cond.not.us.1, !dbg !67
  br i1 %or.cond2270.us.1, label %L231.i.us.1, label %L320.i.us.1, !dbg !67

L320.i.us.1:                                      ; preds = %L206.i.us.1
  %317 = shl nuw nsw i64 %79, 5, !dbg !68
  %318 = add i64 %56, %317, !dbg !83
  %319 = add i64 %318, %25, !dbg !85
  %320 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %319, !dbg !97
  store float 0.000000e+00, float addrspace(3)* %320, align 4, !dbg !97
  br label %L366.i.us.1, !dbg !98

L231.i.us.1:                                      ; preds = %L206.i.us.1
  %321 = add i64 %314, -1, !dbg !102
  %reass.add2271.us.1 = add i64 %321, %reass.mul
  %reass.mul2272.us.1 = mul i64 %reass.add2271.us.1, %18
  %322 = add i64 %23, %reass.mul2272.us.1, !dbg !115
  %323 = getelementptr float, float* %24, i64 %322, !dbg !122
  %324 = bitcast float* %323 to i32*, !dbg !122
  %325 = addrspacecast i32* %324 to i32 addrspace(1)*, !dbg !122
  %326 = load i32, i32 addrspace(1)* %325, align 4, !dbg !122
  %327 = shl nuw nsw i64 %79, 5, !dbg !123
  %328 = add i64 %56, %327, !dbg !131
  %329 = add i64 %328, %25, !dbg !133
  %330 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %329, !dbg !138
  %331 = bitcast float addrspace(3)* %330 to i32 addrspace(3)*, !dbg !138
  store i32 %326, i32 addrspace(3)* %331, align 4, !dbg !138
  br label %L366.i.us.1, !dbg !139

L366.i.us.1:                                      ; preds = %L231.i.us.1, %L320.i.us.1, %L366.i.us
  %332 = add nuw nsw i64 %14, 8, !dbg !140
  %333 = icmp ult i64 %332, 10, !dbg !57
  br i1 %333, label %L206.i.us.2, label %L378.i, !dbg !59

L206.i.us.2:                                      ; preds = %L366.i.us.1
  %334 = add nuw nsw i64 %14, 7, !dbg !60
  %335 = add i64 %334, %281, !dbg !62
  %336 = icmp slt i64 %335, 1, !dbg !63
  %337 = icmp sgt i64 %335, %3, !dbg !65
  %spec.select.not.us.2 = or i1 %336, %337, !dbg !67
  %or.cond.us.2 = or i1 %52, %spec.select.not.us.2, !dbg !67
  %or.cond.not.us.2 = xor i1 %or.cond.us.2, true, !dbg !67
  %or.cond2270.us.2 = and i1 %53, %or.cond.not.us.2, !dbg !67
  br i1 %or.cond2270.us.2, label %L231.i.us.2, label %L320.i.us.2, !dbg !67

L320.i.us.2:                                      ; preds = %L206.i.us.2
  %338 = shl nuw nsw i64 %332, 5, !dbg !68
  %339 = add i64 %56, %338, !dbg !83
  %340 = add i64 %339, %25, !dbg !85
  %341 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %340, !dbg !97
  store float 0.000000e+00, float addrspace(3)* %341, align 4, !dbg !97
  br label %L378.i, !dbg !98

L231.i.us.2:                                      ; preds = %L206.i.us.2
  %342 = add i64 %335, -1, !dbg !102
  %reass.add2271.us.2 = add i64 %342, %reass.mul
  %reass.mul2272.us.2 = mul i64 %reass.add2271.us.2, %18
  %343 = add i64 %23, %reass.mul2272.us.2, !dbg !115
  %344 = getelementptr float, float* %24, i64 %343, !dbg !122
  %345 = bitcast float* %344 to i32*, !dbg !122
  %346 = addrspacecast i32* %345 to i32 addrspace(1)*, !dbg !122
  %347 = load i32, i32 addrspace(1)* %346, align 4, !dbg !122
  %348 = shl nuw nsw i64 %332, 5, !dbg !123
  %349 = add i64 %56, %348, !dbg !131
  %350 = add i64 %349, %25, !dbg !133
  %351 = getelementptr [3200 x float], [3200 x float] addrspace(3)* @shmem3, i64 0, i64 %350, !dbg !138
  %352 = bitcast float addrspace(3)* %351 to i32 addrspace(3)*, !dbg !138
  store i32 %347, i32 addrspace(3)* %352, align 4, !dbg !138
  br label %L378.i, !dbg !139
}

declare noalias nonnull %jl_value_t addrspace(10)* @jl_gc_pool_alloc(i8*, i32, i32)

declare noalias nonnull %jl_value_t addrspace(10)* @jl_gc_big_alloc(i8*, i64)

attributes #0 = { convergent nounwind }
attributes #1 = { noreturn nounwind }
attributes #2 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.dbg.cu = !{!1, !4}
!nvvm.annotations = !{!6}

!0 = !{i32 1, !"Debug Info Version", i32 3}
!1 = distinct !DICompileUnit(language: DW_LANG_C89, file: !2, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !3)
!2 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/CUDAnative/2VhK/src/execution.jl", directory: ".")
!3 = !{}
!4 = distinct !DICompileUnit(language: DW_LANG_C89, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !3)
!5 = !DIFile(filename: "/home/jerrylingjiemei/Winograd/conv_2d_cuda.jl", directory: ".")
!6 = !{void ({ [4 x i64], { i64 } }, { [4 x i64], { i64 } }, { [4 x i64], { i64 } }, i64, i64, i64)* @ptxcall_Kernel_5, !"kernel", i32 1}
!7 = !DILocation(line: 232, scope: !8, inlinedAt: !11)
!8 = distinct !DISubprogram(name: "div;", linkageName: "div", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!9 = !DIFile(filename: "int.jl", directory: ".")
!10 = !DISubroutineType(types: !3)
!11 = distinct !DILocation(line: 251, scope: !12, inlinedAt: !13)
!12 = distinct !DISubprogram(name: "cld;", linkageName: "cld", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!13 = distinct !DILocation(line: 207, scope: !14, inlinedAt: !15)
!14 = distinct !DISubprogram(name: "img_trans_kernel", linkageName: "julia_img_trans_kernel_36682", scope: null, file: !5, line: 203, type: !10, isLocal: false, isDefinition: true, scopeLine: 203, isOptimized: true, unit: !4, variables: !3)
!15 = distinct !DILocation(line: 56, scope: !16)
!16 = distinct !DISubprogram(name: "Kernel", linkageName: "julia_Kernel_36681", scope: null, file: !2, line: 56, type: !10, isLocal: false, isDefinition: true, scopeLine: 56, isOptimized: true, unit: !1, variables: !3)
!17 = !DILocation(line: 49, scope: !18, inlinedAt: !19)
!18 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!19 = distinct !DILocation(line: 286, scope: !20, inlinedAt: !22)
!20 = distinct !DISubprogram(name: ">;", linkageName: ">", scope: !21, file: !21, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!21 = !DIFile(filename: "operators.jl", directory: ".")
!22 = distinct !DILocation(line: 252, scope: !12, inlinedAt: !13)
!23 = !DILocation(line: 54, scope: !24, inlinedAt: !22)
!24 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!25 = !DILocation(line: 425, scope: !26, inlinedAt: !28)
!26 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !27, file: !27, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!27 = !DIFile(filename: "promotion.jl", directory: ".")
!28 = distinct !DILocation(line: 185, scope: !29, inlinedAt: !22)
!29 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !21, file: !21, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!30 = !DILocation(line: 40, scope: !31, inlinedAt: !22)
!31 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !32, file: !32, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!32 = !DIFile(filename: "bool.jl", directory: ".")
!33 = !DILocation(line: 650, scope: !34, inlinedAt: !36)
!34 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !35, file: !35, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!35 = !DIFile(filename: "boot.jl", directory: ".")
!36 = distinct !DILocation(line: 723, scope: !37, inlinedAt: !38)
!37 = distinct !DISubprogram(name: "Type;", linkageName: "Type", scope: !35, file: !35, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!38 = distinct !DILocation(line: 7, scope: !39, inlinedAt: !41)
!39 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !40, file: !40, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!40 = !DIFile(filename: "number.jl", directory: ".")
!41 = distinct !DILocation(line: 460, scope: !42, inlinedAt: !43)
!42 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!43 = distinct !DILocation(line: 767, scope: !44, inlinedAt: !22)
!44 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!45 = !DILocation(line: 53, scope: !44, inlinedAt: !46)
!46 = distinct !DILocation(line: 769, scope: !44, inlinedAt: !22)
!47 = !DILocation(line: 232, scope: !8, inlinedAt: !48)
!48 = distinct !DILocation(line: 105, scope: !49, inlinedAt: !13)
!49 = distinct !DISubprogram(name: "divrem;", linkageName: "divrem", scope: !40, file: !40, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!50 = !DILocation(line: 52, scope: !51, inlinedAt: !52)
!51 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!52 = distinct !DILocation(line: 205, scope: !14, inlinedAt: !15)
!53 = !DILocation(line: 52, scope: !51, inlinedAt: !54)
!54 = distinct !DILocation(line: 206, scope: !14, inlinedAt: !15)
!55 = !DILocation(line: 213, scope: !14, inlinedAt: !15)
!56 = !DILocation(line: 214, scope: !14, inlinedAt: !15)
!57 = !DILocation(line: 49, scope: !18, inlinedAt: !58)
!58 = distinct !DILocation(line: 215, scope: !14, inlinedAt: !15)
!59 = !DILocation(line: 215, scope: !14, inlinedAt: !15)
!60 = !DILocation(line: 52, scope: !51, inlinedAt: !61)
!61 = distinct !DILocation(line: 217, scope: !14, inlinedAt: !15)
!62 = !DILocation(line: 53, scope: !44, inlinedAt: !61)
!63 = !DILocation(line: 49, scope: !18, inlinedAt: !64)
!64 = distinct !DILocation(line: 218, scope: !14, inlinedAt: !15)
!65 = !DILocation(line: 428, scope: !66, inlinedAt: !64)
!66 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !9, file: !9, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!67 = !DILocation(line: 218, scope: !14, inlinedAt: !15)
!68 = !DILocation(line: 54, scope: !24, inlinedAt: !69)
!69 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "_sub2ind_recurse;", linkageName: "_sub2ind_recurse", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!71 = !DIFile(filename: "abstractarray.jl", directory: ".")
!72 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !73)
!73 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "_sub2ind;", linkageName: "_sub2ind", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!75 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !76)
!76 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !78)
!77 = distinct !DISubprogram(name: "_to_linear_index;", linkageName: "_to_linear_index", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!78 = distinct !DILocation(line: 1020, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "_setindex!;", linkageName: "_setindex!", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!80 = distinct !DILocation(line: 997, scope: !81, inlinedAt: !82)
!81 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!82 = distinct !DILocation(line: 221, scope: !14, inlinedAt: !15)
!83 = !DILocation(line: 53, scope: !44, inlinedAt: !84)
!84 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !69)
!85 = !DILocation(line: 52, scope: !51, inlinedAt: !86)
!86 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !88, file: !88, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!88 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/LLVM/llze/src/interop/base.jl", directory: ".")
!89 = distinct !DILocation(line: 132, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "@generated body;", linkageName: "@generated body", scope: !91, file: !91, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!91 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/CUDAnative/2VhK/src/pointer.jl", directory: ".")
!92 = distinct !DILocation(line: 132, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !91, file: !91, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!94 = distinct !DILocation(line: 84, scope: !95, inlinedAt: !78)
!95 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !96, file: !96, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!96 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/CUDAnative/2VhK/src/device/array.jl", directory: ".")
!97 = !DILocation(line: 42, scope: !87, inlinedAt: !89)
!98 = !DILocation(line: 425, scope: !26, inlinedAt: !99)
!99 = distinct !DILocation(line: 465, scope: !100, inlinedAt: !82)
!100 = distinct !DISubprogram(name: "iterate;", linkageName: "iterate", scope: !101, file: !101, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!101 = !DIFile(filename: "range.jl", directory: ".")
!102 = !DILocation(line: 52, scope: !51, inlinedAt: !103)
!103 = distinct !DILocation(line: 1728, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "offsetin;", linkageName: "offsetin", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!105 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !106)
!106 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !107)
!107 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !108)
!108 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !109)
!109 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !110)
!110 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "_getindex;", linkageName: "_getindex", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!112 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !71, file: !71, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!114 = distinct !DILocation(line: 219, scope: !14, inlinedAt: !15)
!115 = !DILocation(line: 52, scope: !51, inlinedAt: !116)
!116 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !117)
!117 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !118)
!118 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !91, file: !91, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!120 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !110)
!121 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !96, file: !96, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!122 = !DILocation(line: 42, scope: !87, inlinedAt: !117)
!123 = !DILocation(line: 54, scope: !24, inlinedAt: !124)
!124 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !125)
!125 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !126)
!126 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !127)
!127 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !128)
!128 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !129)
!129 = distinct !DILocation(line: 1020, scope: !79, inlinedAt: !130)
!130 = distinct !DILocation(line: 997, scope: !81, inlinedAt: !114)
!131 = !DILocation(line: 53, scope: !44, inlinedAt: !132)
!132 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !124)
!133 = !DILocation(line: 52, scope: !51, inlinedAt: !134)
!134 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !135)
!135 = distinct !DILocation(line: 132, scope: !90, inlinedAt: !136)
!136 = distinct !DILocation(line: 132, scope: !93, inlinedAt: !137)
!137 = distinct !DILocation(line: 84, scope: !95, inlinedAt: !129)
!138 = !DILocation(line: 42, scope: !87, inlinedAt: !135)
!139 = !DILocation(line: 219, scope: !14, inlinedAt: !15)
!140 = !DILocation(line: 53, scope: !44, inlinedAt: !58)
!141 = !DILocation(line: 53, scope: !44, inlinedAt: !142)
!142 = distinct !DILocation(line: 466, scope: !100, inlinedAt: !82)
!143 = !DILocation(line: 221, scope: !14, inlinedAt: !15)
!144 = !DILocation(line: 225, scope: !14, inlinedAt: !15)
!145 = !DILocation(line: 54, scope: !24, inlinedAt: !146)
!146 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !147)
!147 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !148)
!148 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !149)
!149 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !150)
!150 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !151)
!151 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !152)
!152 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !153)
!153 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !154)
!154 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !155)
!155 = distinct !DILocation(line: 226, scope: !14, inlinedAt: !15)
!156 = !DILocation(line: 52, scope: !51, inlinedAt: !157)
!157 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !158)
!158 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !159)
!159 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !160)
!160 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !153)
!161 = !DILocation(line: 42, scope: !87, inlinedAt: !158)
!162 = !DILocation(line: 42, scope: !87, inlinedAt: !163)
!163 = distinct !DILocation(line: 132, scope: !90, inlinedAt: !164)
!164 = distinct !DILocation(line: 132, scope: !93, inlinedAt: !165)
!165 = distinct !DILocation(line: 84, scope: !95, inlinedAt: !166)
!166 = distinct !DILocation(line: 1020, scope: !79, inlinedAt: !167)
!167 = distinct !DILocation(line: 997, scope: !81, inlinedAt: !155)
!168 = !DILocation(line: 12, scope: !169, inlinedAt: !171)
!169 = distinct !DISubprogram(name: "sync_threads;", linkageName: "sync_threads", scope: !170, file: !170, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!170 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/CUDAnative/2VhK/src/device/intrinsics/synchronization.jl", directory: ".")
!171 = distinct !DILocation(line: 228, scope: !14, inlinedAt: !15)
!172 = !DILocation(line: 54, scope: !24, inlinedAt: !173)
!173 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !174)
!174 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !175)
!175 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !176)
!176 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !177)
!177 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !178)
!178 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !179)
!179 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !180)
!180 = distinct !DILocation(line: 230, scope: !14, inlinedAt: !15)
!181 = !DILocation(line: 53, scope: !44, inlinedAt: !182)
!182 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !173)
!183 = !DILocation(line: 52, scope: !51, inlinedAt: !184)
!184 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !185)
!185 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !186)
!186 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !187)
!187 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !178)
!188 = !DILocation(line: 42, scope: !87, inlinedAt: !185)
!189 = !DILocation(line: 396, scope: !190, inlinedAt: !192)
!190 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !191, file: !191, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!191 = !DIFile(filename: "float.jl", directory: ".")
!192 = distinct !DILocation(line: 233, scope: !14, inlinedAt: !15)
!193 = !DILocation(line: 394, scope: !194, inlinedAt: !195)
!194 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !191, file: !191, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!195 = distinct !DILocation(line: 234, scope: !14, inlinedAt: !15)
!196 = !DILocation(line: 396, scope: !190, inlinedAt: !197)
!197 = distinct !DILocation(line: 235, scope: !14, inlinedAt: !15)
!198 = !DILocation(line: 396, scope: !190, inlinedAt: !199)
!199 = distinct !DILocation(line: 236, scope: !14, inlinedAt: !15)
!200 = !DILocation(line: 396, scope: !190, inlinedAt: !201)
!201 = distinct !DILocation(line: 239, scope: !14, inlinedAt: !15)
!202 = !DILocation(line: 42, scope: !87, inlinedAt: !203)
!203 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !204)
!204 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !205)
!205 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !206)
!206 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !207)
!207 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !201)
!208 = !DILocation(line: 398, scope: !209, inlinedAt: !201)
!209 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !191, file: !191, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!210 = !DILocation(line: 394, scope: !194, inlinedAt: !211)
!211 = distinct !DILocation(line: 240, scope: !14, inlinedAt: !15)
!212 = !DILocation(line: 42, scope: !87, inlinedAt: !213)
!213 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !214)
!214 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !215)
!215 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !216)
!216 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !217)
!217 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !211)
!218 = !DILocation(line: 398, scope: !209, inlinedAt: !211)
!219 = !DILocation(line: 396, scope: !190, inlinedAt: !220)
!220 = distinct !DILocation(line: 241, scope: !14, inlinedAt: !15)
!221 = !DILocation(line: 42, scope: !87, inlinedAt: !222)
!222 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !223)
!223 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !224)
!224 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !225)
!225 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !226)
!226 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !220)
!227 = !DILocation(line: 398, scope: !209, inlinedAt: !220)
!228 = !DILocation(line: 396, scope: !190, inlinedAt: !229)
!229 = distinct !DILocation(line: 242, scope: !14, inlinedAt: !15)
!230 = !DILocation(line: 42, scope: !87, inlinedAt: !231)
!231 = distinct !DILocation(line: 102, scope: !90, inlinedAt: !232)
!232 = distinct !DILocation(line: 102, scope: !119, inlinedAt: !233)
!233 = distinct !DILocation(line: 78, scope: !121, inlinedAt: !234)
!234 = distinct !DILocation(line: 927, scope: !111, inlinedAt: !235)
!235 = distinct !DILocation(line: 904, scope: !113, inlinedAt: !229)
!236 = !DILocation(line: 398, scope: !209, inlinedAt: !229)
!237 = !DILocation(line: 394, scope: !194, inlinedAt: !238)
!238 = distinct !DILocation(line: 469, scope: !239, inlinedAt: !240)
!239 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !21, file: !21, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!240 = distinct !DILocation(line: 245, scope: !14, inlinedAt: !15)
!241 = !DILocation(line: 396, scope: !190, inlinedAt: !242)
!242 = distinct !DILocation(line: 246, scope: !14, inlinedAt: !15)
!243 = !DILocation(line: 394, scope: !194, inlinedAt: !244)
!244 = distinct !DILocation(line: 469, scope: !239, inlinedAt: !245)
!245 = distinct !DILocation(line: 249, scope: !14, inlinedAt: !15)
!246 = !DILocation(line: 394, scope: !194, inlinedAt: !245)
!247 = !DILocation(line: 396, scope: !190, inlinedAt: !248)
!248 = distinct !DILocation(line: 250, scope: !14, inlinedAt: !15)
!249 = !DILocation(line: 394, scope: !194, inlinedAt: !248)
!250 = !DILocation(line: 425, scope: !26, inlinedAt: !251)
!251 = distinct !DILocation(line: 465, scope: !100, inlinedAt: !248)
!252 = !DILocation(line: 53, scope: !44, inlinedAt: !253)
!253 = distinct !DILocation(line: 466, scope: !100, inlinedAt: !248)
!254 = !DILocation(line: 250, scope: !14, inlinedAt: !15)
!255 = !DILocation(line: 118, scope: !256, inlinedAt: !258)
!256 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !257, file: !257, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!257 = !DIFile(filename: "pointer.jl", directory: ".")
!258 = distinct !DILocation(line: 92, scope: !259, inlinedAt: !261)
!259 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !260, file: !260, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!260 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/StaticArrays/86zB/src/MMatrix.jl", directory: ".")
!261 = distinct !DILocation(line: 49, scope: !262, inlinedAt: !264)
!262 = distinct !DISubprogram(name: "@generated body;", linkageName: "@generated body", scope: !263, file: !263, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!263 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/StaticArrays/86zB/src/indexing.jl", directory: ".")
!264 = distinct !DILocation(line: 37, scope: !265, inlinedAt: !266)
!265 = distinct !DISubprogram(name: "_setindex!_scalar;", linkageName: "_setindex!_scalar", scope: !263, file: !263, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!266 = distinct !DILocation(line: 33, scope: !267, inlinedAt: !248)
!267 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !263, file: !263, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!268 = !DILocation(line: 118, scope: !256, inlinedAt: !269)
!269 = distinct !DILocation(line: 92, scope: !259, inlinedAt: !270)
!270 = distinct !DILocation(line: 49, scope: !262, inlinedAt: !271)
!271 = distinct !DILocation(line: 37, scope: !265, inlinedAt: !272)
!272 = distinct !DILocation(line: 33, scope: !267, inlinedAt: !245)
!273 = !DILocation(line: 253, scope: !14, inlinedAt: !15)
!274 = !DILocation(line: 53, scope: !44, inlinedAt: !275)
!275 = distinct !DILocation(line: 469, scope: !239, inlinedAt: !276)
!276 = distinct !DILocation(line: 254, scope: !14, inlinedAt: !15)
!277 = !DILocation(line: 428, scope: !66, inlinedAt: !278)
!278 = distinct !DILocation(line: 256, scope: !14, inlinedAt: !15)
!279 = !DILocation(line: 256, scope: !14, inlinedAt: !15)
!280 = !DILocation(line: 52, scope: !51, inlinedAt: !281)
!281 = distinct !DILocation(line: 1728, scope: !104, inlinedAt: !282)
!282 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !283)
!283 = distinct !DILocation(line: 1721, scope: !70, inlinedAt: !284)
!284 = distinct !DILocation(line: 1705, scope: !74, inlinedAt: !285)
!285 = distinct !DILocation(line: 1689, scope: !74, inlinedAt: !286)
!286 = distinct !DILocation(line: 933, scope: !77, inlinedAt: !287)
!287 = distinct !DILocation(line: 1020, scope: !79, inlinedAt: !288)
!288 = distinct !DILocation(line: 997, scope: !81, inlinedAt: !289)
!289 = distinct !DILocation(line: 257, scope: !14, inlinedAt: !15)
!290 = !DILocation(line: 52, scope: !51, inlinedAt: !291)
!291 = distinct !DILocation(line: 42, scope: !87, inlinedAt: !292)
!292 = distinct !DILocation(line: 132, scope: !90, inlinedAt: !293)
!293 = distinct !DILocation(line: 132, scope: !93, inlinedAt: !294)
!294 = distinct !DILocation(line: 84, scope: !95, inlinedAt: !287)
!295 = !DILocation(line: 42, scope: !87, inlinedAt: !292)
!296 = !DILocation(line: 425, scope: !26, inlinedAt: !297)
!297 = distinct !DILocation(line: 465, scope: !100, inlinedAt: !289)
!298 = !DILocation(line: 203, scope: !14, inlinedAt: !15)
!299 = !DILocation(line: 42, scope: !87, inlinedAt: !300)
!300 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !303)
!301 = distinct !DISubprogram(name: "@generated body;", linkageName: "@generated body", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!302 = !DIFile(filename: "/home/jerrylingjiemei/.julia/packages/CUDAnative/2VhK/src/device/intrinsics/indexing.jl", directory: ".")
!303 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !305)
!304 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!305 = distinct !DILocation(line: 55, scope: !306, inlinedAt: !307)
!306 = distinct !DISubprogram(name: "blockIdx_x;", linkageName: "blockIdx_x", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!307 = distinct !DILocation(line: 75, scope: !308, inlinedAt: !13)
!308 = distinct !DISubprogram(name: "blockIdx;", linkageName: "blockIdx", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!309 = !{i32 0, i32 2147483646}
!310 = !DILocation(line: 52, scope: !51, inlinedAt: !13)
!311 = !DILocation(line: 233, scope: !42, inlinedAt: !48)
!312 = !DILocation(line: 42, scope: !87, inlinedAt: !313)
!313 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !314)
!314 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !315)
!315 = distinct !DILocation(line: 55, scope: !316, inlinedAt: !317)
!316 = distinct !DISubprogram(name: "blockIdx_y;", linkageName: "blockIdx_y", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!317 = distinct !DILocation(line: 75, scope: !308, inlinedAt: !318)
!318 = distinct !DILocation(line: 203, scope: !14, inlinedAt: !15)
!319 = !{i32 0, i32 65534}
!320 = !DILocation(line: 42, scope: !87, inlinedAt: !321)
!321 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !322)
!322 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !323)
!323 = distinct !DILocation(line: 50, scope: !324, inlinedAt: !325)
!324 = distinct !DISubprogram(name: "blockDim_x;", linkageName: "blockDim_x", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!325 = distinct !DILocation(line: 82, scope: !326, inlinedAt: !318)
!326 = distinct !DISubprogram(name: "blockDim;", linkageName: "blockDim", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!327 = !{i32 1, i32 1024}
!328 = !DILocation(line: 54, scope: !24, inlinedAt: !318)
!329 = !DILocation(line: 42, scope: !87, inlinedAt: !330)
!330 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !331)
!331 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !332)
!332 = distinct !DILocation(line: 45, scope: !333, inlinedAt: !334)
!333 = distinct !DISubprogram(name: "threadIdx_x;", linkageName: "threadIdx_x", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!334 = distinct !DILocation(line: 89, scope: !335, inlinedAt: !318)
!335 = distinct !DISubprogram(name: "threadIdx;", linkageName: "threadIdx", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!336 = !{i32 0, i32 1023}
!337 = !DILocation(line: 53, scope: !44, inlinedAt: !332)
!338 = !DILocation(line: 53, scope: !44, inlinedAt: !318)
!339 = !DILocation(line: 42, scope: !87, inlinedAt: !340)
!340 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !341)
!341 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !342)
!342 = distinct !DILocation(line: 55, scope: !343, inlinedAt: !344)
!343 = distinct !DISubprogram(name: "blockIdx_z;", linkageName: "blockIdx_z", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!344 = distinct !DILocation(line: 75, scope: !308, inlinedAt: !345)
!345 = distinct !DILocation(line: 204, scope: !14, inlinedAt: !15)
!346 = !DILocation(line: 52, scope: !51, inlinedAt: !345)
!347 = !DILocation(line: 42, scope: !87, inlinedAt: !348)
!348 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !349)
!349 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !350)
!350 = distinct !DILocation(line: 45, scope: !351, inlinedAt: !352)
!351 = distinct !DISubprogram(name: "threadIdx_z;", linkageName: "threadIdx_z", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!352 = distinct !DILocation(line: 89, scope: !335, inlinedAt: !52)
!353 = !DILocation(line: 42, scope: !87, inlinedAt: !354)
!354 = distinct !DILocation(line: 8, scope: !301, inlinedAt: !355)
!355 = distinct !DILocation(line: 8, scope: !304, inlinedAt: !356)
!356 = distinct !DILocation(line: 45, scope: !357, inlinedAt: !358)
!357 = distinct !DISubprogram(name: "threadIdx_y;", linkageName: "threadIdx_y", scope: !302, file: !302, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!358 = distinct !DILocation(line: 89, scope: !335, inlinedAt: !54)
!359 = !DILocation(line: 428, scope: !66, inlinedAt: !360)
!360 = distinct !DILocation(line: 333, scope: !361, inlinedAt: !362)
!361 = distinct !DISubprogram(name: ">=;", linkageName: ">=", scope: !21, file: !21, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!362 = distinct !DILocation(line: 190, scope: !363, inlinedAt: !364)
!363 = distinct !DISubprogram(name: "unitrange_last;", linkageName: "unitrange_last", scope: !101, file: !101, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!364 = distinct !DILocation(line: 185, scope: !365, inlinedAt: !366)
!365 = distinct !DISubprogram(name: "Type;", linkageName: "Type", scope: !101, file: !101, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!366 = distinct !DILocation(line: 5, scope: !367, inlinedAt: !368)
!367 = distinct !DISubprogram(name: "Colon;", linkageName: "Colon", scope: !101, file: !101, type: !10, isLocal: false, isDefinition: true, isOptimized: true, unit: !4, variables: !3)
!368 = distinct !DILocation(line: 213, scope: !14, inlinedAt: !15)
