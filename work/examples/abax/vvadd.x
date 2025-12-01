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


pub proc vvadd {
  mem0__read_req: chan<SimpleReadReq<u32:5>> out;
  mem0__read_resp: chan<SimpleReadResp<u32:32>> in;
  mem1__read_req: chan<SimpleReadReq<u32:5>> out;
  mem1__read_resp: chan<SimpleReadResp<u32:32>> in;
  mem2__write_req: chan<SimpleWriteReq<u32:5, u32:32>> out;
  mem2__write_resp: chan<SimpleWriteResp> in;
  go: chan<bool> in;
  done: chan<bool> out;

  config(mem0__read_req: chan<SimpleReadReq<u32:5>> out, mem0__read_resp: chan<SimpleReadResp<u32:32>> in, mem1__read_req: chan<SimpleReadReq<u32:5>> out, mem1__read_resp: chan<SimpleReadResp<u32:32>> in, mem2__write_req: chan<SimpleWriteReq<u32:5, u32:32>> out, mem2__write_resp: chan<SimpleWriteResp> in, go: chan<bool> in, done: chan<bool> out) { (mem0__read_req, mem0__read_resp, mem1__read_req, mem1__read_resp, mem2__write_req, mem2__write_resp, go, done) }

  init { (0, false) }

  next(state: (s32, bool)) {
    let (index0, busy) = state;
    let (tok0, tmp0) = recv_if(join(), go, !busy, bool:0);
    let tmp1 = !busy && (tmp0 == bool:1);
    let tmp2 = ((index0 as s32) as uN[5]);
    let tmp3 = SimpleReadReq<u32:5> { addr: tmp2 };
    let tok1 = send(join(), mem0__read_req, tmp3);
    let (tok2, tmp4) = recv(tok1, mem0__read_resp);
    let tmp5 = (tmp4.data as s32);
    let tmp6 = ((index0 as s32) as uN[5]);
    let tmp7 = SimpleReadReq<u32:5> { addr: tmp6 };
    let tok3 = send(join(), mem1__read_req, tmp7);
    let (tok4, tmp8) = recv(tok3, mem1__read_resp);
    let tmp9 = (tmp8.data as s32);
    let tmp10 = (tmp5 as s33);
    let tmp11 = (tmp9 as s33);
    let tmp12 = (tmp10 + tmp11);
    let tmp13 = (tmp12 as s32);
    let tmp14 = ((index0 as s32) as uN[5]);
    let tmp15 = (tmp13 as uN[32]);
    let tmp16 = SimpleWriteReq<u32:5, u32:32> { addr: tmp14, data: tmp15 };
    let tok5 = join(tok0, tok2, tok4);
    let tok6 = send(tok5, mem2__write_req, tmp16);
    let (tok7, _) = recv(tok6, mem2__write_resp);
    let tmp17 = if (index0 + 1 >= s32:32) { s32:0 } else { index0 + 1 };
    let tmp18 = index0 + 1 >= s32:32;
    let tok8 = send_if(tok7, done, tmp18, bool:1);
    let tmp19 = if (tmp18) { s32:0 } else { tmp17 };
    let tmp20 = (tmp1) || (busy && !tmp18);
    (tmp19, tmp20)
  }
}