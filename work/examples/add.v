module __state__add_0_next(
  input wire clk,
  input wire rst,
  input wire [31:0] state__A,
  input wire state__A_vld,
  input wire [31:0] state__B,
  input wire state__B_vld,
  input wire state__C_rdy,
  output wire state__A_rdy,
  output wire state__B_rdy,
  output wire [31:0] state__C,
  output wire state__C_vld
);
  reg [31:0] __state__A_reg;
  reg __state__A_valid_reg;
  reg [31:0] __state__B_reg;
  reg __state__B_valid_reg;
  reg [31:0] __state__C_reg;
  reg __state__C_valid_reg;
  wire state__C_valid_inv;
  wire p0_all_active_inputs_valid;
  wire state__C_valid_load_en;
  wire state__C_load_en;
  wire p0_stage_done;
  wire state__A_valid_inv;
  wire state__B_valid_inv;
  wire state__A_valid_load_en;
  wire state__B_valid_load_en;
  wire state__A_load_en;
  wire state__B_load_en;
  wire [31:0] sum;
  assign state__C_valid_inv = ~__state__C_valid_reg;
  assign p0_all_active_inputs_valid = __state__A_valid_reg & __state__B_valid_reg;
  assign state__C_valid_load_en = state__C_rdy | state__C_valid_inv;
  assign state__C_load_en = p0_all_active_inputs_valid & state__C_valid_load_en;
  assign p0_stage_done = p0_all_active_inputs_valid & state__C_load_en;
  assign state__A_valid_inv = ~__state__A_valid_reg;
  assign state__B_valid_inv = ~__state__B_valid_reg;
  assign state__A_valid_load_en = p0_stage_done | state__A_valid_inv;
  assign state__B_valid_load_en = p0_stage_done | state__B_valid_inv;
  assign state__A_load_en = state__A_vld & state__A_valid_load_en;
  assign state__B_load_en = state__B_vld & state__B_valid_load_en;
  assign sum = __state__A_reg + __state__B_reg;
  always_ff @ (posedge clk) begin
    if (rst) begin
      __state__A_reg <= 32'h0000_0000;
      __state__A_valid_reg <= 1'h0;
      __state__B_reg <= 32'h0000_0000;
      __state__B_valid_reg <= 1'h0;
      __state__C_reg <= 32'h0000_0000;
      __state__C_valid_reg <= 1'h0;
    end else begin
      __state__A_reg <= state__A_load_en ? state__A : __state__A_reg;
      __state__A_valid_reg <= state__A_valid_load_en ? state__A_vld : __state__A_valid_reg;
      __state__B_reg <= state__B_load_en ? state__B : __state__B_reg;
      __state__B_valid_reg <= state__B_valid_load_en ? state__B_vld : __state__B_valid_reg;
      __state__C_reg <= state__C_load_en ? sum : __state__C_reg;
      __state__C_valid_reg <= state__C_valid_load_en ? p0_all_active_inputs_valid : __state__C_valid_reg;
    end
  end
  assign state__A_rdy = state__A_load_en;
  assign state__B_rdy = state__B_load_en;
  assign state__C = __state__C_reg;
  assign state__C_vld = __state__C_valid_reg;
endmodule
