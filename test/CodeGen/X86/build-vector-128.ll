; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=SSE-32 --check-prefix=SSE2-32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=SSE-64 --check-prefix=SSE2-64
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE-32 --check-prefix=SSE41-32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE-64 --check-prefix=SSE41-64
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX-32 --check-prefix=AVX1-32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX-64 --check-prefix=AVX1-64
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX-32 --check-prefix=AVX2-32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX-64 --check-prefix=AVX2-64

define <2 x double> @test_buildvector_v2f64(double %a0, double %a1) {
; SSE-32-LABEL: test_buildvector_v2f64:
; SSE-32:       # BB#0:
; SSE-32-NEXT:    movups {{[0-9]+}}(%esp), %xmm0
; SSE-32-NEXT:    retl
;
; SSE-64-LABEL: test_buildvector_v2f64:
; SSE-64:       # BB#0:
; SSE-64-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v2f64:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovups {{[0-9]+}}(%esp), %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v2f64:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-64-NEXT:    retq
  %ins0 = insertelement <2 x double> undef, double %a0, i32 0
  %ins1 = insertelement <2 x double> %ins0, double %a1, i32 1
  ret <2 x double> %ins1
}

define <4 x float> @test_buildvector_v4f32(float %a0, float %a1, float %a2, float %a3) {
; SSE-32-LABEL: test_buildvector_v4f32:
; SSE-32:       # BB#0:
; SSE-32-NEXT:    movups {{[0-9]+}}(%esp), %xmm0
; SSE-32-NEXT:    retl
;
; SSE2-64-LABEL: test_buildvector_v4f32:
; SSE2-64:       # BB#0:
; SSE2-64-NEXT:    unpcklps {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; SSE2-64-NEXT:    unpcklps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-64-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; SSE2-64-NEXT:    retq
;
; SSE41-64-LABEL: test_buildvector_v4f32:
; SSE41-64:       # BB#0:
; SSE41-64-NEXT:    insertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; SSE41-64-NEXT:    insertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; SSE41-64-NEXT:    insertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; SSE41-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v4f32:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovups {{[0-9]+}}(%esp), %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v4f32:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; AVX-64-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; AVX-64-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; AVX-64-NEXT:    retq
  %ins0 = insertelement <4 x float> undef, float %a0, i32 0
  %ins1 = insertelement <4 x float> %ins0, float %a1, i32 1
  %ins2 = insertelement <4 x float> %ins1, float %a2, i32 2
  %ins3 = insertelement <4 x float> %ins2, float %a3, i32 3
  ret <4 x float> %ins3
}

define <2 x i64> @test_buildvector_v2i64(i64 %a0, i64 %a1) {
; SSE-32-LABEL: test_buildvector_v2i64:
; SSE-32:       # BB#0:
; SSE-32-NEXT:    movups {{[0-9]+}}(%esp), %xmm0
; SSE-32-NEXT:    retl
;
; SSE-64-LABEL: test_buildvector_v2i64:
; SSE-64:       # BB#0:
; SSE-64-NEXT:    movq %rsi, %xmm1
; SSE-64-NEXT:    movq %rdi, %xmm0
; SSE-64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v2i64:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovups {{[0-9]+}}(%esp), %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v2i64:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vmovq %rsi, %xmm0
; AVX-64-NEXT:    vmovq %rdi, %xmm1
; AVX-64-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-64-NEXT:    retq
  %ins0 = insertelement <2 x i64> undef, i64 %a0, i32 0
  %ins1 = insertelement <2 x i64> %ins0, i64 %a1, i32 1
  ret <2 x i64> %ins1
}

define <4 x i32> @test_buildvector_v4i32(i32 %f0, i32 %f1, i32 %f2, i32 %f3) {
; SSE-32-LABEL: test_buildvector_v4i32:
; SSE-32:       # BB#0:
; SSE-32-NEXT:    movups {{[0-9]+}}(%esp), %xmm0
; SSE-32-NEXT:    retl
;
; SSE2-64-LABEL: test_buildvector_v4i32:
; SSE2-64:       # BB#0:
; SSE2-64-NEXT:    movd %ecx, %xmm0
; SSE2-64-NEXT:    movd %edx, %xmm1
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-64-NEXT:    movd %esi, %xmm2
; SSE2-64-NEXT:    movd %edi, %xmm0
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-64-NEXT:    retq
;
; SSE41-64-LABEL: test_buildvector_v4i32:
; SSE41-64:       # BB#0:
; SSE41-64-NEXT:    movd %edi, %xmm0
; SSE41-64-NEXT:    pinsrd $1, %esi, %xmm0
; SSE41-64-NEXT:    pinsrd $2, %edx, %xmm0
; SSE41-64-NEXT:    pinsrd $3, %ecx, %xmm0
; SSE41-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v4i32:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovups {{[0-9]+}}(%esp), %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v4i32:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vmovd %edi, %xmm0
; AVX-64-NEXT:    vpinsrd $1, %esi, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrd $2, %edx, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrd $3, %ecx, %xmm0, %xmm0
; AVX-64-NEXT:    retq
  %ins0 = insertelement <4 x i32> undef, i32 %f0, i32 0
  %ins1 = insertelement <4 x i32> %ins0, i32 %f1, i32 1
  %ins2 = insertelement <4 x i32> %ins1, i32 %f2, i32 2
  %ins3 = insertelement <4 x i32> %ins2, i32 %f3, i32 3
  ret <4 x i32> %ins3
}

define <8 x i16> @test_buildvector_v8i16(i16 %a0, i16 %a1, i16 %a2, i16 %a3, i16 %a4, i16 %a5, i16 %a6, i16 %a7) {
; SSE2-32-LABEL: test_buildvector_v8i16:
; SSE2-32:       # BB#0:
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSE2-32-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE2-32-NEXT:    movd {{.*#+}} xmm3 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
; SSE2-32-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-32-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; SSE2-32-NEXT:    retl
;
; SSE2-64-LABEL: test_buildvector_v8i16:
; SSE2-64:       # BB#0:
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE2-64-NEXT:    movd %r9d, %xmm0
; SSE2-64-NEXT:    movd %r8d, %xmm2
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; SSE2-64-NEXT:    movd %ecx, %xmm0
; SSE2-64-NEXT:    movd %edx, %xmm1
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE2-64-NEXT:    movd %esi, %xmm3
; SSE2-64-NEXT:    movd %edi, %xmm0
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; SSE2-64-NEXT:    retq
;
; SSE41-32-LABEL: test_buildvector_v8i16:
; SSE41-32:       # BB#0:
; SSE41-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE41-32-NEXT:    pinsrw $1, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $2, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $3, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $4, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $5, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $6, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrw $7, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    retl
;
; SSE41-64-LABEL: test_buildvector_v8i16:
; SSE41-64:       # BB#0:
; SSE41-64-NEXT:    movd %edi, %xmm0
; SSE41-64-NEXT:    pinsrw $1, %esi, %xmm0
; SSE41-64-NEXT:    pinsrw $2, %edx, %xmm0
; SSE41-64-NEXT:    pinsrw $3, %ecx, %xmm0
; SSE41-64-NEXT:    pinsrw $4, %r8d, %xmm0
; SSE41-64-NEXT:    pinsrw $5, %r9d, %xmm0
; SSE41-64-NEXT:    pinsrw $6, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrw $7, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v8i16:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-32-NEXT:    vpinsrw $1, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $2, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $3, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $4, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $5, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $6, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrw $7, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v8i16:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vmovd %edi, %xmm0
; AVX-64-NEXT:    vpinsrw $1, %esi, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $2, %edx, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $3, %ecx, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $4, %r8d, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $5, %r9d, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $6, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrw $7, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    retq
  %ins0 = insertelement <8 x i16> undef, i16 %a0, i32 0
  %ins1 = insertelement <8 x i16> %ins0, i16 %a1, i32 1
  %ins2 = insertelement <8 x i16> %ins1, i16 %a2, i32 2
  %ins3 = insertelement <8 x i16> %ins2, i16 %a3, i32 3
  %ins4 = insertelement <8 x i16> %ins3, i16 %a4, i32 4
  %ins5 = insertelement <8 x i16> %ins4, i16 %a5, i32 5
  %ins6 = insertelement <8 x i16> %ins5, i16 %a6, i32 6
  %ins7 = insertelement <8 x i16> %ins6, i16 %a7, i32 7
  ret <8 x i16> %ins7
}

define <16 x i8> @test_buildvector_v16i8(i8 %a0, i8 %a1, i8 %a2, i8 %a3, i8 %a4, i8 %a5, i8 %a6, i8 %a7, i8 %a8, i8 %a9, i8 %a10, i8 %a11, i8 %a12, i8 %a13, i8 %a14, i8 %a15) {
; SSE2-32-LABEL: test_buildvector_v16i8:
; SSE2-32:       # BB#0:
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm3 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3],xmm3[4],xmm0[4],xmm3[5],xmm0[5],xmm3[6],xmm0[6],xmm3[7],xmm0[7]
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
; SSE2-32-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-32-NEXT:    movd {{.*#+}} xmm4 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-32-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3],xmm0[4],xmm4[4],xmm0[5],xmm4[5],xmm0[6],xmm4[6],xmm0[7],xmm4[7]
; SSE2-32-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; SSE2-32-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-32-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm3[0]
; SSE2-32-NEXT:    retl
;
; SSE2-64-LABEL: test_buildvector_v16i8:
; SSE2-64:       # BB#0:
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm3 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3],xmm3[4],xmm0[4],xmm3[5],xmm0[5],xmm3[6],xmm0[6],xmm3[7],xmm0[7]
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; SSE2-64-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-64-NEXT:    movd %r9d, %xmm0
; SSE2-64-NEXT:    movd %r8d, %xmm2
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; SSE2-64-NEXT:    movd %ecx, %xmm0
; SSE2-64-NEXT:    movd %edx, %xmm1
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; SSE2-64-NEXT:    movd %esi, %xmm4
; SSE2-64-NEXT:    movd %edi, %xmm0
; SSE2-64-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3],xmm0[4],xmm4[4],xmm0[5],xmm4[5],xmm0[6],xmm4[6],xmm0[7],xmm4[7]
; SSE2-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; SSE2-64-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm3[0]
; SSE2-64-NEXT:    retq
;
; SSE41-32-LABEL: test_buildvector_v16i8:
; SSE41-32:       # BB#0:
; SSE41-32-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE41-32-NEXT:    pinsrb $1, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $2, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $3, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $4, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $5, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $6, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $7, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $8, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $9, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $10, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $11, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $12, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $13, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $14, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    pinsrb $15, {{[0-9]+}}(%esp), %xmm0
; SSE41-32-NEXT:    retl
;
; SSE41-64-LABEL: test_buildvector_v16i8:
; SSE41-64:       # BB#0:
; SSE41-64-NEXT:    movd %edi, %xmm0
; SSE41-64-NEXT:    pinsrb $1, %esi, %xmm0
; SSE41-64-NEXT:    pinsrb $2, %edx, %xmm0
; SSE41-64-NEXT:    pinsrb $3, %ecx, %xmm0
; SSE41-64-NEXT:    pinsrb $4, %r8d, %xmm0
; SSE41-64-NEXT:    pinsrb $5, %r9d, %xmm0
; SSE41-64-NEXT:    pinsrb $6, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $7, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $8, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $9, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $10, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $11, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $12, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $13, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $14, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    pinsrb $15, {{[0-9]+}}(%rsp), %xmm0
; SSE41-64-NEXT:    retq
;
; AVX-32-LABEL: test_buildvector_v16i8:
; AVX-32:       # BB#0:
; AVX-32-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-32-NEXT:    vpinsrb $1, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $2, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $3, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $4, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $5, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $6, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $7, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $8, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $9, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $10, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $11, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $12, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $13, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $14, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    vpinsrb $15, {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX-32-NEXT:    retl
;
; AVX-64-LABEL: test_buildvector_v16i8:
; AVX-64:       # BB#0:
; AVX-64-NEXT:    vmovd %edi, %xmm0
; AVX-64-NEXT:    vpinsrb $1, %esi, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $2, %edx, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $3, %ecx, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $4, %r8d, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $5, %r9d, %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $9, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $10, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $11, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $12, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $13, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $14, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    vpinsrb $15, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; AVX-64-NEXT:    retq
  %ins0  = insertelement <16 x i8> undef,  i8 %a0,  i32 0
  %ins1  = insertelement <16 x i8> %ins0,  i8 %a1,  i32 1
  %ins2  = insertelement <16 x i8> %ins1,  i8 %a2,  i32 2
  %ins3  = insertelement <16 x i8> %ins2,  i8 %a3,  i32 3
  %ins4  = insertelement <16 x i8> %ins3,  i8 %a4,  i32 4
  %ins5  = insertelement <16 x i8> %ins4,  i8 %a5,  i32 5
  %ins6  = insertelement <16 x i8> %ins5,  i8 %a6,  i32 6
  %ins7  = insertelement <16 x i8> %ins6,  i8 %a7,  i32 7
  %ins8  = insertelement <16 x i8> %ins7,  i8 %a8,  i32 8
  %ins9  = insertelement <16 x i8> %ins8,  i8 %a9,  i32 9
  %ins10 = insertelement <16 x i8> %ins9,  i8 %a10, i32 10
  %ins11 = insertelement <16 x i8> %ins10, i8 %a11, i32 11
  %ins12 = insertelement <16 x i8> %ins11, i8 %a12, i32 12
  %ins13 = insertelement <16 x i8> %ins12, i8 %a13, i32 13
  %ins14 = insertelement <16 x i8> %ins13, i8 %a14, i32 14
  %ins15 = insertelement <16 x i8> %ins14, i8 %a15, i32 15
  ret <16 x i8> %ins15
}
