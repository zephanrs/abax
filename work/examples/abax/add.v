module __add__add_0_next(
  input wire clk,
  input wire rst,
  input wire [31:0] add__in0,
  input wire add__in0_vld,
  input wire [31:0] add__in1,
  input wire add__in1_vld,
  input wire add__out0_rdy,
  output wire add__in0_rdy,
  output wire add__in1_rdy,
  output wire [31:0] add__out0,
  output wire add__out0_vld
);
  function automatic [1:0] priority_sel_2b_2way (input reg [1:0] sel, input reg [1:0] case0, input reg [1:0] case1, input reg [1:0] default_value);
    begin
      unique casez (sel)
        2'b?1: begin
          priority_sel_2b_2way = case0;
        end
        2'b10: begin
          priority_sel_2b_2way = case1;
        end
        2'b00: begin
          priority_sel_2b_2way = default_value;
        end
        default: begin
          // Propagate X
          priority_sel_2b_2way = 'X;
        end
      endcase
    end
  endfunction
  function automatic [2:0] priority_sel_3b_2way (input reg [1:0] sel, input reg [2:0] case0, input reg [2:0] case1, input reg [2:0] default_value);
    begin
      unique casez (sel)
        2'b?1: begin
          priority_sel_3b_2way = case0;
        end
        2'b10: begin
          priority_sel_3b_2way = case1;
        end
        2'b00: begin
          priority_sel_3b_2way = default_value;
        end
        default: begin
          // Propagate X
          priority_sel_3b_2way = 'X;
        end
      endcase
    end
  endfunction
  function automatic logic priority_sel_1b_2way (input reg [1:0] sel, input reg case0, input reg case1, input reg default_value);
    begin
      unique casez (sel)
        2'b?1: begin
          priority_sel_1b_2way = case0;
        end
        2'b10: begin
          priority_sel_1b_2way = case1;
        end
        2'b00: begin
          priority_sel_1b_2way = default_value;
        end
        default: begin
          // Propagate X
          priority_sel_1b_2way = 'X;
        end
      endcase
    end
  endfunction
  wire [31:0] __add__in1_reg_init = {1'h0, 8'h00, 23'h00_0000};
  wire [31:0] __add__in0_reg_init = {1'h0, 8'h00, 23'h00_0000};
  wire [31:0] __add__out0_reg_init = {1'h0, 8'h00, 23'h00_0000};
  reg [31:0] __add__in1_reg;
  reg __add__in1_valid_reg;
  reg [31:0] __add__in0_reg;
  reg __add__in0_valid_reg;
  reg [31:0] __add__out0_reg;
  reg __add__out0_valid_reg;
  wire [7:0] tmp1_bexp;
  wire [7:0] tmp0_bexp;
  wire [7:0] tmp1_bexpnot;
  wire [8:0] tmp0_bexp_extended__1;
  wire [8:0] tmp1_bexpnot_extended;
  wire [8:0] full_result;
  wire overflow_detected;
  wire [22:0] tuple_index_31232;
  wire [22:0] tuple_index_31233;
  wire [7:0] x_bexp;
  wire [7:0] y_bexp;
  wire [22:0] x_fraction;
  wire [22:0] y_fraction;
  wire nc;
  wire [23:0] fraction_x;
  wire [23:0] fraction_y;
  wire [23:0] sign_ext_31244;
  wire [7:0] narrowed_result;
  wire [7:0] tmp0_bexpor_mask;
  wire tuple_index_31247;
  wire tuple_index_31248;
  wire [23:0] fraction_x__1;
  wire [23:0] fraction_y__1;
  wire [2:0] tmp0ddend_x__1_squeezed_const_lsb_bits;
  wire [7:0] result;
  wire x_sign;
  wire y_sign;
  wire [24:0] wide_x_squeezed;
  wire [26:0] wide_y_shift_bits;
  wire [7:0] shift;
  wire [26:0] shrl_31260;
  wire [27:0] shll_31262;
  wire [24:0] tmp0ddend_x__1_squeezed;
  wire [25:0] add_31271;
  wire sticky;
  wire [27:0] concat_31277;
  wire [27:0] tmp0bs_fraction;
  wire carry_bit;
  wire nor_31318;
  wire nor_31313;
  wire nor_31314;
  wire nor_31304;
  wire nor_31305;
  wire and_31347;
  wire nor_31349;
  wire nor_31351;
  wire and_31344;
  wire nor_31340;
  wire and_31336;
  wire nor_31337;
  wire nor_31331;
  wire nor_31333;
  wire and_31376;
  wire nor_31357;
  wire nor_31358;
  wire and_31397;
  wire [1:0] priority_sel_31398;
  wire and_31393;
  wire and_31389;
  wire and_31385;
  wire [2:0] concat_31411;
  wire [2:0] concat_31408;
  wire [2:0] concat_31407;
  wire [2:0] concat_31405;
  wire [2:0] concat_31404;
  wire and_31416;
  wire [3:0] concat_31420;
  wire [3:0] sel_31560;
  wire [4:0] concat_31428;
  wire [4:0] leading_zeroes;
  wire [28:0] cancel_fraction;
  wire [26:0] cancel_fraction__1;
  wire [26:0] carry_fraction__1;
  wire [26:0] shifted_fraction;
  wire [2:0] normal_chunk;
  wire [2:0] fraction_shift__3;
  wire [1:0] half_way_chunk;
  wire do_round_up;
  wire [24:0] add_31446;
  wire rounding_carry;
  wire [8:0] add_31456;
  wire [5:0] sub_31457;
  wire fraction_is_zero;
  wire [9:0] wide_exponent_associative_element;
  wire [9:0] wide_exponent_associative_element__1;
  wire [9:0] wide_exponent;
  wire [9:0] wide_exponent__1;
  wire [7:0] MAX_EXPONENT;
  wire [8:0] wide_exponent__2;
  wire eq_31470;
  wire eq_31471;
  wire eq_31472;
  wire eq_31473;
  wire [2:0] fraction_shift__2;
  wire is_operand_inf;
  wire and_reduce_31490;
  wire add__out0_valid_inv;
  wire has_pos_inf;
  wire has_neg_inf;
  wire [27:0] rounded_fraction;
  wire [2:0] fraction_shift__1;
  wire p0_all_active_inputs_valid;
  wire add__out0_valid_load_en;
  wire [27:0] shrl_31503;
  wire add__out0_load_en;
  wire is_result_nan;
  wire result_sign;
  wire [22:0] result_fraction;
  wire [22:0] sign_ext_31509;
  wire p0_stage_done;
  wire add__in0_valid_inv;
  wire add__in1_valid_inv;
  wire result_sign__1;
  wire [22:0] result_fraction__3;
  wire [22:0] FRACTION_HIGH_BIT;
  wire add__in0_valid_load_en;
  wire add__in1_valid_load_en;
  wire result_sign__2;
  wire [7:0] result_exponent__2;
  wire [22:0] result_fraction__4;
  wire add__in0_load_en;
  wire add__in1_load_en;
  wire [31:0] tmp2;
  assign tmp1_bexp = __add__in1_reg[30:23];
  assign tmp0_bexp = __add__in0_reg[30:23];
  assign tmp1_bexpnot = ~tmp1_bexp;
  assign tmp0_bexp_extended__1 = {1'h0, tmp0_bexp};
  assign tmp1_bexpnot_extended = {1'h0, tmp1_bexpnot};
  assign full_result = tmp0_bexp_extended__1 + tmp1_bexpnot_extended;
  assign overflow_detected = full_result[8];
  assign tuple_index_31232 = __add__in1_reg[22:0];
  assign tuple_index_31233 = __add__in0_reg[22:0];
  assign x_bexp = overflow_detected ? tmp0_bexp : tmp1_bexp;
  assign y_bexp = overflow_detected ? tmp1_bexp : tmp0_bexp;
  assign x_fraction = overflow_detected ? tuple_index_31233 : tuple_index_31232;
  assign y_fraction = overflow_detected ? tuple_index_31232 : tuple_index_31233;
  assign nc = ~overflow_detected;
  assign fraction_x = {1'h1, x_fraction};
  assign fraction_y = {1'h1, y_fraction};
  assign sign_ext_31244 = {24{y_bexp != 8'h00}};
  assign narrowed_result = full_result[7:0];
  assign tmp0_bexpor_mask = {8{nc}};
  assign tuple_index_31247 = __add__in1_reg[31:31];
  assign tuple_index_31248 = __add__in0_reg[31:31];
  assign fraction_x__1 = fraction_x & {24{x_bexp != 8'h00}};
  assign fraction_y__1 = fraction_y & sign_ext_31244;
  assign tmp0ddend_x__1_squeezed_const_lsb_bits = 3'h0;
  assign result = narrowed_result ^ tmp0_bexpor_mask;
  assign x_sign = overflow_detected ? tuple_index_31248 : tuple_index_31247;
  assign y_sign = overflow_detected ? tuple_index_31247 : tuple_index_31248;
  assign wide_x_squeezed = {1'h0, fraction_x__1};
  assign wide_y_shift_bits = {fraction_y__1, tmp0ddend_x__1_squeezed_const_lsb_bits};
  assign shift = result + {7'h00, overflow_detected};
  assign shrl_31260 = shift >= 8'h1b ? 27'h000_0000 : wide_y_shift_bits >> shift;
  assign shll_31262 = shift >= 8'h1c ? 28'h000_0000 : 28'hfff_ffff << shift;
  assign tmp0ddend_x__1_squeezed = x_sign ^ y_sign ? -wide_x_squeezed : wide_x_squeezed;
  assign add_31271 = {{1{tmp0ddend_x__1_squeezed[24]}}, tmp0ddend_x__1_squeezed} + {2'h0, shrl_31260[26:3]};
  assign sticky = ~({1'h0, ~y_fraction} | ~sign_ext_31244 | shll_31262[26:3]) != 24'h00_0000;
  assign concat_31277 = {add_31271[24:0], shrl_31260[2:1], shrl_31260[0] | sticky};
  assign tmp0bs_fraction = add_31271[25] ? -concat_31277 : concat_31277;
  assign carry_bit = tmp0bs_fraction[27];
  assign nor_31318 = ~(tmp0bs_fraction[25] | tmp0bs_fraction[24]);
  assign nor_31313 = ~(tmp0bs_fraction[17] | tmp0bs_fraction[16]);
  assign nor_31314 = ~(tmp0bs_fraction[19] | tmp0bs_fraction[18]);
  assign nor_31304 = ~(tmp0bs_fraction[9] | tmp0bs_fraction[8]);
  assign nor_31305 = ~(tmp0bs_fraction[11] | tmp0bs_fraction[10]);
  assign and_31347 = ~(carry_bit | tmp0bs_fraction[26]) & nor_31318;
  assign nor_31349 = ~(tmp0bs_fraction[21] | tmp0bs_fraction[20]);
  assign nor_31351 = ~(carry_bit | ~tmp0bs_fraction[26]);
  assign and_31344 = nor_31314 & nor_31313;
  assign nor_31340 = ~(tmp0bs_fraction[13] | tmp0bs_fraction[12]);
  assign and_31336 = nor_31305 & nor_31304;
  assign nor_31337 = ~(tmp0bs_fraction[11] | ~tmp0bs_fraction[10]);
  assign nor_31331 = ~(tmp0bs_fraction[5] | tmp0bs_fraction[4]);
  assign nor_31333 = ~(tmp0bs_fraction[7] | tmp0bs_fraction[6]);
  assign and_31376 = ~(tmp0bs_fraction[23] | tmp0bs_fraction[22]) & nor_31349;
  assign nor_31357 = ~(tmp0bs_fraction[1] | tmp0bs_fraction[0]);
  assign nor_31358 = ~(tmp0bs_fraction[3] | tmp0bs_fraction[2]);
  assign and_31397 = and_31347 & and_31376;
  assign priority_sel_31398 = priority_sel_2b_2way({~(carry_bit | tmp0bs_fraction[26] | nor_31318), and_31347}, {nor_31351, 1'h0}, {1'h1, ~(tmp0bs_fraction[25] | ~tmp0bs_fraction[24])}, {1'h0, nor_31351});
  assign and_31393 = ~(tmp0bs_fraction[15] | tmp0bs_fraction[14]) & nor_31340;
  assign and_31389 = nor_31333 & nor_31331;
  assign and_31385 = nor_31358 & nor_31357;
  assign concat_31411 = {1'h1, ~(tmp0bs_fraction[23] | tmp0bs_fraction[22] | nor_31349) ? {1'h1, ~(tmp0bs_fraction[21] | ~tmp0bs_fraction[20])} : {1'h0, ~(tmp0bs_fraction[23] | ~tmp0bs_fraction[22])}};
  assign concat_31408 = {and_31344, priority_sel_2b_2way({~(tmp0bs_fraction[19] | tmp0bs_fraction[18] | nor_31313), and_31344}, 2'h0, {1'h1, ~(tmp0bs_fraction[17] | ~tmp0bs_fraction[16])}, {nor_31314, ~(tmp0bs_fraction[19] | ~tmp0bs_fraction[18])})};
  assign concat_31407 = {1'h1, ~(tmp0bs_fraction[15] | tmp0bs_fraction[14] | nor_31340) ? {1'h1, ~(tmp0bs_fraction[13] | ~tmp0bs_fraction[12])} : {1'h0, ~(tmp0bs_fraction[15] | ~tmp0bs_fraction[14])}};
  assign concat_31405 = {and_31336, priority_sel_2b_2way({~(tmp0bs_fraction[11] | tmp0bs_fraction[10] | nor_31304), and_31336}, {nor_31337, 1'h0}, {1'h1, ~(tmp0bs_fraction[9] | ~tmp0bs_fraction[8])}, {nor_31305, nor_31337})};
  assign concat_31404 = {1'h1, ~(tmp0bs_fraction[7] | tmp0bs_fraction[6] | nor_31331) ? {1'h1, ~(tmp0bs_fraction[5] | ~tmp0bs_fraction[4])} : {nor_31333, ~(tmp0bs_fraction[7] | ~tmp0bs_fraction[6])}};
  assign and_31416 = and_31344 & and_31393;
  assign concat_31420 = {1'h1, and_31385, priority_sel_2b_2way({~(tmp0bs_fraction[3] | tmp0bs_fraction[2] | nor_31357), and_31385}, 2'h0, {1'h1, ~(tmp0bs_fraction[1] | ~tmp0bs_fraction[0])}, {nor_31358, ~(tmp0bs_fraction[3] | ~tmp0bs_fraction[2])})};
  assign sel_31560 = ~(~and_31397 | and_31416) ? {1'h1, ~(~and_31344 | and_31393) ? concat_31407 : concat_31408} : {and_31397, priority_sel_3b_2way({~(~and_31347 | and_31376), and_31397}, {priority_sel_31398, 1'h0}, concat_31411, {1'h0, priority_sel_31398})};
  assign concat_31428 = {1'h1, and_31336 & and_31389 ? concat_31420 : {1'h0, ~(~and_31336 | and_31389) ? concat_31404 : concat_31405}};
  assign leading_zeroes = and_31397 & and_31416 ? concat_31428 : {1'h0, sel_31560};
  assign cancel_fraction = leading_zeroes >= 5'h1d ? 29'h0000_0000 : {1'h0, tmp0bs_fraction} << leading_zeroes;
  assign cancel_fraction__1 = cancel_fraction[27:1];
  assign carry_fraction__1 = {tmp0bs_fraction[27:2], tmp0bs_fraction[1] | tmp0bs_fraction[0]};
  assign shifted_fraction = carry_bit ? carry_fraction__1 : cancel_fraction__1;
  assign normal_chunk = shifted_fraction[2:0];
  assign fraction_shift__3 = 3'h4;
  assign half_way_chunk = shifted_fraction[3:2];
  assign do_round_up = normal_chunk > fraction_shift__3 | half_way_chunk == 2'h3;
  assign add_31446 = {1'h0, shifted_fraction[26:3]} + {24'h00_0000, do_round_up};
  assign rounding_carry = add_31446[24];
  assign add_31456 = {1'h0, x_bexp} + 9'h001;
  assign sub_31457 = {5'h00, rounding_carry} - {1'h0, leading_zeroes};
  assign fraction_is_zero = add_31271 == 26'h000_0000 & ~(shrl_31260[1] | shrl_31260[2]) & ~(shrl_31260[0] | sticky);
  assign wide_exponent_associative_element = {1'h0, add_31456};
  assign wide_exponent_associative_element__1 = {{4{sub_31457[5]}}, sub_31457};
  assign wide_exponent = wide_exponent_associative_element + wide_exponent_associative_element__1;
  assign wide_exponent__1 = wide_exponent & {10{~fraction_is_zero}};
  assign MAX_EXPONENT = 8'hff;
  assign wide_exponent__2 = wide_exponent__1[8:0] & {9{~wide_exponent__1[9]}};
  assign eq_31470 = x_bexp == MAX_EXPONENT;
  assign eq_31471 = x_fraction == 23'h00_0000;
  assign eq_31472 = y_bexp == MAX_EXPONENT;
  assign eq_31473 = y_fraction == 23'h00_0000;
  assign fraction_shift__2 = 3'h3;
  assign is_operand_inf = eq_31470 & eq_31471 | eq_31472 & eq_31473;
  assign and_reduce_31490 = &wide_exponent__2[7:0];
  assign add__out0_valid_inv = ~__add__out0_valid_reg;
  assign has_pos_inf = ~(~eq_31470 | ~eq_31471 | x_sign) | ~(~eq_31472 | ~eq_31473 | y_sign);
  assign has_neg_inf = eq_31470 & eq_31471 & x_sign | eq_31472 & eq_31473 & y_sign;
  assign rounded_fraction = {add_31446, normal_chunk};
  assign fraction_shift__1 = rounding_carry ? fraction_shift__3 : fraction_shift__2;
  assign p0_all_active_inputs_valid = __add__in1_valid_reg & __add__in0_valid_reg;
  assign add__out0_valid_load_en = add__out0_rdy | add__out0_valid_inv;
  assign shrl_31503 = rounded_fraction >> fraction_shift__1;
  assign add__out0_load_en = p0_all_active_inputs_valid & add__out0_valid_load_en;
  assign is_result_nan = ~(~eq_31470 | eq_31471) | ~(~eq_31472 | eq_31473) | has_pos_inf & has_neg_inf;
  assign result_sign = priority_sel_1b_2way({add_31271[25], fraction_is_zero}, x_sign & y_sign, ~y_sign, y_sign);
  assign result_fraction = shrl_31503[22:0];
  assign sign_ext_31509 = {23{~(is_operand_inf | wide_exponent__2[8] | and_reduce_31490 | ~((|wide_exponent__2[8:1]) | wide_exponent__2[0]))}};
  assign p0_stage_done = p0_all_active_inputs_valid & add__out0_load_en;
  assign add__in0_valid_inv = ~__add__in0_valid_reg;
  assign add__in1_valid_inv = ~__add__in1_valid_reg;
  assign result_sign__1 = is_operand_inf ? ~has_pos_inf : result_sign;
  assign result_fraction__3 = result_fraction & sign_ext_31509;
  assign FRACTION_HIGH_BIT = 23'h40_0000;
  assign add__in0_valid_load_en = p0_stage_done | add__in0_valid_inv;
  assign add__in1_valid_load_en = p0_stage_done | add__in1_valid_inv;
  assign result_sign__2 = ~is_result_nan & result_sign__1;
  assign result_exponent__2 = is_result_nan | is_operand_inf | wide_exponent__2[8] | and_reduce_31490 ? MAX_EXPONENT : wide_exponent__2[7:0];
  assign result_fraction__4 = is_result_nan ? FRACTION_HIGH_BIT : result_fraction__3;
  assign add__in0_load_en = add__in0_vld & add__in0_valid_load_en;
  assign add__in1_load_en = add__in1_vld & add__in1_valid_load_en;
  assign tmp2 = {result_sign__2, result_exponent__2, result_fraction__4};
  always_ff @ (posedge clk) begin
    if (rst) begin
      __add__in1_reg <= __add__in1_reg_init;
      __add__in1_valid_reg <= 1'h0;
      __add__in0_reg <= __add__in0_reg_init;
      __add__in0_valid_reg <= 1'h0;
      __add__out0_reg <= __add__out0_reg_init;
      __add__out0_valid_reg <= 1'h0;
    end else begin
      __add__in1_reg <= add__in1_load_en ? add__in1 : __add__in1_reg;
      __add__in1_valid_reg <= add__in1_valid_load_en ? add__in1_vld : __add__in1_valid_reg;
      __add__in0_reg <= add__in0_load_en ? add__in0 : __add__in0_reg;
      __add__in0_valid_reg <= add__in0_valid_load_en ? add__in0_vld : __add__in0_valid_reg;
      __add__out0_reg <= add__out0_load_en ? tmp2 : __add__out0_reg;
      __add__out0_valid_reg <= add__out0_valid_load_en ? p0_all_active_inputs_valid : __add__out0_valid_reg;
    end
  end
  assign add__in0_rdy = add__in0_load_en;
  assign add__in1_rdy = add__in1_load_en;
  assign add__out0 = __add__out0_reg;
  assign add__out0_vld = __add__out0_valid_reg;
endmodule
