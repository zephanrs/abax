pub proc gcd {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { (0, 0, false) }

  next(state: (s32, s32, bool)) {
    let (acc0, acc1, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, acc0);
    let (tok1, tmp1) = recv_if(join(), in1, !busy, acc1);
    let tmp2 = join(tok0, tok1);
    let tmp3 = if (!busy) { tmp1 } else { acc0 };
    let tmp4 = if (!busy) { tmp0 } else { acc1 };
    let tmp5 = (tmp3 > s32:0);
    let tmp6 = tmp5;
    let tmp7 = (tmp4 % tmp3);
    let tmp8 = tmp7;
    let tmp9 = tmp3;
    let tmp10 = if (tmp6) { tmp8 } else { tmp3 };
    let tmp11 = if (tmp6) { tmp9 } else { tmp4 };
    send_if(tmp2, out0, !tmp6, tmp11);
    let tmp12 = if (!tmp6) { tmp1 } else { tmp10 };
    let tmp13 = if (!tmp6) { tmp0 } else { tmp11 };
    (tmp12, tmp13, tmp6)
  }
}