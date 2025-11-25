pub proc nested_sum {
  in0: chan<s32> in;
  in1: chan<s32> in;
  out0: chan<s32> out;

  config(in0: chan<s32> in, in1: chan<s32> in, out0: chan<s32> out) { (in0, in1, out0) }

  init { (0, 0, 0, 0, 0, false) }

  next(state: (s32, s32, s32, s32, s32, bool)) {
    let (acc0, index0, ub0, index1, ub1, busy) = state;
    let (tok0, tmp0) = recv_if(join(), in0, !busy, ub0);
    let (tok1, tmp1) = recv_if(join(), in1, !busy, ub1);
    let tmp2 = (index0 * index1);
    let tmp3 = (acc0 as s34);
    let tmp4 = (tmp2 as s34);
    let tmp5 = (tmp3 + tmp4);
    let tmp6 = (tmp5 as s32);
    let tmp7 = tmp6;
    let tmp8 = if (index1 + 1 >= tmp1) { s32:0 } else { index1 + 1 };
    let tmp9 = index1 + 1 >= tmp1;
    let tmp10 = if (tmp9 && index0 + 1 >= tmp0) { s32:0 } else if (tmp9) { index0 + 1 } else { index0 };
    let tmp11 = tmp9 && (index0 + 1 >= tmp0);
    send_if(tok1, out0, tmp11, tmp7);
    let tmp12 = if (tmp11) { 0 } else { tmp7 };
    let tmp13 = if (tmp11) { s32:0 } else { tmp10 };
    let tmp14 = if (tmp11) { s32:0 } else { tmp8 };
    let tmp15 = !tmp11;
    (tmp12, tmp13, tmp0, tmp14, tmp1, tmp15)
  }
}

#[test_proc]
proc nested_sum_test {
  terminator: chan<bool> out;
  in0_s: chan<s32> out;
  in1_s: chan<s32> out;
  out0_r: chan<s32> in;

  config(terminator: chan<bool> out) {
    let (in0_s, in0_r) = chan<s32>("in0");
    let (in1_s, in1_r) = chan<s32>("in1");
    let (out0_s, out0_r) = chan<s32>("out0");
    spawn nested_sum(in0_r, in1_r, out0_s);
    (terminator, in0_s, in1_s, out0_r)
  }

  init { () }

  next(state: ()) {
    let tok = join();
    
    // Test case 1: nested_sum(2, 3) = sum of i*j for i in [0,2), j in [0,3)
    // = 0*0 + 0*1 + 0*2 + 1*0 + 1*1 + 1*2 = 0 + 0 + 0 + 0 + 1 + 2 = 3
    let tok = send(tok, in0_s, s32:2);
    let tok = send(tok, in1_s, s32:3);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:3);
    
    // Test case 2: nested_sum(3, 3) = sum of i*j for i in [0,3), j in [0,3)
    // = 0 + 0 + 0 + 0 + 1 + 2 + 0 + 2 + 4 = 9
    let tok = send(tok, in0_s, s32:3);
    let tok = send(tok, in1_s, s32:3);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:9);
    
    // Test case 3: nested_sum(1, 5) = sum of i*j for i in [0,1), j in [0,5)
    // = 0*0 + 0*1 + 0*2 + 0*3 + 0*4 = 0
    let tok = send(tok, in0_s, s32:1);
    let tok = send(tok, in1_s, s32:5);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:0);
    
    // Test case 4: nested_sum(4, 4)
    // = sum of i*j for i,j in [0,4) = 0+0+0+0 + 0+1+2+3 + 0+2+4+6 + 0+3+6+9 = 36
    let tok = send(tok, in0_s, s32:4);
    let tok = send(tok, in1_s, s32:4);
    let (tok, result) = recv(tok, out0_r);
    assert_eq(result, s32:36);

    send(tok, terminator, true);
  }
}