// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : Instruction_Fetcher
// Git hash  : 9ecf148c235ca4ff4f842a6d692883944a632ac4

`timescale 1ns/1ps

module Instruction_Fetcher (
  input               clk,
  input               rst,
  input               branch,
  input               jump,
  input               enable,
  input      [11:0]   branchAddr,
  input      [19:0]   jumpAddr,
  output     [31:0]   instruction,
  output     [63:0]   pc_debug,
  output     [63:0]   next_pc_debug,
  output     [63:0]   pc_reg_debug
);

  wire                core_clk;
  wire                core_reset;
  reg        [63:0]   coreArea_pc;
  wire       [63:0]   coreArea_pc_add_4;
  wire       [63:0]   coreArea_jumpAddr;
  wire                _zz_coreArea_jumpAddr;
  reg        [42:0]   _zz_coreArea_jumpAddr_1;
  wire       [63:0]   coreArea_branchAddr;
  wire                _zz_coreArea_branchAddr;
  reg        [50:0]   _zz_coreArea_branchAddr_1;
  reg        [63:0]   coreArea_next_pc;
  reg        [63:0]   coreArea_pc_reg;

  assign core_clk = clk;
  assign core_reset = rst;
  assign pc_debug = coreArea_pc;
  assign coreArea_pc_add_4 = (coreArea_pc + 64'h0000000000000004);
  assign _zz_coreArea_jumpAddr = jumpAddr[19];
  always @(*) begin
    _zz_coreArea_jumpAddr_1[42] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[41] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[40] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[39] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[38] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[37] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[36] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[35] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[34] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[33] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[32] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[31] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[30] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[29] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[28] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[27] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[26] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[25] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[24] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[23] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[22] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[21] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[20] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[19] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[18] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[17] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[16] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[15] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[14] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[13] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[12] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[11] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[10] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[9] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[8] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[7] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[6] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[5] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[4] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[3] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[2] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[1] = _zz_coreArea_jumpAddr;
    _zz_coreArea_jumpAddr_1[0] = _zz_coreArea_jumpAddr;
  end

  assign coreArea_jumpAddr = (coreArea_pc + {{_zz_coreArea_jumpAddr_1,jumpAddr},1'b0});
  assign _zz_coreArea_branchAddr = branchAddr[11];
  always @(*) begin
    _zz_coreArea_branchAddr_1[50] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[49] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[48] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[47] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[46] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[45] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[44] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[43] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[42] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[41] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[40] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[39] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[38] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[37] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[36] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[35] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[34] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[33] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[32] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[31] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[30] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[29] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[28] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[27] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[26] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[25] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[24] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[23] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[22] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[21] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[20] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[19] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[18] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[17] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[16] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[15] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[14] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[13] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[12] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[11] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[10] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[9] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[8] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[7] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[6] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[5] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[4] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[3] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[2] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[1] = _zz_coreArea_branchAddr;
    _zz_coreArea_branchAddr_1[0] = _zz_coreArea_branchAddr;
  end

  assign coreArea_branchAddr = (coreArea_pc + {{_zz_coreArea_branchAddr_1,branchAddr},1'b0});
  always @(*) begin
    coreArea_next_pc = (jump ? coreArea_jumpAddr : (branch ? coreArea_branchAddr : coreArea_pc_add_4));
    if(core_reset) begin
      coreArea_next_pc = 64'h0;
    end
  end

  assign next_pc_debug = coreArea_next_pc;
  assign instruction = 32'h0;
  assign pc_reg_debug = coreArea_pc_reg;
  always @(*) begin
    coreArea_pc = coreArea_pc_reg;
    if(core_reset) begin
      coreArea_pc = 64'h0;
    end
  end

  always @(posedge core_clk or posedge core_reset) begin
    if(core_reset) begin
      coreArea_pc_reg <= 64'h0;
    end else begin
      if(enable) begin
        coreArea_pc_reg <= coreArea_next_pc;
      end
      if(core_reset) begin
        coreArea_pc_reg <= 64'h0;
      end
    end
  end


endmodule
