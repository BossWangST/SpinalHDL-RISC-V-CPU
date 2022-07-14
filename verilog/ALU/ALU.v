// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : ALU
// Git hash  : 7181f2356efd0a48321a94cd8e704eab566ca4f8

`timescale 1ns/1ps

module ALU (
  input      [3:0]    aluOp,
  input      [63:0]   data1,
  input      [63:0]   data2,
  output              Zero,
  output     [63:0]   aluResult
);

  wire       [63:0]   adder_1_data2;
  wire       [4:0]    shifter_1_shamt;
  wire                adder_1_carryOut;
  wire                adder_1_overflow;
  wire                adder_1_sign;
  wire                adder_1_zero;
  wire       [63:0]   adder_1_adderResult;
  wire       [63:0]   shifter_1_shiftResult;
  wire                _zz_data2;
  wire       [0:0]    _zz_data2_1;
  wire       [53:0]   _zz_data2_2;
  wire                _zz_data2_3;
  wire       [0:0]    _zz_data2_4;
  wire       [42:0]   _zz_data2_5;
  wire                _zz_data2_6;
  wire       [0:0]    _zz_data2_7;
  wire       [31:0]   _zz_data2_8;
  wire                _zz_data2_9;
  wire       [0:0]    _zz_data2_10;
  wire       [20:0]   _zz_data2_11;
  wire                _zz_data2_12;
  wire       [0:0]    _zz_data2_13;
  wire       [9:0]    _zz_data2_14;
  reg        [1:0]    opCtr;
  reg                 signCtr;
  reg                 subCtr;
  reg                 overflowCtr;
  reg        [1:0]    shiftCtr;
  reg        [1:0]    logicCtr;
  wire                carryFlag;
  wire                signFlag;
  wire       [63:0]   sltResult;
  wire       [63:0]   andResult;
  wire       [63:0]   orResult;
  wire       [63:0]   xorResult;
  reg        [63:0]   logicResult;
  reg        [63:0]   _zz_aluResult;

  assign _zz_data2 = data2[8];
  assign _zz_data2_1 = data2[9];
  assign _zz_data2_2 = {data2[10],{data2[11],{data2[12],{data2[13],{data2[14],{data2[15],{data2[16],{data2[17],{data2[18],{_zz_data2_3,{_zz_data2_4,_zz_data2_5}}}}}}}}}}};
  assign _zz_data2_3 = data2[19];
  assign _zz_data2_4 = data2[20];
  assign _zz_data2_5 = {data2[21],{data2[22],{data2[23],{data2[24],{data2[25],{data2[26],{data2[27],{data2[28],{data2[29],{_zz_data2_6,{_zz_data2_7,_zz_data2_8}}}}}}}}}}};
  assign _zz_data2_6 = data2[30];
  assign _zz_data2_7 = data2[31];
  assign _zz_data2_8 = {data2[32],{data2[33],{data2[34],{data2[35],{data2[36],{data2[37],{data2[38],{data2[39],{data2[40],{_zz_data2_9,{_zz_data2_10,_zz_data2_11}}}}}}}}}}};
  assign _zz_data2_9 = data2[41];
  assign _zz_data2_10 = data2[42];
  assign _zz_data2_11 = {data2[43],{data2[44],{data2[45],{data2[46],{data2[47],{data2[48],{data2[49],{data2[50],{data2[51],{_zz_data2_12,{_zz_data2_13,_zz_data2_14}}}}}}}}}}};
  assign _zz_data2_12 = data2[52];
  assign _zz_data2_13 = data2[53];
  assign _zz_data2_14 = {data2[54],{data2[55],{data2[56],{data2[57],{data2[58],{data2[59],{data2[60],{data2[61],{data2[62],data2[63]}}}}}}}}};
  Adder adder_1 (
    .data1       (data1[63:0]              ), //i
    .data2       (adder_1_data2[63:0]      ), //i
    .carryIn     (subCtr                   ), //i
    .carryOut    (adder_1_carryOut         ), //o
    .overflow    (adder_1_overflow         ), //o
    .sign        (adder_1_sign             ), //o
    .zero        (adder_1_zero             ), //o
    .adderResult (adder_1_adderResult[63:0])  //o
  );
  Shifter shifter_1 (
    .data        (data1[63:0]                ), //i
    .shamt       (shifter_1_shamt[4:0]       ), //i
    .shiftCtr    (shiftCtr[1:0]              ), //i
    .shiftResult (shifter_1_shiftResult[63:0])  //o
  );
  always @(*) begin
    case(aluOp)
      4'b0000, 4'b1000 : begin
        opCtr = 2'b00;
      end
      4'b0001, 4'b0010 : begin
        opCtr = 2'b01;
      end
      4'b0110, 4'b0111, 4'b1001 : begin
        opCtr = 2'b10;
      end
      4'b0011, 4'b0100, 4'b0101 : begin
        opCtr = 2'b11;
      end
      default : begin
        opCtr = 2'b00;
      end
    endcase
  end

  always @(*) begin
    case(aluOp)
      4'b0010 : begin
        signCtr = 1'b0;
      end
      default : begin
        signCtr = 1'b1;
      end
    endcase
  end

  always @(*) begin
    case(aluOp)
      4'b0001 : begin
        subCtr = 1'b1;
      end
      4'b0010 : begin
        subCtr = 1'b1;
      end
      4'b1000 : begin
        subCtr = 1'b1;
      end
      default : begin
        subCtr = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(aluOp)
      4'b0010 : begin
        overflowCtr = 1'b0;
      end
      default : begin
        overflowCtr = 1'b1;
      end
    endcase
  end

  always @(*) begin
    case(aluOp)
      4'b0110 : begin
        shiftCtr = 2'b00;
      end
      4'b0111 : begin
        shiftCtr = 2'b10;
      end
      4'b1001 : begin
        shiftCtr = 2'b01;
      end
      default : begin
        shiftCtr = 2'b00;
      end
    endcase
  end

  always @(*) begin
    case(aluOp)
      4'b0011 : begin
        logicCtr = 2'b00;
      end
      4'b0100 : begin
        logicCtr = 2'b01;
      end
      4'b0101 : begin
        logicCtr = 2'b10;
      end
      default : begin
        logicCtr = 2'b00;
      end
    endcase
  end

  assign adder_1_data2 = (subCtr ? {data2[0],{data2[1],{data2[2],{data2[3],{data2[4],{data2[5],{data2[6],{data2[7],{_zz_data2,{_zz_data2_1,_zz_data2_2}}}}}}}}}} : data2);
  assign Zero = adder_1_zero;
  assign carryFlag = (subCtr ^ adder_1_carryOut);
  assign signFlag = ((adder_1_overflow && overflowCtr) ^ adder_1_sign);
  assign sltResult = ((signCtr ? signFlag : carryFlag) ? 64'h0000000000000001 : 64'h0);
  assign shifter_1_shamt = data2[4 : 0];
  assign andResult = (data1 & data2);
  assign orResult = (data1 | data2);
  assign xorResult = (data1 ^ data2);
  always @(*) begin
    case(logicCtr)
      2'b00 : begin
        logicResult = andResult;
      end
      2'b01 : begin
        logicResult = orResult;
      end
      2'b10 : begin
        logicResult = xorResult;
      end
      default : begin
        logicResult = 64'h0;
      end
    endcase
  end

  always @(*) begin
    case(opCtr)
      2'b00 : begin
        _zz_aluResult = adder_1_adderResult;
      end
      2'b01 : begin
        _zz_aluResult = sltResult;
      end
      2'b10 : begin
        _zz_aluResult = shifter_1_shiftResult;
      end
      default : begin
        _zz_aluResult = logicResult;
      end
    endcase
  end

  assign aluResult = _zz_aluResult;

endmodule

module Shifter (
  input      [63:0]   data,
  input      [4:0]    shamt,
  input      [1:0]    shiftCtr,
  output     [63:0]   shiftResult
);

  wire                _zz_tempShift;
  wire       [0:0]    _zz_tempShift_1;
  wire       [54:0]   _zz_tempShift_2;
  wire                _zz_tempShift_3;
  wire       [0:0]    _zz_tempShift_4;
  wire       [43:0]   _zz_tempShift_5;
  wire                _zz_tempShift_6;
  wire       [0:0]    _zz_tempShift_7;
  wire       [32:0]   _zz_tempShift_8;
  wire                _zz_tempShift_9;
  wire       [0:0]    _zz_tempShift_10;
  wire       [21:0]   _zz_tempShift_11;
  wire                _zz_tempShift_12;
  wire       [0:0]    _zz_tempShift_13;
  wire       [10:0]   _zz_tempShift_14;
  wire                _zz_tempShift_15;
  wire                _zz_tempShift_16;
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
  wire       [63:0]   tempShift;
  wire       [63:0]   leftShiftResult;
  wire       [63:0]   arithRightShiftResult;
  wire       [63:0]   sraMask;
  wire                _zz_arithRightShiftResult;
  reg        [63:0]   _zz_arithRightShiftResult_1;
  reg        [63:0]   _zz_shiftResult;

  assign _zz_sraMask = (64'hffffffffffffffff >>> shamt);
  assign _zz_tempShift = data[7];
  assign _zz_tempShift_1 = data[8];
  assign _zz_tempShift_2 = {data[9],{data[10],{data[11],{data[12],{data[13],{data[14],{data[15],{data[16],{data[17],{_zz_tempShift_3,{_zz_tempShift_4,_zz_tempShift_5}}}}}}}}}}};
  assign _zz_tempShift_3 = data[18];
  assign _zz_tempShift_4 = data[19];
  assign _zz_tempShift_5 = {data[20],{data[21],{data[22],{data[23],{data[24],{data[25],{data[26],{data[27],{data[28],{_zz_tempShift_6,{_zz_tempShift_7,_zz_tempShift_8}}}}}}}}}}};
  assign _zz_tempShift_6 = data[29];
  assign _zz_tempShift_7 = data[30];
  assign _zz_tempShift_8 = {data[31],{data[32],{data[33],{data[34],{data[35],{data[36],{data[37],{data[38],{data[39],{_zz_tempShift_9,{_zz_tempShift_10,_zz_tempShift_11}}}}}}}}}}};
  assign _zz_tempShift_9 = data[40];
  assign _zz_tempShift_10 = data[41];
  assign _zz_tempShift_11 = {data[42],{data[43],{data[44],{data[45],{data[46],{data[47],{data[48],{data[49],{data[50],{_zz_tempShift_12,{_zz_tempShift_13,_zz_tempShift_14}}}}}}}}}}};
  assign _zz_tempShift_12 = data[51];
  assign _zz_tempShift_13 = data[52];
  assign _zz_tempShift_14 = {data[53],{data[54],{data[55],{data[56],{data[57],{data[58],{data[59],{data[60],{data[61],{_zz_tempShift_15,_zz_tempShift_16}}}}}}}}}};
  assign _zz_tempShift_15 = data[62];
  assign _zz_tempShift_16 = data[63];
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
  assign tempShift = (((shiftCtr == 2'b00) ? {data[0],{data[1],{data[2],{data[3],{data[4],{data[5],{data[6],{_zz_tempShift,{_zz_tempShift_1,_zz_tempShift_2}}}}}}}}} : data) >>> shamt);
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

  assign arithRightShiftResult = (tempShift | (sraMask & _zz_arithRightShiftResult_1));
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

module Adder (
  input      [63:0]   data1,
  input      [63:0]   data2,
  input               carryIn,
  output              carryOut,
  output              overflow,
  output              sign,
  output reg          zero,
  output     [63:0]   adderResult
);

  wire       [64:0]   _zz_tempResult;
  wire       [64:0]   _zz_tempResult_1;
  wire       [0:0]    _zz_tempResult_2;
  wire       [64:0]   tempResult;
  wire                when_Adder_l24;

  assign _zz_tempResult = ({1'b0,data1} + {1'b0,data2});
  assign _zz_tempResult_2 = carryIn;
  assign _zz_tempResult_1 = {64'd0, _zz_tempResult_2};
  assign tempResult = (_zz_tempResult + _zz_tempResult_1);
  assign when_Adder_l24 = (tempResult == 65'h0);
  always @(*) begin
    if(when_Adder_l24) begin
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
