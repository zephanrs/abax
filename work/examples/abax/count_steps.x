pub proc count_steps {
  in0: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, out0: chan<s32> out) { (in0, out0) }

  init { (0, 0, false) }

  next(state: (s32, s32, bool)) {
    let (acc0, acc1, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, acc0);
    let tmp1 = if (!busy) { tmp0 } else { acc1 };
    let tmp2 = (tmp1 > s32:1);
    let tmp3 = tmp2;
    let tmp4 = (tmp1 % s32:2);
    let tmp5 = (tmp4 == s32:0);
    let tmp6 = (tmp1 / s32:2);
    let tmp7 = tmp6;
    let tmp8 = (tmp1 as s33);
    let tmp9 = (tmp8 - s33:1);
    let tmp10 = (tmp9 as s32);
    let tmp11 = tmp10;
    let tmp12 = if (tmp5) { tmp7 } else { tmp11 };
    let tmp13 = (acc0 as s33);
    let tmp14 = (tmp13 + s33:1);
    let tmp15 = (tmp14 as s32);
    let tmp16 = tmp15;
    let tmp17 = if (tmp3) { tmp16 } else { acc0 };
    let tmp18 = if (tmp3) { tmp12 } else { tmp1 };
    send_if(tok0, out0, !tmp3, tmp17);
    let tmp19 = if (!tmp3) { 0 } else { tmp17 };
    let tmp20 = if (!tmp3) { tmp0 } else { tmp18 };
    (tmp19, tmp20, tmp3)
  }
}

#[test_proc]
proc count_steps_test {
  terminator: chan<bool> out;
  in0_s: chan<s32> out;
  out0_r: chan<s32> in;

  config(terminator: chan<bool> out) {
    let (in0_s, in0_r) = chan<s32>("in0");
    let (out0_s, out0_r) = chan<s32>("out0");
    spawn count_steps(in0_r, out0_s);
    (terminator, in0_s, out0_r)
  }

  init { () }

  next(state: ()) {
    let tok = join();
    
    // Test case 1: count_steps(1) = 0 (already at 1)
    let tok = send(tok, in0_s, s32:1);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:0);
    
    // Test case 2: count_steps(2) = 1 (2 -> 1)
    let tok = send(tok, in0_s, s32:2);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:1);
    
    // Test case 3: count_steps(4) = 2 (4 -> 2 -> 1)
    let tok = send(tok, in0_s, s32:4);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:2);
    
    // Test case 4: count_steps(7) = 4 (7 -> 6 -> 3 -> 2 -> 1)
    let tok = send(tok, in0_s, s32:7);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:4);
    
    // Test case 5: count_steps(16) = 4 (16 -> 8 -> 4 -> 2 -> 1)
    let tok = send(tok, in0_s, s32:16);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:4);

    send(tok, terminator, true);
  }
}