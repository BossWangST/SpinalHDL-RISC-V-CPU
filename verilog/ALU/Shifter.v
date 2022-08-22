// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : Shifter
// Git hash  : 9ecf148c235ca4ff4f842a6d692883944a632ac4

`timescale 1ns/1ps

module Shifter (
  input      [63:0]   data,
  input      [4:0]    shamt,
  input      [1:0]    shiftCtr,
  output     [63:0]   shiftResult
);

  wire       [63:0]   _zz_tempShift;
  wire       [63:0]   _zz_tempShift_1;
  wire                _zz_tempShift_2;
  wire       [0:0]    _zz_tempShift_3;
  wire       [53:0]   _zz_tempShift_4;
  wire                _zz_tempShift_5;
  wire       [0:0]    _zz_tempShift_6;
  wire       [42:0]   _zz_tempShift_7;
  wire                _zz_tempShift_8;
  wire       [0:0]    _zz_tempShift_9;
  wire       [31:0]   _zz_tempShift_10;
  wire                _zz_tempShift_11;
  wire       [0:0]    _zz_tempShift_12;
  wire       [20:0]   _zz_tempShift_13;
  wire                _zz_tempShift_14;
  wire       [0:0]    _zz_tempShift_15;
  wire       [9:0]    _zz_tempShift_16;
  wire                _zz_leftShiftResult;
  wire       [0:0]    _zz_leftShiftResult_1;
  wire       [52:0]   _zz_leftShiftResult_2;
  wire                _zz_leftShiftResult_3;
  wire       [0:0]    _zz_leftShiftResult_4;
  wire       [41:0]   _zz_leftShiftResult_5;
  wire                _zz_leftShiftResult_6;
  wire       [0:0]    _zz_leftShiftResult_7;
  wire       [30:0]   _zz_leftShiftResult_8;
  wire                _zz_leftShiftResult_9;
  wire       [0:0]    _zz_leftShiftResult_10;
  wire       [19:0]   _zz_leftShiftResult_11;
  wire                _zz_leftShiftResult_12;
  wire       [0:0]    _zz_leftShiftResult_13;
  wire       [8:0]    _zz_leftShiftResult_14;
  wire       [63:0]   _zz_sraMask;
  wire       [63:0]   _zz_arithRightShiftResult_2;
  wire       [63:0]   tempShift;
  wire       [63:0]   leftShiftResult;
  wire       [63:0]   arithRightShiftResult;
  wire       [63:0]   sraMask;
  wire                _zz_arithRightShiftResult;
  reg        [63:0]   _zz_arithRightShiftResult_1;
  reg        [63:0]   _zz_shiftResult;

  assign _zz_tempShift = ((shiftCtr == 2'b00) ? _zz_tempShift_1 : data);
  assign _zz_tempShift_1 = {data[0],{data[1],{data[2],{data[3],{data[4],{data[5],{data[6],{data[7],{_zz_tempShift_2,{_zz_tempShift_3,_zz_tempShift_4}}}}}}}}}};
  assign _zz_sraMask = (64'hffffffffffffffff >>> shamt);
  assign _zz_arithRightShiftResult_2 = (sraMask & _zz_arithRightShiftResult_1);
  assign _zz_tempShift_2 = data[8];
  assign _zz_tempShift_3 = data[9];
  assign _zz_tempShift_4 = {data[10],{data[11],{data[12],{data[13],{data[14],{data[15],{data[16],{data[17],{data[18],{_zz_tempShift_5,{_zz_tempShift_6,_zz_tempShift_7}}}}}}}}}}};
  assign _zz_tempShift_5 = data[19];
  assign _zz_tempShift_6 = data[20];
  assign _zz_tempShift_7 = {data[21],{data[22],{data[23],{data[24],{data[25],{data[26],{data[27],{data[28],{data[29],{_zz_tempShift_8,{_zz_tempShift_9,_zz_tempShift_10}}}}}}}}}}};
  assign _zz_tempShift_8 = data[30];
  assign _zz_tempShift_9 = data[31];
  assign _zz_tempShift_10 = {data[32],{data[33],{data[34],{data[35],{data[36],{data[37],{data[38],{data[39],{data[40],{_zz_tempShift_11,{_zz_tempShift_12,_zz_tempShift_13}}}}}}}}}}};
  assign _zz_tempShift_11 = data[41];
  assign _zz_tempShift_12 = data[42];
  assign _zz_tempShift_13 = {data[43],{data[44],{data[45],{data[46],{data[47],{data[48],{data[49],{data[50],{data[51],{_zz_tempShift_14,{_zz_tempShift_15,_zz_tempShift_16}}}}}}}}}}};
  assign _zz_tempShift_14 = data[52];
  assign _zz_tempShift_15 = data[53];
  assign _zz_tempShift_16 = {data[54],{data[55],{data[56],{data[57],{data[58],{data[59],{data[60],{data[61],{data[62],data[63]}}}}}}}}};
  assign _zz_leftShiftResult = tempShift[9];
  assign _zz_leftShiftResult_1 = tempShift[10];
  assign _zz_leftShiftResult_2 = {tempShift[11],{tempShift[12],{tempShift[13],{tempShift[14],{tempShift[15],{tempShift[16],{tempShift[17],{tempShift[18],{tempShift[19],{_zz_leftShiftResult_3,{_zz_leftShiftResult_4,_zz_leftShiftResult_5}}}}}}}}}}};
  assign _zz_leftShiftResult_3 = tempShift[20];
  assign _zz_leftShiftResult_4 = tempShift[21];
  assign _zz_leftShiftResult_5 = {tempShift[22],{tempShift[23],{tempShift[24],{tempShift[25],{tempShift[26],{tempShift[27],{tempShift[28],{tempShift[29],{tempShift[30],{_zz_leftShiftResult_6,{_zz_leftShiftResult_7,_zz_leftShiftResult_8}}}}}}}}}}};
  assign _zz_leftShiftResult_6 = tempShift[31];
  assign _zz_leftShiftResult_7 = tempShift[32];
  assign _zz_leftShiftResult_8 = {tempShift[33],{tempShift[34],{tempShift[35],{tempShift[36],{tempShift[37],{tempShift[38],{tempShift[39],{tempShift[40],{tempShift[41],{_zz_leftShiftResult_9,{_zz_leftShiftResult_10,_zz_leftShiftResult_11}}}}}}}}}}};
  assign _zz_leftShiftResult_9 = tempShift[42];
  assign _zz_leftShiftResult_10 = tempShift[43];
  assign _zz_leftShiftResult_11 = {tempShift[44],{tempShift[45],{tempShift[46],{tempShift[47],{tempShift[48],{tempShift[49],{tempShift[50],{tempShift[51],{tempShift[52],{_zz_leftShiftResult_12,{_zz_leftShiftResult_13,_zz_leftShiftResult_14}}}}}}}}}}};
  assign _zz_leftShiftResult_12 = tempShift[53];
  assign _zz_leftShiftResult_13 = tempShift[54];
  assign _zz_leftShiftResult_14 = {tempShift[55],{tempShift[56],{tempShift[57],{tempShift[58],{tempShift[59],{tempShift[60],{tempShift[61],{tempShift[62],tempShift[63]}}}}}}}};
  assign tempShift = ($signed(_zz_tempShift) >>> shamt);
  assign leftShiftResult = {tempShift[0],{tempShift[1],{tempShift[2],{tempShift[3],{tempShift[4],{tempShift[5],{tempShift[6],{tempShift[7],{tempShift[8],{_zz_leftShiftResult,{_zz_leftShiftResult_1,_zz_leftShiftResult_2}}}}}}}}}}};
  assign sraMask = (~ _zz_sraMask);
  assign _zz_arithRightShiftResult = data[63];
  always @(*) begin
    _zz_arithRightShiftResult_1[63] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[62] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[61] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[60] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[59] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[58] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[57] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[56] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[55] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[54] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[53] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[52] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[51] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[50] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[49] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[48] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[47] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[46] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[45] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[44] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[43] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[42] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[41] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[40] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[39] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[38] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[37] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[36] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[35] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[34] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[33] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[32] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[31] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[30] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[29] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[28] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[27] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[26] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[25] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[24] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[23] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[22] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[21] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[20] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[19] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[18] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[17] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[16] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[15] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[14] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[13] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[12] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[11] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[10] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[9] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[8] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[7] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[6] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[5] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[4] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[3] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[2] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[1] = _zz_arithRightShiftResult;
    _zz_arithRightShiftResult_1[0] = _zz_arithRightShiftResult;
  end

  assign arithRightShiftResult = (tempShift | _zz_arithRightShiftResult_2);
  always @(*) begin
    case(shiftCtr)
      2'b00 : begin
        _zz_shiftResult = leftShiftResult;
      end
      2'b01 : begin
        _zz_shiftResult = arithRightShiftResult;
      end
      2'b10 : begin
        _zz_shiftResult = tempShift;
      end
      default : begin
        _zz_shiftResult = 64'h0;
      end
    endcase
  end

  assign shiftResult = _zz_shiftResult;

endmodule
