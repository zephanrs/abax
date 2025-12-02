pub proc gcd {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { (0, 0, 0, true, false) }

  next(state: (s32, s32, s32, bool, bool)) {
    let (acc0, acc1, acc2, index0, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, acc0);
    let (tok1, tmp1) = recv_if(join(), in1, !busy, acc1);
    let tmp2 = join(tok0, tok1);
    let tmp3 = if (!busy) { tmp1 } else { acc0 };
    let tmp4 = if (!busy) { tmp0 } else { acc1 };
    let tmp5 = (tmp3 > s32:0);
    let tmp6 = tmp5;
    let tmp7 = tmp3;
    let tmp8 = (tmp4 % tmp3);
    let tmp9 = tmp8;
    let tmp10 = tmp7;
    let tmp11 = if (tmp6) { tmp9 } else { tmp3 };
    let tmp12 = if (tmp6) { tmp10 } else { tmp4 };
    let tmp13 = if (tmp6) { tmp7 } else { acc2 };
    let tmp14 = !tmp6;
    let tok2 = send_if(tmp2, out0, tmp14, tmp12);
    let tmp15 = if (tmp14) { tmp1 } else { tmp11 };
    let tmp16 = if (tmp14) { tmp0 } else { tmp12 };
    let tmp17 = if (tmp14) { 0 } else { tmp13 };
    let tmp18 = if (tmp14) { false } else { tmp6 };
    let tmp19 = !tmp14;
    (tmp15, tmp16, tmp17, tmp18, tmp19)
  }
}