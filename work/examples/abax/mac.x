pub proc mac {
  in0: chan<s32> in;
  in1: chan<s32> in;
  in2: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, in2: chan<s32> in, out0: chan<s32> out) { (in0, in1, in2, out0) }

  init { () }

  next(state: ()) {
    let (tok0, tmp0) = recv(join(), in0);
    let (tok1, tmp1) = recv(join(), in1);
    let (tok2, tmp2) = recv(join(), in2);
    let tmp3 = (tmp0 as s64);
    let tmp4 = (tmp1 as s64);
    let tmp5 = (tmp3 * tmp4);
    let tmp6 = (tmp5 as sN[65]);
    let tmp7 = (tmp2 as sN[65]);
    let tmp8 = (tmp6 + tmp7);
    let tmp9 = (tmp8 as s32);
    let tok = join(tok0, tok1, tok2);
    send(tok, out0, tmp9);
  }
}