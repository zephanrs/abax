pub proc fib {
  in0: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, out0: chan<s32> out) { (in0, out0) }

  init { (0, 0, 1, 0, 0, false) }

  next(state: (s32, s32, s32, s32, s32, bool)) {
    let (acc0, acc1, acc2, index0, ub0, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, ub0);
    let tmp1 = (acc1 as s33);
    let tmp2 = (acc2 as s33);
    let tmp3 = (tmp1 + tmp2);
    let tmp4 = (tmp3 as s32);
    let tmp5 = tmp4;
    let tmp6 = acc2;
    let tmp7 = tmp5;
    let tmp8 = if (index0 < tmp0) { tmp5 } else { acc0 };
    let tmp9 = if (index0 < tmp0) { tmp6 } else { acc1 };
    let tmp10 = if (index0 < tmp0) { tmp7 } else { acc2 };
    let tmp11 = if (index0 + 1 >= tmp0) { s32:0 } else { index0 + 1 };
    let tmp12 = index0 + 1 >= tmp0;
    send_if(tok0, out0, tmp12, tmp10);
    let tmp13 = if (tmp12) { 0 } else { tmp8 };
    let tmp14 = if (tmp12) { 0 } else { tmp9 };
    let tmp15 = if (tmp12) { 1 } else { tmp10 };
    let tmp16 = if (tmp12) { s32:0 } else { tmp11 };
    let tmp17 = !tmp12;
    (tmp13, tmp14, tmp15, tmp16, tmp0, tmp17)
  }
}