// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : Adder
// Git hash  : 9ecf148c235ca4ff4f842a6d692883944a632ac4

`timescale 1ns/1ps

module Adder (
  input      [63:0]   data1,
  input      [63:0]   data2,
  input               subCtr,
  output              carryOut,
  output              overflow,
  output              sign,
  output reg          zero,
  output     [63:0]   adderResult
);

  wire       [64:0]   _zz_tempResult;
  wire       [64:0]   _zz_tempResult_1;
  wire       [64:0]   _zz_tempResult_2;
  wire       [64:0]   _zz_tempResult_3;
  wire       [64:0]   _zz_tempResult_4;
  wire       [64:0]   _zz_tempResult_5;
  wire       [64:0]   _zz_when_Adder_l28;
  reg        [64:0]   tempResult;
  wire                when_Adder_l28;

  assign _zz_tempResult = ($signed(_zz_tempResult_1) + $signed(_zz_tempResult_2));
  assign _zz_tempResult_1 = {data1[63],data1};
  assign _zz_tempResult_2 = {data2[63],data2};
  assign _zz_tempResult_3 = 65'h00000000000000001;
  assign _zz_tempResult_4 = {data1[63],data1};
  assign _zz_tempResult_5 = {data2[63],data2};
  assign _zz_when_Adder_l28 = 65'h0;
  always @(*) begin
    if(subCtr) begin
      tempResult = ($signed(_zz_tempResult) + $signed(_zz_tempResult_3));
    end else begin
      tempResult = ($signed(_zz_tempResult_4) + $signed(_zz_tempResult_5));
    end
  end

  assign when_Adder_l28 = ($signed(tempResult) == $signed(_zz_when_Adder_l28));
  always @(*) begin
    if(when_Adder_l28) begin
      zero = 1'b1;
    end else begin
      zero = 1'b0;
    end
  end

  assign overflow = (((data1[63] && data2[63]) && (! tempResult[63])) || (((! data1[63]) && (! data2[63])) && tempResult[63]));
  assign sign = tempResult[63];
  assign carryOut = tempResult[64];
  assign adderResult = tempResult[63 : 0];

endmodule
