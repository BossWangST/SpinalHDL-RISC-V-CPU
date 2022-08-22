// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : ALU
// Git hash  : 9ecf148c235ca4ff4f842a6d692883944a632ac4

`timescale 1ns/1ps

module ALU (
  input      [3:0]    aluOp,
  input      [63:0]   data1,
  input      [63:0]   data2,
  output              Zero,
  output     [63:0]   aluResult,
  input               clk,
  input               reset
);

  wire       [63:0]   adder_1_data1;
  wire       [63:0]   adder_1_data2;
  wire       [63:0]   shifter_1_data;
  wire       [4:0]    shifter_1_shamt;
  wire                adder_1_carryOut;
  wire                adder_1_overflow;
  wire                adder_1_sign;
  wire                adder_1_zero;
  wire       [63:0]   adder_1_adderResult;
  wire       [63:0]   shifter_1_shiftResult;
  wire       [63:0]   _zz_sltResult;
  wire       [63:0]   _zz_sltResult_1;
  wire       [4:0]    _zz_shamt;
  reg        [7:0]    counter;
  reg        [1:0]    opCtr;
  reg                 signCtr;
  reg                 subCtr;
  reg                 overflowCtr;
  reg        [1:0]    shiftCtr;
  reg        [1:0]    logicCtr;
  wire       [63:0]   adderResult;
  wire                sltLess;
  wire                sltuLess;
  wire       [63:0]   sltResult;
  wire       [63:0]   shiftResult;
  wire       [63:0]   andResult;
  wire       [63:0]   orResult;
  wire       [63:0]   xorResult;
  reg        [63:0]   logicResult;
  reg        [63:0]   _zz_aluResult;

  assign _zz_sltResult = 64'h0000000000000001;
  assign _zz_sltResult_1 = 64'h0;
  assign _zz_shamt = data2[4 : 0];
  Adder adder_1 (
    .data1       (adder_1_data1[63:0]      ), //i
    .data2       (adder_1_data2[63:0]      ), //i
    .subCtr      (subCtr                   ), //i
    .carryOut    (adder_1_carryOut         ), //o
    .overflow    (adder_1_overflow         ), //o
    .sign        (adder_1_sign             ), //o
    .zero        (adder_1_zero             ), //o
    .adderResult (adder_1_adderResult[63:0])  //o
  );
  Shifter shifter_1 (
    .data        (shifter_1_data[63:0]       ), //i
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

  assign adder_1_data1 = data1;
  assign adder_1_data2 = (subCtr ? (~ data2) : data2);
  assign Zero = adder_1_zero;
  assign adderResult = adder_1_adderResult;
  assign sltLess = (adder_1_sign ^ adder_1_overflow);
  assign sltuLess = (! adder_1_carryOut);
  assign sltResult = ((signCtr ? sltLess : sltuLess) ? _zz_sltResult : _zz_sltResult_1);
  assign shifter_1_data = data1;
  assign shifter_1_shamt = _zz_shamt;
  assign shiftResult = shifter_1_shiftResult;
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
        _zz_aluResult = adderResult;
      end
      2'b01 : begin
        _zz_aluResult = sltResult;
      end
      2'b10 : begin
        _zz_aluResult = shiftResult;
      end
      default : begin
        _zz_aluResult = logicResult;
      end
    endcase
  end

  assign aluResult = _zz_aluResult;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      counter <= 8'h0;
    end else begin
      counter <= (counter + 8'h01);
    end
  end


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
  input               subCtr,
  output              carryOut,
  output              overflow,
  output              sign,
  output reg          zero,
  output     [63:0]   adderResult
);

  wire       [64:0]   _zz_tempResult;
  reg        [64:0]   tempResult;
  wire                when_Adder_l28;

  assign _zz_tempResult = ({1'b0,data1} + {1'b0,data2});
  always @(*) begin
    if(subCtr) begin
      tempResult = (_zz_tempResult + 65'h00000000000000001);
    end else begin
      tempResult = ({1'b0,data1} + {1'b0,data2});
    end
  end

  assign when_Adder_l28 = (tempResult == 65'h0);
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
