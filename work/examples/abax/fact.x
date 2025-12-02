pub proc fact {
  in0: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, out0: chan<s32> out) { (in0, out0) }

  init { (1, 0, 0, false) }

  next(state: (s32, s32, s32, bool)) {
    let (acc0, index0, ub0, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, ub0);
    let tmp1 = (index0 as s34);
    let tmp2 = (tmp1 + s34:1);
    let tmp3 = (tmp2 as s32);
    let tmp4 = (acc0 * tmp3);
    let tmp5 = tmp4;
    let tmp6 = if (index0 < tmp0) { tmp5 } else { acc0 };
    let tmp7 = if (index0 + 1 >= tmp0) { s32:0 } else { index0 + 1 };
    let tmp8 = index0 + 1 >= tmp0;
    let tok1 = send_if(tok0, out0, tmp8, tmp6);
    let tmp9 = if (tmp8) { 1 } else { tmp6 };
    let tmp10 = if (tmp8) { s32:0 } else { tmp7 };
    let tmp11 = !tmp8;
    (tmp9, tmp10, tmp0, tmp11)
  }
}