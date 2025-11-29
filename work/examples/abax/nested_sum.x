pub proc nested_sum {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { (0, 0, 0, 0, 0, false) }

  next(state: (s32, s32, s32, s32, s32, bool)) {
    let (acc0, index0, ub0, index1, ub1, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, ub0);
    let (tok1, tmp1) = recv_if(join(), in1, !busy, ub1);
    let tmp2 = (index0 * index1);
    let tmp3 = (acc0 as s34);
    let tmp4 = (tmp2 as s34);
    let tmp5 = (tmp3 + tmp4);
    let tmp6 = (tmp5 as s32);
    let tmp7 = tmp6;
    let tmp8 = if (index1 + 1 >= tmp1) { s32:0 } else { index1 + 1 };
    let tmp9 = index1 + 1 >= tmp1;
    let tmp10 = if (tmp9 && index0 + 1 >= tmp0) { s32:0 } else if (tmp9) { index0 + 1 } else { index0 };
    let tmp11 = tmp9 && (index0 + 1 >= tmp0);
    send_if(tok1, out0, tmp11, tmp7);
    let tmp12 = if (tmp11) { 0 } else { tmp7 };
    let tmp13 = if (tmp11) { s32:0 } else { tmp10 };
    let tmp14 = if (tmp11) { s32:0 } else { tmp8 };
    let tmp15 = !tmp11;
    (tmp12, tmp13, tmp0, tmp14, tmp1, tmp15)
  }
}