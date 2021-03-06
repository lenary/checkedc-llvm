; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64le-unkknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64-unkknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-BE
; RUN: llc -mcpu=pwr9 -mtriple=powerpc64le-unkknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-P9
; Function Attrs: norecurse nounwind writeonly
define <2 x i64> @testll0(<2 x i64> returned %a, <2 x i64> %b, i64* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testll0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    mfvsrd r3, f0
; CHECK-NEXT:    std r3, 24(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testll0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    mfvsrd r3, vs34
; CHECK-BE-NEXT:    std r3, 24(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testll0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    mfvsrld r3, vs34
; CHECK-P9-NEXT:    std r3, 24(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %a, i32 0
  %arrayidx = getelementptr inbounds i64, i64* %ap, i64 3
  store i64 %vecext, i64* %arrayidx, align 8
  ret <2 x i64> %a
}

; Function Attrs: norecurse nounwind writeonly
define <2 x i64> @testll1(<2 x i64> returned %a, i64 %b, i64* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testll1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mfvsrd r3, vs34
; CHECK-NEXT:    std r3, 24(r6)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testll1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    mfvsrd r3, f0
; CHECK-BE-NEXT:    std r3, 24(r6)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testll1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    mfvsrd r3, vs34
; CHECK-P9-NEXT:    std r3, 24(r6)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %a, i32 1
  %arrayidx = getelementptr inbounds i64, i64* %ap, i64 3
  store i64 %vecext, i64* %arrayidx, align 8
  ret <2 x i64> %a
}

; Function Attrs: norecurse nounwind writeonly
define <2 x double> @testd0(<2 x double> returned %a, <2 x double> %b, double* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testd0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    stfd f0, 24(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testd0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addi r3, r7, 24
; CHECK-BE-NEXT:    stxsdx vs34, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testd0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    stfd f0, 24(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %a, i32 0
  %arrayidx = getelementptr inbounds double, double* %ap, i64 3
  store double %vecext, double* %arrayidx, align 8
  ret <2 x double> %a
}

; Function Attrs: norecurse nounwind writeonly
define <2 x double> @testd1(<2 x double> returned %a, <2 x double> %b, double* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testd1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r3, r7, 24
; CHECK-NEXT:    stxsdx vs34, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testd1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    stfd f0, 24(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testd1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    stxsd v2, 24(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %a, i32 1
  %arrayidx = getelementptr inbounds double, double* %ap, i64 3
  store double %vecext, double* %arrayidx, align 8
  ret <2 x double> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf0(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-NEXT:    xscvspdpn f0, vs0
; CHECK-NEXT:    stfs f0, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xscvspdpn f0, vs34
; CHECK-BE-NEXT:    stfs f0, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-NEXT:    xscvspdpn f0, vs0
; CHECK-P9-NEXT:    stfs f0, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 0
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf1(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    xscvspdpn f0, vs0
; CHECK-NEXT:    stfs f0, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-BE-NEXT:    xscvspdpn f0, vs0
; CHECK-BE-NEXT:    stfs f0, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    xscvspdpn f0, vs0
; CHECK-P9-NEXT:    stfs f0, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 1
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf2(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-NEXT:    xscvspdpn f0, vs0
; CHECK-NEXT:    stfs f0, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    xscvspdpn f0, vs0
; CHECK-BE-NEXT:    stfs f0, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf2:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-NEXT:    xscvspdpn f0, vs0
; CHECK-P9-NEXT:    stfs f0, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 2
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf3(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xscvspdpn f0, vs34
; CHECK-NEXT:    stfs f0, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    xscvspdpn f0, vs0
; CHECK-BE-NEXT:    stfs f0, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf3:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xscvspdpn f0, vs34
; CHECK-P9-NEXT:    stfs f0, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 3
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi0(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    mfvsrwz r3, f0
; CHECK-NEXT:    stw r3, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    mfvsrwz r3, f0
; CHECK-BE-NEXT:    stw r3, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    li r3, 0
; CHECK-P9-NEXT:    vextuwrx r3, r3, v2
; CHECK-P9-NEXT:    stw r3, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 0
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi1(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-NEXT:    mfvsrwz r3, f0
; CHECK-NEXT:    stw r3, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    mfvsrwz r3, vs34
; CHECK-BE-NEXT:    stw r3, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    vextuwrx r3, r3, v2
; CHECK-P9-NEXT:    stw r3, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 1
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi2(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mfvsrwz r3, vs34
; CHECK-NEXT:    stw r3, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-BE-NEXT:    mfvsrwz r3, f0
; CHECK-BE-NEXT:    stw r3, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi2:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    mfvsrwz r3, vs34
; CHECK-P9-NEXT:    stw r3, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 2
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi3(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-NEXT:    mfvsrwz r3, f0
; CHECK-NEXT:    stw r3, 12(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    mfvsrwz r3, f0
; CHECK-BE-NEXT:    stw r3, 12(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi3:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    li r3, 12
; CHECK-P9-NEXT:    vextuwrx r3, r3, v2
; CHECK-P9-NEXT:    stw r3, 12(r7)
; CHECK-P9-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 3
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}
