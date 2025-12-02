import apfloat;

pub const F32_EXP_SZ = u32:8;
pub const F32_FRAC_SZ = u32:23;
pub type F32 = apfloat::APFloat<F32_EXP_SZ, F32_FRAC_SZ>;


pub proc add {
  in0: chan<F32> in;
  in1: chan<F32> in;
  out0: chan<F32> out;

  config(in0: chan<F32> in, in1: chan<F32> in, out0: chan<F32> out) { (in0, in1, out0) }

  init { () }

  next(state: ()) {
    let (tok0, tmp0) = recv(join(), in0);
    let (tok1, tmp1) = recv(join(), in1);
    let tmp2 = apfloat::add(tmp0, tmp1);
    let tok = join(tok0, tok1);
    send(tok, out0, tmp2);
  }
}