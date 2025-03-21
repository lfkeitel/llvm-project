; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=aarch64-unknown-unknown < %s | FileCheck %s

declare void @use_i1(i1 %x)
declare void @use_i32(i32 %x)

; Based on the IR generated for the `last` method of the type `slice` in Rust
define ptr @test_last_elem_from_ptr(ptr noundef readnone %x0, i64 noundef %x1) {
; CHECK-LABEL: test_last_elem_from_ptr:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x1, #1
; CHECK-NEXT:    add x8, x8, x0
; CHECK-NEXT:    csel x0, xzr, x8, lo
; CHECK-NEXT:    ret
  %cmp = icmp eq i64 %x1, 0
  %add.ptr = getelementptr inbounds nuw i8, ptr %x0, i64 %x1
  %add.ptr1 = getelementptr inbounds i8, ptr %add.ptr, i64 -1
  %retval.0 = select i1 %cmp, ptr null, ptr %add.ptr1
  ret ptr %retval.0
}

define i32 @test_eq0_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_eq7_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq7_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 7
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ule7_sub7_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ule7_sub7_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ls
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ule7_sub8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ule7_sub8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ule0_sub1_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ule0_sub1_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ultminus2_subminus2_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ultminus2_subminus2_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, -2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ultminus2_subminus3_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ultminus2_subminus3_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #3
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ls
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, -2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -3
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ne0_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ne0_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, w8, wzr, hs
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 %sub, i32 0
  ret i32 %ret
}

define i32 @test_ne7_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ne7_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 %sub, i32 0
  ret i32 %ret
}

define i32 @test_ultminus1_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ultminus1_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, -1
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ugt7_sub7_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ugt7_sub7_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ugt7_sub8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ugt7_sub8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hs
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sle7_sub7_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sle7_sub7_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, le
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sle7_sub8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sle7_sub8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_slt8_sub8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_slt8_sub8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, 8
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_slt8_sub7_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_slt8_sub7_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, le
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, 8
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sltminus8_subminus8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sltminus8_subminus8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, -8
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sgtminus8_subminus8_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sgtminus8_subminus8_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #8
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, gt
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x1, -8
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sgtminus8_subminus7_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sgtminus8_subminus7_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adds w8, w1, #7
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ge
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x1, -8
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -7
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_eq0_sub_addcomm_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_sub_addcomm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add i32 %x1, %x0
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_eq0_subcomm_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_subcomm_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = add i32 -1, %add
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_eq0_multi_use_sub_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_multi_use_sub_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x30, x19, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    subs w8, w1, #1
; CHECK-NEXT:    add w0, w8, w0
; CHECK-NEXT:    csel w19, wzr, w0, lo
; CHECK-NEXT:    bl use_i32
; CHECK-NEXT:    mov w0, w19
; CHECK-NEXT:    ldp x30, x19, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, 1
  tail call void @use_i32(i32 %sub)
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_eq_nonconst_sub_add_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_eq_nonconst_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, %x2
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ne_nonconst_sub_add_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ne_nonconst_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %x1, %x2
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ult_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ult_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ule_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ule_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ls
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ugt_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ugt_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_uge_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_uge_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hs
; CHECK-NEXT:    ret
  %cmp = icmp uge i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_slt_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_slt_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sle_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sle_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, le
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sgt_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sgt_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, gt
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sge_nonconst_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sge_nonconst_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ge
; CHECK-NEXT:    ret
  %cmp = icmp sge i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i64 @test_ult_nonconst_i64(i64 %x0, i64 %x1, i64 %x2) {
; CHECK-LABEL: test_ult_nonconst_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x1, x2
; CHECK-NEXT:    add x8, x8, x0
; CHECK-NEXT:    csel x0, xzr, x8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i64 %x1, %x2
  %add = add i64 %x0, %x1
  %sub = sub i64 %add, %x2
  %ret = select i1 %cmp, i64 0, i64 %sub
  ret i64 %ret
}

define i32 @test_eq_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_eq_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ne_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ne_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ult_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ult_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ule_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ule_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, hs
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_ugt_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ugt_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_uge_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_uge_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ls
; CHECK-NEXT:    ret
  %cmp = icmp uge i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_slt_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_slt_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, gt
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sle_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sle_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, ge
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sgt_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sgt_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

define i32 @test_sge_nonconst_sub_add_comm_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_sge_nonconst_sub_add_comm_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs w8, w1, w2
; CHECK-NEXT:    add w8, w8, w0
; CHECK-NEXT:    csel w0, wzr, w8, le
; CHECK-NEXT:    ret
  %cmp = icmp sge i32 %x2, %x1
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq0_multi_use_cmp_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_multi_use_cmp_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x30, x19, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    csel w19, wzr, w8, eq
; CHECK-NEXT:    bl use_i1
; CHECK-NEXT:    mov w0, w19
; CHECK-NEXT:    ldp x30, x19, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  tail call void @use_i1(i1 %cmp)
  %add = add nuw i32 %x0, %x1
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq0_multi_use_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_multi_use_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-32]! // 8-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w20, -16
; CHECK-NEXT:    .cfi_offset w30, -32
; CHECK-NEXT:    add w20, w0, w1
; CHECK-NEXT:    mov w19, w1
; CHECK-NEXT:    mov w0, w20
; CHECK-NEXT:    bl use_i32
; CHECK-NEXT:    sub w8, w20, #1
; CHECK-NEXT:    cmp w19, #0
; CHECK-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ldr x30, [sp], #32 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add nuw i32 %x0, %x1
  tail call void @use_i32(i32 %add)
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq1_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq1_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #1
; CHECK-NEXT:    sub w8, w8, #2
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 1
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ugtsmax_sub_add_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ugtsmax_sub_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    add w9, w0, w1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    add w8, w9, w8
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, 2147483647
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2147483648
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    sub w8, w8, #2
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ne_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ne_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    sub w8, w8, #2
; CHECK-NEXT:    csel w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2
  %ret = select i1 %cmp, i32 %sub, i32 0
  ret i32 %ret
}

; Negative test
define i32 @test_ult7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ult7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #7
; CHECK-NEXT:    sub w8, w8, #8
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ule7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ule7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #8
; CHECK-NEXT:    sub w8, w8, #6
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 6
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ugt7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ugt7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #7
; CHECK-NEXT:    sub w8, w8, #6
; CHECK-NEXT:    csel w0, wzr, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 6
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_uge7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_uge7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #6
; CHECK-NEXT:    sub w8, w8, #8
; CHECK-NEXT:    csel w0, wzr, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp uge i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_slt7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_slt7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #7
; CHECK-NEXT:    sub w8, w8, #8
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sle7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sle7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #8
; CHECK-NEXT:    sub w8, w8, #6
; CHECK-NEXT:    csel w0, wzr, w8, lt
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 6
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sgt7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sgt7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #7
; CHECK-NEXT:    sub w8, w8, #6
; CHECK-NEXT:    csel w0, wzr, w8, gt
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 6
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sge7_const_mismatch_i32(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sge7_const_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, #6
; CHECK-NEXT:    sub w8, w8, #8
; CHECK-NEXT:    csel w0, wzr, w8, gt
; CHECK-NEXT:    ret
  %cmp = icmp sge i32 %x1, 7
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 8
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_unrelated_add_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_unrelated_add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w2
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i32 %x1, 0
  %add = add nuw i32 %x0, %x2
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i16 @test_eq0_sub_add_i16(i16 %x0, i16 %x1) {
; CHECK-LABEL: test_eq0_sub_add_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    tst w1, #0xffff
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i16 %x1, 0
  %add = add nuw i16 %x0, %x1
  %sub = sub i16 %add, 1
  %ret = select i1 %cmp, i16 0, i16 %sub
  ret i16 %ret
}

; Negative test
define i8 @test_eq_nonconst_sub_add_i8(i8 %x0, i8 %x1, i8 %x2) {
; CHECK-LABEL: test_eq_nonconst_sub_add_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w1, #0xff
; CHECK-NEXT:    add w9, w0, w1
; CHECK-NEXT:    sub w9, w9, w2
; CHECK-NEXT:    cmp w8, w2, uxtb
; CHECK-NEXT:    csel w0, wzr, w9, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i8 %x1, %x2
  %add = add nuw i8 %x0, %x1
  %sub = sub i8 %add, %x2
  %ret = select i1 %cmp, i8 0, i8 %sub
  ret i8 %ret
}

; Negative test
define i16 @test_eq_nonconst_sub_add_i16(i16 %x0, i16 %x1, i16 %x2) {
; CHECK-LABEL: test_eq_nonconst_sub_add_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w1, #0xffff
; CHECK-NEXT:    add w9, w0, w1
; CHECK-NEXT:    sub w9, w9, w2
; CHECK-NEXT:    cmp w8, w2, uxth
; CHECK-NEXT:    csel w0, wzr, w9, eq
; CHECK-NEXT:    ret
  %cmp = icmp eq i16 %x1, %x2
  %add = add nuw i16 %x0, %x1
  %sub = sub i16 %add, %x2
  %ret = select i1 %cmp, i16 0, i16 %sub
  ret i16 %ret
}

; Negative test
define i32 @test_ule_unsigned_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ule_unsigned_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %cmp = icmp ule i32 %x1, -1
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 0
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ugt_unsigned_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ugt_unsigned_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w0, w0, w1
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %x1, -1
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 0
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ult_unsigned_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_ult_unsigned_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_uge_unsigned_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_uge_unsigned_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %cmp = icmp uge i32 %x1, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, -1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_slt_signed_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_slt_signed_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-2147483647 // =0x80000001
; CHECK-NEXT:    add w9, w0, w1
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %cmp = icmp slt i32 %x1, 2147483648
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2147483647
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sle_signed_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sle_signed_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %cmp = icmp sle i32 %x1, 2147483647
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2147483648
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sgt_signed_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sgt_signed_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-2147483648 // =0x80000000
; CHECK-NEXT:    add w9, w0, w1
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %cmp = icmp sgt i32 %x1, 2147483647
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2147483648
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_sge_signed_overflow(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_sge_signed_overflow:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %cmp = icmp sge i32 %x1, 2147483648
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 2147483647
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq0_bitwidth_mismatch(i32 %x0, i32 %x1) {
; CHECK-LABEL: test_eq0_bitwidth_mismatch:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    tst w1, #0xffff
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %x1t = trunc i32 %x1 to i16
  %cmp = icmp eq i16 %x1t, 0
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_eq0_bitwidth_mismatch_2(i32 %x0, i64 %x1) {
; CHECK-LABEL: test_eq0_bitwidth_mismatch_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %x1t = trunc i64 %x1 to i32
  %cmp = icmp eq i64 %x1, 0
  %add = add i32 %x0, %x1t
  %sub = sub i32 %add, 1
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ult_nonconst_op_mismatch_i32(i32 %x0, i32 %x1, i32 %x2) {
; CHECK-LABEL: test_ult_nonconst_op_mismatch_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, w2
; CHECK-NEXT:    add w8, w8, w2
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = add i32 %add, %x2
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ult_nonconst_unrelated_i32(i32 %x0, i32 %x1, i32 %x2, i32 %x3) {
; CHECK-LABEL: test_ult_nonconst_unrelated_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w1, w2
; CHECK-NEXT:    sub w8, w8, w3
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x1, %x2
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x3
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}

; Negative test
define i32 @test_ult_nonconst_unrelated_2_i32(i32 %x0, i32 %x1, i32 %x2, i32 %x3) {
; CHECK-LABEL: test_ult_nonconst_unrelated_2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    cmp w2, w1
; CHECK-NEXT:    sub w8, w8, w3
; CHECK-NEXT:    csel w0, wzr, w8, lo
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %x2, %x1
  %add = add i32 %x0, %x1
  %sub = sub i32 %add, %x3
  %ret = select i1 %cmp, i32 0, i32 %sub
  ret i32 %ret
}
