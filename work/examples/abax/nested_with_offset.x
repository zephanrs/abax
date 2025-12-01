pub proc nested_with_offset {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { (0, 0, 0, 0, 0, 0, false) }

  next(state: (s32, s32, s32, s32, s32, s32, bool)) {
    let (acc0, acc1, index0, ub0, index1, ub1, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, ub0);
    let (tok1, tmp1) = recv_if(join(), in1, !busy, ub1);
    let tmp2 = (index0 as s64);
    let tmp3 = (tmp2 * s64:7);
    let tmp4 = (tmp3 as sN[65]);
    let tmp5 = (tmp4 + sN[65]:3);
    let tmp6 = (tmp5 as s32);
    let tmp7 = tmp6;
    let tmp8 = if (index0 < tmp0 && index1 == s32:0) { tmp7 } else { acc0 };
    let tmp9 = (acc1 as s33);
    let tmp10 = (tmp8 as s33);
    let tmp11 = (tmp9 + tmp10);
    let tmp12 = (tmp11 as s34);
    let tmp13 = (index1 as s34);
    let tmp14 = (tmp12 + tmp13);
    let tmp15 = (tmp14 as s32);
    let tmp16 = tmp15;
    let tmp17 = if (index0 < tmp0 && index1 < tmp1) { tmp16 } else { acc1 };
    let tmp18 = if (index1 + 1 >= tmp1) { s32:0 } else { index1 + 1 };
    let tmp19 = index1 + 1 >= tmp1;
    let tmp20 = if (tmp19 && index0 + 1 >= tmp0) { s32:0 } else if (tmp19) { index0 + 1 } else { index0 };
    let tmp21 = tmp19 && (index0 + 1 >= tmp0);
    send_if(tok1, out0, tmp21, tmp17);
    let tmp22 = if (tmp21) { 0 } else { tmp8 };
    let tmp23 = if (tmp21) { 0 } else { tmp17 };
    let tmp24 = if (tmp21) { s32:0 } else { tmp20 };
    let tmp25 = if (tmp21) { s32:0 } else { tmp18 };
    let tmp26 = !tmp21;
    (tmp22, tmp23, tmp24, tmp0, tmp25, tmp1, tmp26)
  }
}