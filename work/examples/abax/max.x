pub proc max {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { () }

  next(state: ()) {
    let (tok0, tmp0) = recv(join(), in0);
    let (tok1, tmp1) = recv(join(), in1);
    let tmp2 = (tmp0 > tmp1);
    let tmp3 = if (tmp2) { tmp0 } else { tmp1 };
    let tok = join(tok0, tok1);
    send(tok, out0, tmp3);
  }

}