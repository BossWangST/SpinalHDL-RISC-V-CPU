// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : Register_file
// Git hash  : f158315800aa7989d8faf0dddad7d3eeddbea417

`timescale 1ns/1ps

module Register_file (
  input               RegWrite,
  input      [4:0]    readReg1,
  input      [4:0]    readReg2,
  input      [4:0]    writeReg,
  input      [63:0]   writeData,
  output     [63:0]   readData1,
  output     [63:0]   readData2,
  input               clk,
  input               reset
);

  reg        [63:0]   _zz_readData1;
  reg        [63:0]   _zz_readData2;
  reg        [63:0]   Regs_0;
  reg        [63:0]   Regs_1;
  reg        [63:0]   Regs_2;
  reg        [63:0]   Regs_3;
  reg        [63:0]   Regs_4;
  reg        [63:0]   Regs_5;
  reg        [63:0]   Regs_6;
  reg        [63:0]   Regs_7;
  reg        [63:0]   Regs_8;
  reg        [63:0]   Regs_9;
  reg        [63:0]   Regs_10;
  reg        [63:0]   Regs_11;
  reg        [63:0]   Regs_12;
  reg        [63:0]   Regs_13;
  reg        [63:0]   Regs_14;
  reg        [63:0]   Regs_15;
  reg        [63:0]   Regs_16;
  reg        [63:0]   Regs_17;
  reg        [63:0]   Regs_18;
  reg        [63:0]   Regs_19;
  reg        [63:0]   Regs_20;
  reg        [63:0]   Regs_21;
  reg        [63:0]   Regs_22;
  reg        [63:0]   Regs_23;
  reg        [63:0]   Regs_24;
  reg        [63:0]   Regs_25;
  reg        [63:0]   Regs_26;
  reg        [63:0]   Regs_27;
  reg        [63:0]   Regs_28;
  reg        [63:0]   Regs_29;
  reg        [63:0]   Regs_30;
  reg        [63:0]   Regs_31;
  wire       [31:0]   _zz_1;

  always @(*) begin
    case(readReg1)
      5'b00000 : _zz_readData1 = Regs_0;
      5'b00001 : _zz_readData1 = Regs_1;
      5'b00010 : _zz_readData1 = Regs_2;
      5'b00011 : _zz_readData1 = Regs_3;
      5'b00100 : _zz_readData1 = Regs_4;
      5'b00101 : _zz_readData1 = Regs_5;
      5'b00110 : _zz_readData1 = Regs_6;
      5'b00111 : _zz_readData1 = Regs_7;
      5'b01000 : _zz_readData1 = Regs_8;
      5'b01001 : _zz_readData1 = Regs_9;
      5'b01010 : _zz_readData1 = Regs_10;
      5'b01011 : _zz_readData1 = Regs_11;
      5'b01100 : _zz_readData1 = Regs_12;
      5'b01101 : _zz_readData1 = Regs_13;
      5'b01110 : _zz_readData1 = Regs_14;
      5'b01111 : _zz_readData1 = Regs_15;
      5'b10000 : _zz_readData1 = Regs_16;
      5'b10001 : _zz_readData1 = Regs_17;
      5'b10010 : _zz_readData1 = Regs_18;
      5'b10011 : _zz_readData1 = Regs_19;
      5'b10100 : _zz_readData1 = Regs_20;
      5'b10101 : _zz_readData1 = Regs_21;
      5'b10110 : _zz_readData1 = Regs_22;
      5'b10111 : _zz_readData1 = Regs_23;
      5'b11000 : _zz_readData1 = Regs_24;
      5'b11001 : _zz_readData1 = Regs_25;
      5'b11010 : _zz_readData1 = Regs_26;
      5'b11011 : _zz_readData1 = Regs_27;
      5'b11100 : _zz_readData1 = Regs_28;
      5'b11101 : _zz_readData1 = Regs_29;
      5'b11110 : _zz_readData1 = Regs_30;
      default : _zz_readData1 = Regs_31;
    endcase
  end

  always @(*) begin
    case(readReg2)
      5'b00000 : _zz_readData2 = Regs_0;
      5'b00001 : _zz_readData2 = Regs_1;
      5'b00010 : _zz_readData2 = Regs_2;
      5'b00011 : _zz_readData2 = Regs_3;
      5'b00100 : _zz_readData2 = Regs_4;
      5'b00101 : _zz_readData2 = Regs_5;
      5'b00110 : _zz_readData2 = Regs_6;
      5'b00111 : _zz_readData2 = Regs_7;
      5'b01000 : _zz_readData2 = Regs_8;
      5'b01001 : _zz_readData2 = Regs_9;
      5'b01010 : _zz_readData2 = Regs_10;
      5'b01011 : _zz_readData2 = Regs_11;
      5'b01100 : _zz_readData2 = Regs_12;
      5'b01101 : _zz_readData2 = Regs_13;
      5'b01110 : _zz_readData2 = Regs_14;
      5'b01111 : _zz_readData2 = Regs_15;
      5'b10000 : _zz_readData2 = Regs_16;
      5'b10001 : _zz_readData2 = Regs_17;
      5'b10010 : _zz_readData2 = Regs_18;
      5'b10011 : _zz_readData2 = Regs_19;
      5'b10100 : _zz_readData2 = Regs_20;
      5'b10101 : _zz_readData2 = Regs_21;
      5'b10110 : _zz_readData2 = Regs_22;
      5'b10111 : _zz_readData2 = Regs_23;
      5'b11000 : _zz_readData2 = Regs_24;
      5'b11001 : _zz_readData2 = Regs_25;
      5'b11010 : _zz_readData2 = Regs_26;
      5'b11011 : _zz_readData2 = Regs_27;
      5'b11100 : _zz_readData2 = Regs_28;
      5'b11101 : _zz_readData2 = Regs_29;
      5'b11110 : _zz_readData2 = Regs_30;
      default : _zz_readData2 = Regs_31;
    endcase
  end

  assign readData1 = _zz_readData1;
  assign readData2 = _zz_readData2;
  assign _zz_1 = ({31'd0,1'b1} <<< writeReg);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      Regs_0 <= 64'h0;
      Regs_1 <= 64'h0;
      Regs_2 <= 64'h0;
      Regs_3 <= 64'h0;
      Regs_4 <= 64'h0;
      Regs_5 <= 64'h0;
      Regs_6 <= 64'h0;
      Regs_7 <= 64'h0;
      Regs_8 <= 64'h0;
      Regs_9 <= 64'h0;
      Regs_10 <= 64'h0;
      Regs_11 <= 64'h0;
      Regs_12 <= 64'h0;
      Regs_13 <= 64'h0;
      Regs_14 <= 64'h0;
      Regs_15 <= 64'h0;
      Regs_16 <= 64'h0;
      Regs_17 <= 64'h0;
      Regs_18 <= 64'h0;
      Regs_19 <= 64'h0;
      Regs_20 <= 64'h0;
      Regs_21 <= 64'h0;
      Regs_22 <= 64'h0;
      Regs_23 <= 64'h0;
      Regs_24 <= 64'h0;
      Regs_25 <= 64'h0;
      Regs_26 <= 64'h0;
      Regs_27 <= 64'h0;
      Regs_28 <= 64'h0;
      Regs_29 <= 64'h0;
      Regs_30 <= 64'h0;
      Regs_31 <= 64'h0;
    end else begin
      if(RegWrite) begin
        if(_zz_1[0]) begin
          Regs_0 <= writeData;
        end
        if(_zz_1[1]) begin
          Regs_1 <= writeData;
        end
        if(_zz_1[2]) begin
          Regs_2 <= writeData;
        end
        if(_zz_1[3]) begin
          Regs_3 <= writeData;
        end
        if(_zz_1[4]) begin
          Regs_4 <= writeData;
        end
        if(_zz_1[5]) begin
          Regs_5 <= writeData;
        end
        if(_zz_1[6]) begin
          Regs_6 <= writeData;
        end
        if(_zz_1[7]) begin
          Regs_7 <= writeData;
        end
        if(_zz_1[8]) begin
          Regs_8 <= writeData;
        end
        if(_zz_1[9]) begin
          Regs_9 <= writeData;
        end
        if(_zz_1[10]) begin
          Regs_10 <= writeData;
        end
        if(_zz_1[11]) begin
          Regs_11 <= writeData;
        end
        if(_zz_1[12]) begin
          Regs_12 <= writeData;
        end
        if(_zz_1[13]) begin
          Regs_13 <= writeData;
        end
        if(_zz_1[14]) begin
          Regs_14 <= writeData;
        end
        if(_zz_1[15]) begin
          Regs_15 <= writeData;
        end
        if(_zz_1[16]) begin
          Regs_16 <= writeData;
        end
        if(_zz_1[17]) begin
          Regs_17 <= writeData;
        end
        if(_zz_1[18]) begin
          Regs_18 <= writeData;
        end
        if(_zz_1[19]) begin
          Regs_19 <= writeData;
        end
        if(_zz_1[20]) begin
          Regs_20 <= writeData;
        end
        if(_zz_1[21]) begin
          Regs_21 <= writeData;
        end
        if(_zz_1[22]) begin
          Regs_22 <= writeData;
        end
        if(_zz_1[23]) begin
          Regs_23 <= writeData;
        end
        if(_zz_1[24]) begin
          Regs_24 <= writeData;
        end
        if(_zz_1[25]) begin
          Regs_25 <= writeData;
        end
        if(_zz_1[26]) begin
          Regs_26 <= writeData;
        end
        if(_zz_1[27]) begin
          Regs_27 <= writeData;
        end
        if(_zz_1[28]) begin
          Regs_28 <= writeData;
        end
        if(_zz_1[29]) begin
          Regs_29 <= writeData;
        end
        if(_zz_1[30]) begin
          Regs_30 <= writeData;
        end
        if(_zz_1[31]) begin
          Regs_31 <= writeData;
        end
      end
    end
  end


endmodule
