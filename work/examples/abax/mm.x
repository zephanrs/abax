// Simple dual-port RAM model with independent read and write ports.
// Parameterized on address width, data width, and depth.
// Reads observe the state before a concurrent write (read-before-write).
// Writes always update a full word.

pub struct SimpleReadReq<ADDR_WIDTH: u32> {
  addr: uN[ADDR_WIDTH],
}

pub struct SimpleReadResp<DATA_WIDTH: u32> {
  data: uN[DATA_WIDTH],
}

pub struct SimpleWriteReq<ADDR_WIDTH: u32, DATA_WIDTH: u32> {
  addr: uN[ADDR_WIDTH],
  data: uN[DATA_WIDTH],
}

pub struct SimpleWriteResp {}

pub proc Simple1R1WRam<ADDR_WIDTH: u32, DATA_WIDTH: u32, SIZE: u32> {
  read_req: chan<SimpleReadReq<ADDR_WIDTH>> in;
  read_resp: chan<SimpleReadResp<DATA_WIDTH>> out;
  write_req: chan<SimpleWriteReq<ADDR_WIDTH, DATA_WIDTH>> in;
  write_resp: chan<SimpleWriteResp> out;

  config(read_req: chan<SimpleReadReq<ADDR_WIDTH>> in,
         read_resp: chan<SimpleReadResp<DATA_WIDTH>> out,
         write_req: chan<SimpleWriteReq<ADDR_WIDTH, DATA_WIDTH>> in,
         write_resp: chan<SimpleWriteResp> out) {
    (read_req, read_resp, write_req, write_resp)
  }

  init { uN[DATA_WIDTH][SIZE]:[uN[DATA_WIDTH]:0, ...] }

  next(state: uN[DATA_WIDTH][SIZE]) {
    let (tok_r, r_req, r_valid) =
        recv_non_blocking(join(), read_req, zero!<SimpleReadReq<ADDR_WIDTH>>());
    let (tok_w, w_req, w_valid) =
        recv_non_blocking(join(), write_req, zero!<SimpleWriteReq<ADDR_WIDTH, DATA_WIDTH>>());

    let addr_r = r_req.addr as u32;
    let addr_w = w_req.addr as u32;

    let state_before_write = state;
    let state =
        if w_valid { update(state, addr_w, w_req.data) } else { state };

    let read_data = state_before_write[addr_r];
    send_if(
        tok_r, read_resp, r_valid,
        SimpleReadResp<DATA_WIDTH> { data: read_data });

    send_if(
        tok_w, write_resp, w_valid,
        SimpleWriteResp {});

    state
  }
}


pub proc mm {
  mem0__read_req: chan<SimpleReadReq<u32:4>> out;
  mem0__read_resp: chan<SimpleReadResp<u32:32>> in;
  mem1__read_req: chan<SimpleReadReq<u32:4>> out;
  mem1__read_resp: chan<SimpleReadResp<u32:32>> in;
  mem2__read_req: chan<SimpleReadReq<u32:4>> out;
  mem2__read_resp: chan<SimpleReadResp<u32:32>> in;
  mem2__write_req: chan<SimpleWriteReq<u32:4, u32:32>> out;
  mem2__write_resp: chan<SimpleWriteResp> in;
  go: chan<bool> in;
  done: chan<bool> out;

  config(mem0__read_req: chan<SimpleReadReq<u32:4>> out, mem0__read_resp: chan<SimpleReadResp<u32:32>> in, mem1__read_req: chan<SimpleReadReq<u32:4>> out, mem1__read_resp: chan<SimpleReadResp<u32:32>> in, mem2__read_req: chan<SimpleReadReq<u32:4>> out, mem2__read_resp: chan<SimpleReadResp<u32:32>> in, mem2__write_req: chan<SimpleWriteReq<u32:4, u32:32>> out, mem2__write_resp: chan<SimpleWriteResp> in, go: chan<bool> in, done: chan<bool> out) { (mem0__read_req, mem0__read_resp, mem1__read_req, mem1__read_resp, mem2__read_req, mem2__read_resp, mem2__write_req, mem2__write_resp, go, done) }

  init { (0, 0, 0, false) }

  next(state: (s32, s32, s32, bool)) {
    let (index0, index1, index2, busy) = state;
    let (tok0, tmp0) = recv_if(join(), go, !busy, bool:0);
    let tmp1 = !busy && (tmp0 == bool:1);
    let tmp2 = ((((index0 as s32) * s32:4) + (index2 as s32)) as uN[4]);
    let tmp3 = SimpleReadReq<u32:4> { addr: tmp2 };
    let tok1 = send(join(), mem0__read_req, tmp3);
    let (tok2, tmp4) = recv(tok1, mem0__read_resp);
    let tmp5 = (tmp4.data as s32);
    let tmp6 = ((((index2 as s32) * s32:4) + (index1 as s32)) as uN[4]);
    let tmp7 = SimpleReadReq<u32:4> { addr: tmp6 };
    let tok3 = send(join(), mem1__read_req, tmp7);
    let (tok4, tmp8) = recv(tok3, mem1__read_resp);
    let tmp9 = (tmp8.data as s32);
    let tmp10 = (tmp5 as s64);
    let tmp11 = (tmp9 as s64);
    let tmp12 = (tmp10 * tmp11);
    let tmp13 = ((((index0 as s32) * s32:4) + (index1 as s32)) as uN[4]);
    let tmp14 = SimpleReadReq<u32:4> { addr: tmp13 };
    let tok5 = send(join(), mem2__read_req, tmp14);
    let (tok6, tmp15) = recv(tok5, mem2__read_resp);
    let tmp16 = (tmp15.data as s32);
    let tmp17 = (tmp12 as s32);
    let tmp18 = (tmp16 + tmp17);
    let tmp19 = ((((index0 as s32) * s32:4) + (index1 as s32)) as uN[4]);
    let tmp20 = (tmp18 as uN[32]);
    let tmp21 = SimpleWriteReq<u32:4, u32:32> { addr: tmp19, data: tmp20 };
    let tok7 = join(tok0, tok2, tok4, tok6);
    let tok8 = send(tok7, mem2__write_req, tmp21);
    let (tok9, _) = recv(tok8, mem2__write_resp);
    let tmp22 = if (index2 + 1 >= s32:4) { s32:0 } else { index2 + 1 };
    let tmp23 = index2 + 1 >= s32:4;
    let tmp24 = if (tmp23 && index1 + 1 >= s32:4) { s32:0 } else if (tmp23) { index1 + 1 } else { index1 };
    let tmp25 = tmp23 && (index1 + 1 >= s32:4);
    let tmp26 = if (tmp25 && index0 + 1 >= s32:4) { s32:0 } else if (tmp25) { index0 + 1 } else { index0 };
    let tmp27 = tmp25 && (index0 + 1 >= s32:4);
    let tok10 = send_if(tok9, done, tmp27, bool:1);
    let tmp28 = if (tmp27) { s32:0 } else { tmp26 };
    let tmp29 = if (tmp27) { s32:0 } else { tmp24 };
    let tmp30 = if (tmp27) { s32:0 } else { tmp22 };
    let tmp31 = (tmp1) || (busy && !tmp27);
    (tmp28, tmp29, tmp30, tmp31)
  }
}