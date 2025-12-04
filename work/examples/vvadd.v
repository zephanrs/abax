module __mem__vvadd128_0_next__1(
  input wire clk,
  input wire rst
);
  reg p0_valid;
  reg p1_valid;
  reg p2_valid;
  reg p3_valid;
  wire p3_enable;
  wire p2_enable;
  wire p1_enable;
  wire p0_stage_done;
  wire p0_enable;
  assign p3_enable = 1'h1;
  assign p2_enable = 1'h1;
  assign p1_enable = 1'h1;
  assign p0_stage_done = 1'h1;
  assign p0_enable = 1'h1;
  always_ff @ (posedge clk) begin
    if (rst) begin
      p0_valid <= 1'h0;
      p1_valid <= 1'h0;
      p2_valid <= 1'h0;
      p3_valid <= 1'h0;
    end else begin
      p0_valid <= p0_enable ? p0_stage_done : p0_valid;
      p1_valid <= p1_enable ? p0_valid : p1_valid;
      p2_valid <= p2_enable ? p1_valid : p2_valid;
      p3_valid <= p3_enable ? p2_valid : p3_valid;
    end
  end
endmodule


module __mem__vvadd128__vvadd_0__7_32_128_128_next(
  input wire clk,
  input wire rst,
  input wire mem__done_rdy,
  input wire mem__req_A_rdy,
  input wire mem__req_B_rdy,
  input wire mem__req_C_rdy,
  input wire [31:0] mem__resp_A,
  input wire mem__resp_A_vld,
  input wire [31:0] mem__resp_B,
  input wire mem__resp_B_vld,
  input wire [31:0] mem__resp_C,
  input wire mem__resp_C_vld,
  input wire mem__start,
  input wire mem__start_vld,
  output wire mem__done,
  output wire mem__done_vld,
  output wire [40:0] mem__req_A,
  output wire mem__req_A_vld,
  output wire [40:0] mem__req_B,
  output wire mem__req_B_vld,
  output wire [40:0] mem__req_C,
  output wire mem__req_C_vld,
  output wire mem__resp_A_rdy,
  output wire mem__resp_B_rdy,
  output wire mem__resp_C_rdy,
  output wire mem__start_rdy
);
  wire [31:0] literal_372 = 32'h0000_0000;
  wire [31:0] literal_377 = 32'h0000_0000;
  reg ____state_1;
  reg [6:0] ____state_0;
  reg [6:0] p0_addr;
  reg p0_nand_351;
  reg p0_d;
  reg p1_nand_351;
  reg p1_d;
  reg p0_valid;
  reg p1_valid;
  reg p2_valid;
  reg p3_valid;
  reg __mem__req_A_has_been_sent_reg;
  reg __mem__req_B_has_been_sent_reg;
  reg __mem__req_C_has_been_sent_reg;
  reg __mem__done_has_been_sent_reg;
  wire mem__start_select;
  wire or_408;
  wire or_599;
  wire p2_stage_done;
  wire p2_not_valid;
  wire p1_all_active_inputs_valid;
  wire or_598;
  wire nand_351;
  wire p1_enable;
  wire p1_stage_done;
  wire mem__req_A_not_pred;
  wire p1_data_enable;
  wire p1_not_valid;
  wire [6:0] addr;
  wire or_401;
  wire p0_enable;
  wire [31:0] mem__resp_A_select;
  wire [31:0] mem__resp_B_select;
  wire p0_all_active_outputs_ready;
  wire d;
  wire __mem__req_A_vld_buf;
  wire __mem__req_A_not_has_been_sent;
  wire __mem__req_B_not_has_been_sent;
  wire __mem__req_C_vld_buf;
  wire __mem__req_C_not_has_been_sent;
  wire __mem__done_vld_buf;
  wire __mem__done_not_has_been_sent;
  wire p0_stage_done;
  wire idle;
  wire __mem__req_A_valid_and_not_has_been_sent;
  wire __mem__req_B_valid_and_not_has_been_sent;
  wire __mem__req_C_valid_and_not_has_been_sent;
  wire __mem__done_valid_and_not_has_been_sent;
  wire [31:0] add_384;
  wire p0_data_enable;
  wire __mem__req_A_valid_and_all_active_outputs_ready;
  wire __mem__req_A_valid_and_ready_txfr;
  wire __mem__req_B_valid_and_ready_txfr;
  wire __mem__req_C_valid_and_all_active_outputs_ready;
  wire __mem__req_C_valid_and_ready_txfr;
  wire __mem__done_valid_and_all_active_outputs_ready;
  wire __mem__done_valid_and_ready_txfr;
  wire [40:0] request;
  wire [40:0] request__1;
  wire and_475;
  wire p3_enable;
  wire p2_enable;
  wire [6:0] add_359;
  wire next_idle;
  wire __mem__req_A_not_stage_load;
  wire __mem__req_A_has_been_sent_reg_load_en;
  wire __mem__req_B_has_been_sent_reg_load_en;
  wire __mem__req_C_not_stage_load;
  wire __mem__req_C_has_been_sent_reg_load_en;
  wire __mem__done_not_stage_load;
  wire __mem__done_has_been_sent_reg_load_en;
  assign mem__start_select = ____state_1 ? mem__start : 1'h0;
  assign or_408 = ~p1_nand_351 | mem__resp_C_vld;
  assign or_599 = ~p1_d | mem__done_rdy | __mem__done_has_been_sent_reg;
  assign p2_stage_done = p1_valid & or_408 & or_599;
  assign p2_not_valid = ~p1_valid;
  assign p1_all_active_inputs_valid = (~p0_nand_351 | mem__resp_A_vld) & (~p0_nand_351 | mem__resp_B_vld);
  assign or_598 = ~p0_nand_351 | mem__req_C_rdy | __mem__req_C_has_been_sent_reg;
  assign nand_351 = ~(~mem__start_select & ____state_1);
  assign p1_enable = p2_stage_done | p2_not_valid;
  assign p1_stage_done = p0_valid & p1_all_active_inputs_valid & or_598;
  assign mem__req_A_not_pred = ~nand_351;
  assign p1_data_enable = p1_enable & p1_stage_done;
  assign p1_not_valid = ~p0_valid;
  assign addr = ____state_0 & {7{~mem__start_select}};
  assign or_401 = ~____state_1 | mem__start_vld;
  assign p0_enable = p1_data_enable | p1_not_valid;
  assign mem__resp_A_select = p0_nand_351 ? mem__resp_A : literal_372;
  assign mem__resp_B_select = p0_nand_351 ? mem__resp_B : literal_377;
  assign p0_all_active_outputs_ready = (mem__req_A_not_pred | mem__req_A_rdy | __mem__req_A_has_been_sent_reg) & (mem__req_A_not_pred | mem__req_B_rdy | __mem__req_B_has_been_sent_reg);
  assign d = addr == 7'h7f;
  assign __mem__req_A_vld_buf = or_401 & p0_enable & nand_351;
  assign __mem__req_A_not_has_been_sent = ~__mem__req_A_has_been_sent_reg;
  assign __mem__req_B_not_has_been_sent = ~__mem__req_B_has_been_sent_reg;
  assign __mem__req_C_vld_buf = p1_all_active_inputs_valid & p0_valid & p1_enable & p0_nand_351;
  assign __mem__req_C_not_has_been_sent = ~__mem__req_C_has_been_sent_reg;
  assign __mem__done_vld_buf = or_408 & p1_valid & p1_d;
  assign __mem__done_not_has_been_sent = ~__mem__done_has_been_sent_reg;
  assign p0_stage_done = or_401 & p0_all_active_outputs_ready;
  assign idle = ~(mem__start_select | ~____state_1);
  assign __mem__req_A_valid_and_not_has_been_sent = __mem__req_A_vld_buf & __mem__req_A_not_has_been_sent;
  assign __mem__req_B_valid_and_not_has_been_sent = __mem__req_A_vld_buf & __mem__req_B_not_has_been_sent;
  assign __mem__req_C_valid_and_not_has_been_sent = __mem__req_C_vld_buf & __mem__req_C_not_has_been_sent;
  assign __mem__done_valid_and_not_has_been_sent = __mem__done_vld_buf & __mem__done_not_has_been_sent;
  assign add_384 = mem__resp_A_select[31:0] + mem__resp_B_select[31:0];
  assign p0_data_enable = p0_enable & p0_stage_done;
  assign __mem__req_A_valid_and_all_active_outputs_ready = __mem__req_A_vld_buf & p0_all_active_outputs_ready;
  assign __mem__req_A_valid_and_ready_txfr = __mem__req_A_valid_and_not_has_been_sent & mem__req_A_rdy;
  assign __mem__req_B_valid_and_ready_txfr = __mem__req_B_valid_and_not_has_been_sent & mem__req_B_rdy;
  assign __mem__req_C_valid_and_all_active_outputs_ready = __mem__req_C_vld_buf & or_598;
  assign __mem__req_C_valid_and_ready_txfr = __mem__req_C_valid_and_not_has_been_sent & mem__req_C_rdy;
  assign __mem__done_valid_and_all_active_outputs_ready = __mem__done_vld_buf & or_599;
  assign __mem__done_valid_and_ready_txfr = __mem__done_valid_and_not_has_been_sent & mem__done_rdy;
  assign request = {addr, 32'h0000_0000, 1'h0, 1'h1};
  assign request__1 = {p0_addr, add_384, 1'h1, 1'h0};
  assign and_475 = p1_data_enable & p0_nand_351;
  assign p3_enable = 1'h1;
  assign p2_enable = 1'h1;
  assign add_359 = addr + 7'h01;
  assign next_idle = idle | ~(idle | ~d);
  assign __mem__req_A_not_stage_load = ~__mem__req_A_valid_and_all_active_outputs_ready;
  assign __mem__req_A_has_been_sent_reg_load_en = __mem__req_A_valid_and_ready_txfr | __mem__req_A_valid_and_all_active_outputs_ready;
  assign __mem__req_B_has_been_sent_reg_load_en = __mem__req_B_valid_and_ready_txfr | __mem__req_A_valid_and_all_active_outputs_ready;
  assign __mem__req_C_not_stage_load = ~__mem__req_C_valid_and_all_active_outputs_ready;
  assign __mem__req_C_has_been_sent_reg_load_en = __mem__req_C_valid_and_ready_txfr | __mem__req_C_valid_and_all_active_outputs_ready;
  assign __mem__done_not_stage_load = ~__mem__done_valid_and_all_active_outputs_ready;
  assign __mem__done_has_been_sent_reg_load_en = __mem__done_valid_and_ready_txfr | __mem__done_valid_and_all_active_outputs_ready;
  always_ff @ (posedge clk) begin
    if (rst) begin
      ____state_1 <= 1'h1;
      ____state_0 <= 7'h00;
      p0_addr <= 7'h00;
      p0_nand_351 <= 1'h0;
      p0_d <= 1'h0;
      p1_nand_351 <= 1'h0;
      p1_d <= 1'h0;
      p0_valid <= 1'h0;
      p1_valid <= 1'h0;
      p2_valid <= 1'h0;
      p3_valid <= 1'h0;
      __mem__req_A_has_been_sent_reg <= 1'h0;
      __mem__req_B_has_been_sent_reg <= 1'h0;
      __mem__req_C_has_been_sent_reg <= 1'h0;
      __mem__done_has_been_sent_reg <= 1'h0;
    end else begin
      ____state_1 <= p0_data_enable ? next_idle : ____state_1;
      ____state_0 <= p0_data_enable ? add_359 : ____state_0;
      p0_addr <= p0_data_enable ? addr : p0_addr;
      p0_nand_351 <= p0_data_enable ? nand_351 : p0_nand_351;
      p0_d <= p0_data_enable ? d : p0_d;
      p1_nand_351 <= p1_data_enable ? p0_nand_351 : p1_nand_351;
      p1_d <= p1_data_enable ? p0_d : p1_d;
      p0_valid <= p0_enable ? p0_stage_done : p0_valid;
      p1_valid <= p1_enable ? p1_stage_done : p1_valid;
      p2_valid <= p2_enable ? p2_stage_done : p2_valid;
      p3_valid <= p3_enable ? p2_valid : p3_valid;
      __mem__req_A_has_been_sent_reg <= __mem__req_A_has_been_sent_reg_load_en ? __mem__req_A_not_stage_load : __mem__req_A_has_been_sent_reg;
      __mem__req_B_has_been_sent_reg <= __mem__req_B_has_been_sent_reg_load_en ? __mem__req_A_not_stage_load : __mem__req_B_has_been_sent_reg;
      __mem__req_C_has_been_sent_reg <= __mem__req_C_has_been_sent_reg_load_en ? __mem__req_C_not_stage_load : __mem__req_C_has_been_sent_reg;
      __mem__done_has_been_sent_reg <= __mem__done_has_been_sent_reg_load_en ? __mem__done_not_stage_load : __mem__done_has_been_sent_reg;
    end
  end
  assign mem__done = 1'h1;
  assign mem__done_vld = __mem__done_valid_and_not_has_been_sent;
  assign mem__req_A = request;
  assign mem__req_A_vld = __mem__req_A_valid_and_not_has_been_sent;
  assign mem__req_B = request;
  assign mem__req_B_vld = __mem__req_B_valid_and_not_has_been_sent;
  assign mem__req_C = request__1;
  assign mem__req_C_vld = __mem__req_C_valid_and_not_has_been_sent;
  assign mem__resp_A_rdy = and_475;
  assign mem__resp_B_rdy = and_475;
  assign mem__resp_C_rdy = p2_stage_done & p1_nand_351;
  assign mem__start_rdy = p0_data_enable & ____state_1;
endmodule


module __mem__vvadd128_0_next(
  input wire clk,
  input wire rst,
  input wire mem__done_rdy,
  input wire mem__req_A_rdy,
  input wire mem__req_B_rdy,
  input wire mem__req_C_rdy,
  input wire [31:0] mem__resp_A,
  input wire mem__resp_A_vld,
  input wire [31:0] mem__resp_B,
  input wire mem__resp_B_vld,
  input wire [31:0] mem__resp_C,
  input wire mem__resp_C_vld,
  input wire mem__start,
  input wire mem__start_vld,
  output wire mem__done,
  output wire mem__done_vld,
  output wire [40:0] mem__req_A,
  output wire mem__req_A_vld,
  output wire [40:0] mem__req_B,
  output wire mem__req_B_vld,
  output wire [40:0] mem__req_C,
  output wire mem__req_C_vld,
  output wire mem__resp_A_rdy,
  output wire mem__resp_B_rdy,
  output wire mem__resp_C_rdy,
  output wire mem__start_rdy
);
  wire instantiation_output_532;
  wire instantiation_output_533;
  wire [40:0] instantiation_output_538;
  wire instantiation_output_539;
  wire [40:0] instantiation_output_544;
  wire instantiation_output_545;
  wire [40:0] instantiation_output_550;
  wire instantiation_output_551;
  wire instantiation_output_558;
  wire instantiation_output_564;
  wire instantiation_output_570;
  wire instantiation_output_576;

  // ===== Instantiations
  __mem__vvadd128_0_next__1 __mem__vvadd128_0_next__1_inst0 (
    .rst(rst),
    .clk(clk)
  );
  __mem__vvadd128__vvadd_0__7_32_128_128_next __mem__vvadd128__vvadd_0__7_32_128_128_next_inst1 (
    .rst(rst),
    .mem__done_rdy(mem__done_rdy),
    .mem__req_A_rdy(mem__req_A_rdy),
    .mem__req_B_rdy(mem__req_B_rdy),
    .mem__req_C_rdy(mem__req_C_rdy),
    .mem__resp_A(mem__resp_A),
    .mem__resp_A_vld(mem__resp_A_vld),
    .mem__resp_B(mem__resp_B),
    .mem__resp_B_vld(mem__resp_B_vld),
    .mem__resp_C(mem__resp_C),
    .mem__resp_C_vld(mem__resp_C_vld),
    .mem__start(mem__start),
    .mem__start_vld(mem__start_vld),
    .mem__done(instantiation_output_532),
    .mem__done_vld(instantiation_output_533),
    .mem__req_A(instantiation_output_538),
    .mem__req_A_vld(instantiation_output_539),
    .mem__req_B(instantiation_output_544),
    .mem__req_B_vld(instantiation_output_545),
    .mem__req_C(instantiation_output_550),
    .mem__req_C_vld(instantiation_output_551),
    .mem__resp_A_rdy(instantiation_output_558),
    .mem__resp_B_rdy(instantiation_output_564),
    .mem__resp_C_rdy(instantiation_output_570),
    .mem__start_rdy(instantiation_output_576),
    .clk(clk)
  );
  assign mem__done = instantiation_output_532;
  assign mem__done_vld = instantiation_output_533;
  assign mem__req_A = instantiation_output_538;
  assign mem__req_A_vld = instantiation_output_539;
  assign mem__req_B = instantiation_output_544;
  assign mem__req_B_vld = instantiation_output_545;
  assign mem__req_C = instantiation_output_550;
  assign mem__req_C_vld = instantiation_output_551;
  assign mem__resp_A_rdy = instantiation_output_558;
  assign mem__resp_B_rdy = instantiation_output_564;
  assign mem__resp_C_rdy = instantiation_output_570;
  assign mem__start_rdy = instantiation_output_576;
endmodule
