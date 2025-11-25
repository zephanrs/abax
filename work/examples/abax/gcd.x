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
    let tmp3 = if (!busy) { tmp0 } else { acc0 };
    let tmp4 = if (!busy) { tmp1 } else { acc1 };
    let tmp5 = (tmp4 > s32:0);
    let tmp6 = tmp5;
    let tmp7 = (tmp3 % tmp4);
    let tmp8 = tmp7;
    let tmp9 = tmp4;
    let tmp10 = if (tmp6) { tmp9 } else { tmp3 };
    let tmp11 = if (tmp6) { tmp8 } else { tmp4 };
    send_if(tmp2, out0, !tmp6, tmp10);
    let tmp12 = if (!tmp6) { tmp0 } else { tmp10 };
    let tmp13 = if (!tmp6) { tmp1 } else { tmp11 };
    (tmp12, tmp13, tmp6)
  }
}

#[test_proc]
proc gcd_test {
  terminator: chan<bool> out;
  in0_s: chan<s32> out;
  in1_s: chan<s32> out;
  out0_r: chan<s32> in;

  config(terminator: chan<bool> out) {
    let (in0_s, in0_r) = chan<s32>("in0");
    let (in1_s, in1_r) = chan<s32>("in1");
    let (out0_s, out0_r) = chan<s32>("out0");
    spawn gcd(in0_r, in1_r, out0_s);
    (terminator, in0_s, in1_s, out0_r)
  }

  init { () }

  next(state: ()) {
    let tok = join();
    
    // Test case 1: gcd(12, 8) = 4
    let tok = send(tok, in0_s, s32:12);
    let tok = send(tok, in1_s, s32:8);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:4);
    
    // Test case 2: gcd(48, 18) = 6
    let tok = send(tok, in0_s, s32:48);
    let tok = send(tok, in1_s, s32:18);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:6);
    
    // Test case 3: gcd(17, 13) = 1 (coprime)
    let tok = send(tok, in0_s, s32:17);
    let tok = send(tok, in1_s, s32:13);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:1);
    
    // Test case 4: gcd(100, 25) = 25
    let tok = send(tok, in0_s, s32:100);
    let tok = send(tok, in1_s, s32:25);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:25);
    
    // Test case 5: gcd(7, 7) = 7
    let tok = send(tok, in0_s, s32:7);
    let tok = send(tok, in1_s, s32:7);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:7);

    send(tok, terminator, true);
  }
}