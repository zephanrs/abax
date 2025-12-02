pub proc incr {
  in0: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, out0: chan<s32> out) { (in0, out0) }

  init { () }

  next(state: ()) {
    let (tok0, tmp0) = recv(join(), in0);
    let tmp1 = (tmp0 as s33);
    let tmp2 = (tmp1 + s33:1);
    let tmp3 = (tmp2 as s32);
    send(tok0, out0, tmp3);
  }
}