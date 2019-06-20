; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mergeicmps -mtriple=x86_64-unknown-unknown -S | FileCheck %s --check-prefix=X86

source_filename = "qabstractitemmodeltester.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64--linux-gnu"

%class.B = type { i32, i32 }
%class.D = type { i32 }
%class.C = type { i8 }
%class.QMessageLogger = type { i8 }

$_ZN1D7compareI1BS1_EEbRKT_RKT0_PKcS9_S9_i = comdat any

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1

; Function Attrs: uwtable
define linkonce_odr dso_local zeroext i1 @_ZN1D7compareI1BS1_EEbRKT_RKT0_PKcS9_S9_i(%class.D* %this, %class.B* dereferenceable(8) %p1, %class.B* dereferenceable(8) %p2, i8*, i8*, i8*, i32) local_unnamed_addr #0 comdat align 2 {
; X86-LABEL: @_ZN1D7compareI1BS1_EEbRKT_RKT0_PKcS9_S9_i(
; X86-NEXT:  entry:
; X86-NEXT:    [[REF_TMP:%.*]] = alloca [[CLASS_C:%.*]], align 1
; X86-NEXT:    [[C_I:%.*]] = getelementptr inbounds [[CLASS_B:%.*]], %class.B* [[P2:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP4:%.*]] = load i32, i32* [[C_I]], align 4
; X86-NEXT:    [[C2_I:%.*]] = getelementptr inbounds [[CLASS_B]], %class.B* [[P1:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP5:%.*]] = load i32, i32* [[C2_I]], align 4
; X86-NEXT:    [[CMP_ENTRY:%.*]] = icmp eq i32 [[TMP4]], [[TMP5]]
; X86-NEXT:    br i1 [[CMP_ENTRY]], label [[BB1:%.*]], label [[BB2:%.*]]
; X86:       bb1:
; X86-NEXT:    [[M_I:%.*]] = getelementptr inbounds [[CLASS_B]], %class.B* [[P2]], i64 0, i32 1
; X86-NEXT:    [[TMP6:%.*]] = load i32, i32* [[M_I]], align 4
; X86-NEXT:    [[M3_I:%.*]] = getelementptr inbounds [[CLASS_B]], %class.B* [[P1]], i64 0, i32 1
; X86-NEXT:    [[TMP7:%.*]] = load i32, i32* [[M3_I]], align 4
; X86-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[TMP6]], [[TMP7]]
; X86-NEXT:    br label [[BB2]]
; X86:       bb2:
; X86-NEXT:    [[TMP8:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[CMP1]], [[BB1]] ]
; X86-NEXT:    [[FAILUREREPORTINGMODE:%.*]] = getelementptr inbounds [[CLASS_D:%.*]], %class.D* [[THIS:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP9:%.*]] = load i32, i32* [[FAILUREREPORTINGMODE]], align 4
; X86-NEXT:    [[COND:%.*]] = icmp eq i32 [[TMP9]], 0
; X86-NEXT:    br i1 [[COND]], label [[BB3:%.*]], label [[SW_EPILOG:%.*]]
; X86:       bb3:
; X86-NEXT:    br i1 [[CMP_ENTRY]], label [[BB4:%.*]], label [[BB5:%.*]]
; X86:       bb4:
; X86-NEXT:    [[M_I_I:%.*]] = getelementptr inbounds [[CLASS_B]], %class.B* [[P2]], i64 0, i32 1
; X86-NEXT:    [[TMP10:%.*]] = load i32, i32* [[M_I_I]], align 4
; X86-NEXT:    [[M3_I_I:%.*]] = getelementptr inbounds [[CLASS_B]], %class.B* [[P1]], i64 0, i32 1
; X86-NEXT:    [[TMP11:%.*]] = load i32, i32* [[M3_I_I]], align 4
; X86-NEXT:    [[CMP4:%.*]] = icmp eq i32 [[TMP10]], [[TMP11]]
; X86-NEXT:    br label [[BB5]]
; X86:       bb5:
; X86-NEXT:    [[TMP12:%.*]] = phi i1 [ false, [[BB3]] ], [ [[CMP4]], [[BB4]] ]
; X86-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[CLASS_C]], %class.C* [[REF_TMP]], i64 0, i32 0
; X86-NEXT:    br label [[SW_EPILOG]]
; X86:       sw.epilog:
; X86-NEXT:    ret i1 [[TMP8]]
;
entry:
  %ref.tmp = alloca %class.C, align 1
  %c.i = getelementptr inbounds %class.B, %class.B* %p2, i64 0, i32 0
  %4 = load i32, i32* %c.i, align 4
  %c2.i = getelementptr inbounds %class.B, %class.B* %p1, i64 0, i32 0
  %5 = load i32, i32* %c2.i, align 4
  %cmp_entry = icmp eq i32 %4, %5
  br i1 %cmp_entry, label %bb1, label %bb2

bb1:                                       ; preds = %entry
  %m.i = getelementptr inbounds %class.B, %class.B* %p2, i64 0, i32 1
  %6 = load i32, i32* %m.i, align 4
  %m3.i = getelementptr inbounds %class.B, %class.B* %p1, i64 0, i32 1
  %7 = load i32, i32* %m3.i, align 4
  %cmp1 = icmp eq i32 %6, %7
  br label %bb2

bb2:                               ; preds = %entry, %bb1
  %8 = phi i1 [ false, %entry ], [ %cmp1, %bb1 ]
  %failureReportingMode = getelementptr inbounds %class.D, %class.D* %this, i64 0, i32 0
  %9 = load i32, i32* %failureReportingMode, align 4
  %cond = icmp eq i32 %9, 0
  br i1 %cond, label %bb3, label %sw.epilog

bb3:                                            ; preds = %bb2
  br i1 %cmp_entry, label %bb4, label %bb5

bb4:                                     ; preds = %bb3
  %m.i.i = getelementptr inbounds %class.B, %class.B* %p2, i64 0, i32 1
  %10 = load i32, i32* %m.i.i, align 4
  %m3.i.i = getelementptr inbounds %class.B, %class.B* %p1, i64 0, i32 1
  %11 = load i32, i32* %m3.i.i, align 4
  %cmp4 = icmp eq i32 %10, %11
  br label %bb5

bb5:                          ; preds = %bb3, %bb4
  %12 = phi i1 [ false, %bb3 ], [ %cmp4, %bb4 ]
  %13 = getelementptr inbounds %class.C, %class.C* %ref.tmp, i64 0, i32 0
  br label %sw.epilog

sw.epilog:                                        ; preds = %bb2
  ret i1 %8
}

