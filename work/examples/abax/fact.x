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
    let tmp6 = if (index0 + 1 >= tmp0) { s32:0 } else { index0 + 1 };
    let tmp7 = index0 + 1 >= tmp0;
    send_if(tok0, out0, tmp7, tmp5);
    let tmp8 = if (tmp7) { 1 } else { tmp5 };
    let tmp9 = if (tmp7) { s32:0 } else { tmp6 };
    let tmp10 = !tmp7;
    (tmp8, tmp9, tmp0, tmp10)
  }
}

#[test_proc]
proc fact_test {
  terminator: chan<bool> out;
  in0_s: chan<s32> out;
  out0_r: chan<s32> in;

  config(terminator: chan<bool> out) {
    let (in0_s, in0_r) = chan<s32>("in0");
    let (out0_s, out0_r) = chan<s32>("out0");
    spawn fact(in0_r, out0_s);
    (terminator, in0_s, out0_r)
  }

  init { () }

  next(state: ()) {
    let tok = join();
    
    // Test case 1: fact(0) = 1
    let tok = send(tok, in0_s, s32:0);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:1);
    
    // Test case 2: fact(1) = 1
    let tok = send(tok, in0_s, s32:1);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:1);
    
    // Test case 3: fact(5) = 120
    let tok = send(tok, in0_s, s32:5);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:120);
    
    // Test case 4: fact(7) = 5040
    let tok = send(tok, in0_s, s32:7);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:5040);
    
    // Test case 5: fact(10) = 3628800
    let tok = send(tok, in0_s, s32:10);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:3628800);

    send(tok, terminator, true);
  }
}