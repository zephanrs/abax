pub proc add {
  in0: chan<u32> in;
  in1: chan<u32> in;
  out0: chan<u32> out;

  config(in0: chan<u32> in, in1: chan<u32> in, out0: chan<u32> out) { (in0, in1, out0) }

  init { () }

  next(state: ()) {
    let (tok0, tmp0) = recv(join(), in0);
    let (tok1, tmp1) = recv(join(), in1);
    let tmp2 = (tmp0 as u33);
    let tmp3 = (tmp1 as u33);
    let tmp4 = (tmp2 + tmp3);
    let tmp5 = (tmp4 as u32);
    let tok = join(tok0, tok1);
    send(tok, out0, tmp5);
  }

}