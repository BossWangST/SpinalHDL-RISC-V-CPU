// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : Data_Road
// Git hash  : ca82b6cad577b8ac862902f46c46dab6eb5f14f0

`timescale 1ns/1ps

module Data_Road (
  input               clk,
  input               rst,
  output     [63:0]   pc
);

  wire                inst_fetcher_jump;
  wire       [63:0]   reg_1_writeData;
  wire       [63:0]   alu_1_data1;
  wire       [63:0]   alu_1_data2;
  wire       [15:0]   ram_1_addr;
  wire       [31:0]   inst_fetcher_instruction;
  wire       [63:0]   inst_fetcher_pc_debug;
  wire       [63:0]   inst_fetcher_next_pc_debug;
  wire       [63:0]   inst_fetcher_pc_reg_debug;
  wire       [3:0]    controller_1_aluCtr;
  wire                controller_1_aluSrc;
  wire                controller_1_shiftCtr;
  wire                controller_1_strip32;
  wire       [1:0]    controller_1_exRes;
  wire                controller_1_regWriteEnable;
  wire       [2:0]    controller_1_branch;
  wire                controller_1_jump;
  wire                controller_1_jalr;
  wire       [2:0]    controller_1_load;
  wire       [2:0]    controller_1_store;
  wire                controller_1_memWriteEnable;
  wire       [4:0]    controller_1_rs1;
  wire       [4:0]    controller_1_rs2;
  wire       [4:0]    controller_1_rd;
  wire       [63:0]   reg_1_readData1;
  wire       [63:0]   reg_1_readData2;
  wire                alu_1_Zero;
  wire       [63:0]   alu_1_aluResult;
  wire       [63:0]   ram_1_data_out;
  wire       [51:0]   _zz_immediate;
  wire       [0:0]    _zz_immediate_1;
  wire       [19:0]   _zz_jumpAddr;
  wire       [63:0]   _zz_branch;
  wire       [63:0]   _zz_branch_1;
  wire       [63:0]   _zz_write_data;
  wire       [63:0]   _zz_addr;
  reg                 IF_enable;
  wire       [11:0]   branchAddr;
  wire       [19:0]   jumpAddr;
  wire                when_Data_Road_l34;
  reg                 branch;
  reg        [63:0]   data1;
  reg        [63:0]   immediate;
  wire                when_Data_Road_l62;
  reg        [63:0]   data2;
  wire       [31:0]   upper_immediate;
  reg        [63:0]   write_data;
  wire       [63:0]   load_data;

  assign _zz_immediate_1 = inst_fetcher_instruction[31];
  assign _zz_immediate = {51'd0, _zz_immediate_1};
  assign _zz_jumpAddr = alu_1_aluResult[19 : 0];
  assign _zz_branch = 64'h0;
  assign _zz_branch_1 = 64'h0;
  assign _zz_write_data = {32'd0, upper_immediate};
  assign _zz_addr = alu_1_aluResult;
  Instruction_Fetcher inst_fetcher (
    .clk           (clk                             ), //i
    .rst           (rst                             ), //i
    .branch        (branch                          ), //i
    .jump          (inst_fetcher_jump               ), //i
    .enable        (IF_enable                       ), //i
    .branchAddr    (branchAddr[11:0]                ), //i
    .jumpAddr      (jumpAddr[19:0]                  ), //i
    .instruction   (inst_fetcher_instruction[31:0]  ), //o
    .pc_debug      (inst_fetcher_pc_debug[63:0]     ), //o
    .next_pc_debug (inst_fetcher_next_pc_debug[63:0]), //o
    .pc_reg_debug  (inst_fetcher_pc_reg_debug[63:0] )  //o
  );
  Controller controller_1 (
    .instruction    (inst_fetcher_instruction[31:0]), //i
    .aluCtr         (controller_1_aluCtr[3:0]      ), //o
    .aluSrc         (controller_1_aluSrc           ), //o
    .shiftCtr       (controller_1_shiftCtr         ), //o
    .strip32        (controller_1_strip32          ), //o
    .exRes          (controller_1_exRes[1:0]       ), //o
    .regWriteEnable (controller_1_regWriteEnable   ), //o
    .branch         (controller_1_branch[2:0]      ), //o
    .jump           (controller_1_jump             ), //o
    .jalr           (controller_1_jalr             ), //o
    .load           (controller_1_load[2:0]        ), //o
    .store          (controller_1_store[2:0]       ), //o
    .memWriteEnable (controller_1_memWriteEnable   ), //o
    .rs1            (controller_1_rs1[4:0]         ), //o
    .rs2            (controller_1_rs2[4:0]         ), //o
    .rd             (controller_1_rd[4:0]          )  //o
  );
  Register_file reg_1 (
    .clk       (clk                        ), //i
    .rst       (rst                        ), //i
    .RegWrite  (controller_1_regWriteEnable), //i
    .readReg1  (controller_1_rs1[4:0]      ), //i
    .readReg2  (controller_1_rs2[4:0]      ), //i
    .writeReg  (controller_1_rd[4:0]       ), //i
    .writeData (reg_1_writeData[63:0]      ), //i
    .readData1 (reg_1_readData1[63:0]      ), //o
    .readData2 (reg_1_readData2[63:0]      )  //o
  );
  ALU alu_1 (
    .aluOp     (controller_1_aluCtr[3:0]), //i
    .data1     (alu_1_data1[63:0]       ), //i
    .data2     (alu_1_data2[63:0]       ), //i
    .Zero      (alu_1_Zero              ), //o
    .aluResult (alu_1_aluResult[63:0]   )  //o
  );
  Ram ram_1 (
    .clk      (clk                        ), //i
    .rst      (rst                        ), //i
    .addr     (ram_1_addr[15:0]           ), //i
    .data_out (ram_1_data_out[63:0]       ), //o
    .data_in  (reg_1_readData2[63:0]      ), //i
    .write_en (controller_1_memWriteEnable)  //i
  );
  assign pc = inst_fetcher_pc_debug;
  assign when_Data_Road_l34 = 1'b1;
  always @(*) begin
    if(when_Data_Road_l34) begin
      IF_enable = 1'b1;
    end else begin
      IF_enable = 1'b0;
    end
  end

  assign inst_fetcher_jump = (controller_1_jump || controller_1_jalr);
  always @(*) begin
    data1 = reg_1_readData1;
    if(controller_1_strip32) begin
      data1[63 : 32] = 32'h0;
    end
  end

  assign when_Data_Road_l62 = (controller_1_store != 3'b000);
  always @(*) begin
    if(when_Data_Road_l62) begin
      immediate = {{52'h0,inst_fetcher_instruction[31 : 25]},inst_fetcher_instruction[11 : 7]};
    end else begin
      immediate = {_zz_immediate,inst_fetcher_instruction[31 : 20]};
    end
  end

  assign branchAddr = ((controller_1_branch != 3'b000) ? {{{inst_fetcher_instruction[31],inst_fetcher_instruction[7]},inst_fetcher_instruction[30 : 25]},inst_fetcher_instruction[11 : 8]} : 12'h0);
  assign jumpAddr = (controller_1_jump ? {{{inst_fetcher_instruction[31],inst_fetcher_instruction[19 : 12]},inst_fetcher_instruction[20]},inst_fetcher_instruction[30 : 21]} : (controller_1_jalr ? _zz_jumpAddr : 20'h0));
  always @(*) begin
    data2 = (controller_1_aluSrc ? reg_1_readData2 : immediate);
    if(controller_1_strip32) begin
      data2[63 : 32] = 32'h0;
    end
  end

  assign alu_1_data1 = data1;
  assign alu_1_data2 = data2;
  always @(*) begin
    case(controller_1_branch)
      3'b001 : begin
        branch = (alu_1_Zero ? 1'b1 : 1'b0);
      end
      3'b010 : begin
        branch = (alu_1_Zero ? 1'b0 : 1'b1);
      end
      3'b011 : begin
        branch = (($signed(alu_1_aluResult) < $signed(_zz_branch)) ? 1'b1 : 1'b0);
      end
      3'b100 : begin
        branch = (($signed(_zz_branch_1) <= $signed(alu_1_aluResult)) ? 1'b1 : 1'b0);
      end
      default : begin
        branch = 1'b0;
      end
    endcase
  end

  assign upper_immediate = {inst_fetcher_instruction[31 : 12],12'h0};
  always @(*) begin
    case(controller_1_exRes)
      2'b00 : begin
        write_data = alu_1_aluResult;
      end
      2'b01 : begin
        write_data = (inst_fetcher_pc_debug + 64'h0000000000000004);
      end
      2'b10 : begin
        write_data = {32'h0,upper_immediate};
      end
      default : begin
        write_data = (_zz_write_data + inst_fetcher_pc_debug);
      end
    endcase
  end

  assign reg_1_writeData = ((controller_1_load == 3'b000) ? write_data : 64'h0);
  assign ram_1_addr = _zz_addr[15 : 0];
  assign load_data = ram_1_data_out;

endmodule

module Ram (
  input               clk,
  input               rst,
  input      [15:0]   addr,
  output reg [63:0]   data_out,
  input      [63:0]   data_in,
  input               write_en
);

  wire       [63:0]   ram_1_douta;

  RamIP ram_1 (
    .addra (addr[15:0]       ), //i
    .clka  (clk              ), //i
    .dina  (data_in[63:0]    ), //i
    .douta (ram_1_douta[63:0]), //o
    .wea   (write_en         )  //i
  );
  always @(*) begin
    if(rst) begin
      data_out = 64'h0;
    end else begin
      data_out = ram_1_douta;
    end
  end


endmodule

module ALU (
  input      [3:0]    aluOp,
  input      [63:0]   data1,
  input      [63:0]   data2,
  output              Zero,
  output     [63:0]   aluResult
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

endmodule

module Register_file (
  input               clk,
  input               rst,
  input               RegWrite,
  input      [4:0]    readReg1,
  input      [4:0]    readReg2,
  input      [4:0]    writeReg,
  input      [63:0]   writeData,
  output     [63:0]   readData1,
  output     [63:0]   readData2
);

  reg        [63:0]   _zz_readData1;
  reg        [63:0]   _zz_readData2;
  wire                core_clk;
  wire                core_reset;
  reg        [63:0]   coreArea_Regs_0;
  reg        [63:0]   coreArea_Regs_1;
  reg        [63:0]   coreArea_Regs_2;
  reg        [63:0]   coreArea_Regs_3;
  reg        [63:0]   coreArea_Regs_4;
  reg        [63:0]   coreArea_Regs_5;
  reg        [63:0]   coreArea_Regs_6;
  reg        [63:0]   coreArea_Regs_7;
  reg        [63:0]   coreArea_Regs_8;
  reg        [63:0]   coreArea_Regs_9;
  reg        [63:0]   coreArea_Regs_10;
  reg        [63:0]   coreArea_Regs_11;
  reg        [63:0]   coreArea_Regs_12;
  reg        [63:0]   coreArea_Regs_13;
  reg        [63:0]   coreArea_Regs_14;
  reg        [63:0]   coreArea_Regs_15;
  reg        [63:0]   coreArea_Regs_16;
  reg        [63:0]   coreArea_Regs_17;
  reg        [63:0]   coreArea_Regs_18;
  reg        [63:0]   coreArea_Regs_19;
  reg        [63:0]   coreArea_Regs_20;
  reg        [63:0]   coreArea_Regs_21;
  reg        [63:0]   coreArea_Regs_22;
  reg        [63:0]   coreArea_Regs_23;
  reg        [63:0]   coreArea_Regs_24;
  reg        [63:0]   coreArea_Regs_25;
  reg        [63:0]   coreArea_Regs_26;
  reg        [63:0]   coreArea_Regs_27;
  reg        [63:0]   coreArea_Regs_28;
  reg        [63:0]   coreArea_Regs_29;
  reg        [63:0]   coreArea_Regs_30;
  reg        [63:0]   coreArea_Regs_31;
  wire       [31:0]   _zz_1;

  always @(*) begin
    case(readReg1)
      5'b00000 : _zz_readData1 = coreArea_Regs_0;
      5'b00001 : _zz_readData1 = coreArea_Regs_1;
      5'b00010 : _zz_readData1 = coreArea_Regs_2;
      5'b00011 : _zz_readData1 = coreArea_Regs_3;
      5'b00100 : _zz_readData1 = coreArea_Regs_4;
      5'b00101 : _zz_readData1 = coreArea_Regs_5;
      5'b00110 : _zz_readData1 = coreArea_Regs_6;
      5'b00111 : _zz_readData1 = coreArea_Regs_7;
      5'b01000 : _zz_readData1 = coreArea_Regs_8;
      5'b01001 : _zz_readData1 = coreArea_Regs_9;
      5'b01010 : _zz_readData1 = coreArea_Regs_10;
      5'b01011 : _zz_readData1 = coreArea_Regs_11;
      5'b01100 : _zz_readData1 = coreArea_Regs_12;
      5'b01101 : _zz_readData1 = coreArea_Regs_13;
      5'b01110 : _zz_readData1 = coreArea_Regs_14;
      5'b01111 : _zz_readData1 = coreArea_Regs_15;
      5'b10000 : _zz_readData1 = coreArea_Regs_16;
      5'b10001 : _zz_readData1 = coreArea_Regs_17;
      5'b10010 : _zz_readData1 = coreArea_Regs_18;
      5'b10011 : _zz_readData1 = coreArea_Regs_19;
      5'b10100 : _zz_readData1 = coreArea_Regs_20;
      5'b10101 : _zz_readData1 = coreArea_Regs_21;
      5'b10110 : _zz_readData1 = coreArea_Regs_22;
      5'b10111 : _zz_readData1 = coreArea_Regs_23;
      5'b11000 : _zz_readData1 = coreArea_Regs_24;
      5'b11001 : _zz_readData1 = coreArea_Regs_25;
      5'b11010 : _zz_readData1 = coreArea_Regs_26;
      5'b11011 : _zz_readData1 = coreArea_Regs_27;
      5'b11100 : _zz_readData1 = coreArea_Regs_28;
      5'b11101 : _zz_readData1 = coreArea_Regs_29;
      5'b11110 : _zz_readData1 = coreArea_Regs_30;
      default : _zz_readData1 = coreArea_Regs_31;
    endcase
  end

  always @(*) begin
    case(readReg2)
      5'b00000 : _zz_readData2 = coreArea_Regs_0;
      5'b00001 : _zz_readData2 = coreArea_Regs_1;
      5'b00010 : _zz_readData2 = coreArea_Regs_2;
      5'b00011 : _zz_readData2 = coreArea_Regs_3;
      5'b00100 : _zz_readData2 = coreArea_Regs_4;
      5'b00101 : _zz_readData2 = coreArea_Regs_5;
      5'b00110 : _zz_readData2 = coreArea_Regs_6;
      5'b00111 : _zz_readData2 = coreArea_Regs_7;
      5'b01000 : _zz_readData2 = coreArea_Regs_8;
      5'b01001 : _zz_readData2 = coreArea_Regs_9;
      5'b01010 : _zz_readData2 = coreArea_Regs_10;
      5'b01011 : _zz_readData2 = coreArea_Regs_11;
      5'b01100 : _zz_readData2 = coreArea_Regs_12;
      5'b01101 : _zz_readData2 = coreArea_Regs_13;
      5'b01110 : _zz_readData2 = coreArea_Regs_14;
      5'b01111 : _zz_readData2 = coreArea_Regs_15;
      5'b10000 : _zz_readData2 = coreArea_Regs_16;
      5'b10001 : _zz_readData2 = coreArea_Regs_17;
      5'b10010 : _zz_readData2 = coreArea_Regs_18;
      5'b10011 : _zz_readData2 = coreArea_Regs_19;
      5'b10100 : _zz_readData2 = coreArea_Regs_20;
      5'b10101 : _zz_readData2 = coreArea_Regs_21;
      5'b10110 : _zz_readData2 = coreArea_Regs_22;
      5'b10111 : _zz_readData2 = coreArea_Regs_23;
      5'b11000 : _zz_readData2 = coreArea_Regs_24;
      5'b11001 : _zz_readData2 = coreArea_Regs_25;
      5'b11010 : _zz_readData2 = coreArea_Regs_26;
      5'b11011 : _zz_readData2 = coreArea_Regs_27;
      5'b11100 : _zz_readData2 = coreArea_Regs_28;
      5'b11101 : _zz_readData2 = coreArea_Regs_29;
      5'b11110 : _zz_readData2 = coreArea_Regs_30;
      default : _zz_readData2 = coreArea_Regs_31;
    endcase
  end

  assign core_clk = clk;
  assign core_reset = rst;
  assign readData1 = _zz_readData1;
  assign readData2 = _zz_readData2;
  assign _zz_1 = ({31'd0,1'b1} <<< writeReg);
  always @(posedge core_clk or posedge core_reset) begin
    if(core_reset) begin
      coreArea_Regs_0 <= 64'h0;
      coreArea_Regs_1 <= 64'h0;
      coreArea_Regs_2 <= 64'h0;
      coreArea_Regs_3 <= 64'h0;
      coreArea_Regs_4 <= 64'h0;
      coreArea_Regs_5 <= 64'h0;
      coreArea_Regs_6 <= 64'h0;
      coreArea_Regs_7 <= 64'h0;
      coreArea_Regs_8 <= 64'h0;
      coreArea_Regs_9 <= 64'h0;
      coreArea_Regs_10 <= 64'h0;
      coreArea_Regs_11 <= 64'h0;
      coreArea_Regs_12 <= 64'h0;
      coreArea_Regs_13 <= 64'h0;
      coreArea_Regs_14 <= 64'h0;
      coreArea_Regs_15 <= 64'h0;
      coreArea_Regs_16 <= 64'h0;
      coreArea_Regs_17 <= 64'h0;
      coreArea_Regs_18 <= 64'h0;
      coreArea_Regs_19 <= 64'h0;
      coreArea_Regs_20 <= 64'h0;
      coreArea_Regs_21 <= 64'h0;
      coreArea_Regs_22 <= 64'h0;
      coreArea_Regs_23 <= 64'h0;
      coreArea_Regs_24 <= 64'h0;
      coreArea_Regs_25 <= 64'h0;
      coreArea_Regs_26 <= 64'h0;
      coreArea_Regs_27 <= 64'h0;
      coreArea_Regs_28 <= 64'h0;
      coreArea_Regs_29 <= 64'h0;
      coreArea_Regs_30 <= 64'h0;
      coreArea_Regs_31 <= 64'h0;
    end else begin
      if(RegWrite) begin
        if(_zz_1[0]) begin
          coreArea_Regs_0 <= writeData;
        end
        if(_zz_1[1]) begin
          coreArea_Regs_1 <= writeData;
        end
        if(_zz_1[2]) begin
          coreArea_Regs_2 <= writeData;
        end
        if(_zz_1[3]) begin
          coreArea_Regs_3 <= writeData;
        end
        if(_zz_1[4]) begin
          coreArea_Regs_4 <= writeData;
        end
        if(_zz_1[5]) begin
          coreArea_Regs_5 <= writeData;
        end
        if(_zz_1[6]) begin
          coreArea_Regs_6 <= writeData;
        end
        if(_zz_1[7]) begin
          coreArea_Regs_7 <= writeData;
        end
        if(_zz_1[8]) begin
          coreArea_Regs_8 <= writeData;
        end
        if(_zz_1[9]) begin
          coreArea_Regs_9 <= writeData;
        end
        if(_zz_1[10]) begin
          coreArea_Regs_10 <= writeData;
        end
        if(_zz_1[11]) begin
          coreArea_Regs_11 <= writeData;
        end
        if(_zz_1[12]) begin
          coreArea_Regs_12 <= writeData;
        end
        if(_zz_1[13]) begin
          coreArea_Regs_13 <= writeData;
        end
        if(_zz_1[14]) begin
          coreArea_Regs_14 <= writeData;
        end
        if(_zz_1[15]) begin
          coreArea_Regs_15 <= writeData;
        end
        if(_zz_1[16]) begin
          coreArea_Regs_16 <= writeData;
        end
        if(_zz_1[17]) begin
          coreArea_Regs_17 <= writeData;
        end
        if(_zz_1[18]) begin
          coreArea_Regs_18 <= writeData;
        end
        if(_zz_1[19]) begin
          coreArea_Regs_19 <= writeData;
        end
        if(_zz_1[20]) begin
          coreArea_Regs_20 <= writeData;
        end
        if(_zz_1[21]) begin
          coreArea_Regs_21 <= writeData;
        end
        if(_zz_1[22]) begin
          coreArea_Regs_22 <= writeData;
        end
        if(_zz_1[23]) begin
          coreArea_Regs_23 <= writeData;
        end
        if(_zz_1[24]) begin
          coreArea_Regs_24 <= writeData;
        end
        if(_zz_1[25]) begin
          coreArea_Regs_25 <= writeData;
        end
        if(_zz_1[26]) begin
          coreArea_Regs_26 <= writeData;
        end
        if(_zz_1[27]) begin
          coreArea_Regs_27 <= writeData;
        end
        if(_zz_1[28]) begin
          coreArea_Regs_28 <= writeData;
        end
        if(_zz_1[29]) begin
          coreArea_Regs_29 <= writeData;
        end
        if(_zz_1[30]) begin
          coreArea_Regs_30 <= writeData;
        end
        if(_zz_1[31]) begin
          coreArea_Regs_31 <= writeData;
        end
      end
    end
  end


endmodule

module Controller (
  input      [31:0]   instruction,
  output reg [3:0]    aluCtr,
  output reg          aluSrc,
  output reg          shiftCtr,
  output reg          strip32,
  output reg [1:0]    exRes,
  output reg          regWriteEnable,
  output reg [2:0]    branch,
  output reg          jump,
  output reg          jalr,
  output reg [2:0]    load,
  output reg [2:0]    store,
  output reg          memWriteEnable,
  output reg [4:0]    rs1,
  output reg [4:0]    rs2,
  output reg [4:0]    rd
);

  wire       [51:0]   _zz_immediate;
  wire       [0:0]    _zz_immediate_1;
  wire       [6:0]    funct7;
  wire       [4:0]    rs2_1;
  wire       [4:0]    rs1_1;
  wire       [2:0]    funct3;
  wire       [4:0]    rd_1;
  wire       [6:0]    opcode;
  wire       [63:0]   immediate;
  wire       [11:0]   store_immediate;
  wire       [19:0]   U_immediate;
  wire       [3:0]    aluADD;
  wire       [3:0]    aluSLT;
  wire       [3:0]    aluSLTU;
  wire       [3:0]    aluAND;
  wire       [3:0]    aluOR;
  wire       [3:0]    aluXOR;
  wire       [3:0]    aluSLL;
  wire       [3:0]    aluSRL;
  wire       [3:0]    aluSUB;
  wire       [3:0]    aluSRA;
  wire       [2:0]    noLoad;
  wire       [2:0]    LoadByte;
  wire       [2:0]    LoadHalfWord;
  wire       [2:0]    LoadWord;
  wire       [2:0]    LoadDoubleWord;
  wire       [2:0]    noStore;
  wire       [2:0]    StoreByte;
  wire       [2:0]    StoreHalfWord;
  wire       [2:0]    StoreWord;
  wire       [2:0]    StoreDoubleWord;
  wire       [2:0]    noBranch;
  wire       [2:0]    BEQ;
  wire       [2:0]    BNE;
  wire       [2:0]    BGE;
  wire       [2:0]    BLT;
  wire       [1:0]    aluRes;
  wire       [1:0]    pc_plus_4;
  wire       [1:0]    LUI;
  wire       [1:0]    AUIPC;

  assign _zz_immediate_1 = instruction[31];
  assign _zz_immediate = {51'd0, _zz_immediate_1};
  assign funct7 = instruction[31 : 25];
  assign rs2_1 = instruction[24 : 20];
  assign rs1_1 = instruction[19 : 15];
  assign funct3 = instruction[14 : 12];
  assign rd_1 = instruction[11 : 7];
  assign opcode = instruction[6 : 0];
  assign immediate = {_zz_immediate,instruction[31 : 20]};
  assign store_immediate = {instruction[31 : 25],instruction[11 : 7]};
  assign U_immediate = instruction[31 : 12];
  always @(*) begin
    rs2 = 5'h0;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
      end
      7'h1b : begin
      end
      7'h23 : begin
      end
      7'h33 : begin
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
      end
      7'h63 : begin
      end
      7'h67 : begin
      end
      7'h6f : begin
      end
      default : begin
        rs2 = 5'h0;
      end
    endcase
  end

  always @(*) begin
    rs1 = 5'h0;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
      end
      7'h1b : begin
      end
      7'h23 : begin
      end
      7'h33 : begin
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
      end
      7'h63 : begin
      end
      7'h67 : begin
        rs1 = rs1_1;
      end
      7'h6f : begin
      end
      default : begin
        rs1 = 5'h0;
      end
    endcase
  end

  always @(*) begin
    rd = 5'h0;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
      end
      7'h1b : begin
      end
      7'h23 : begin
      end
      7'h33 : begin
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
      end
      7'h63 : begin
      end
      7'h67 : begin
        rd = rd_1;
      end
      7'h6f : begin
      end
      default : begin
        rd = 5'h0;
      end
    endcase
  end

  assign aluADD = 4'b0000;
  assign aluSLT = 4'b0001;
  assign aluSLTU = 4'b0010;
  assign aluAND = 4'b0011;
  assign aluOR = 4'b0100;
  assign aluXOR = 4'b0101;
  assign aluSLL = 4'b0110;
  assign aluSRL = 4'b0111;
  assign aluSUB = 4'b1000;
  assign aluSRA = 4'b1001;
  assign noLoad = 3'b000;
  assign LoadByte = 3'b001;
  assign LoadHalfWord = 3'b010;
  assign LoadWord = 3'b011;
  assign LoadDoubleWord = 3'b100;
  assign noStore = 3'b000;
  assign StoreByte = 3'b001;
  assign StoreHalfWord = 3'b010;
  assign StoreWord = 3'b011;
  assign StoreDoubleWord = 3'b100;
  assign noBranch = 3'b000;
  assign BEQ = 3'b001;
  assign BNE = 3'b010;
  assign BGE = 3'b100;
  assign BLT = 3'b101;
  assign aluRes = 2'b00;
  assign pc_plus_4 = 2'b01;
  assign LUI = 2'b10;
  assign AUIPC = 2'b11;
  always @(*) begin
    aluCtr = aluADD;
    case(opcode)
      7'h03 : begin
        aluCtr = aluADD;
      end
      7'h13 : begin
        case(funct3)
          3'b000 : begin
            aluCtr = aluADD;
          end
          3'b010 : begin
            aluCtr = aluSLT;
          end
          3'b011 : begin
            aluCtr = aluSLTU;
          end
          3'b111 : begin
            aluCtr = aluAND;
          end
          3'b110 : begin
            aluCtr = aluOR;
          end
          3'b100 : begin
            aluCtr = aluXOR;
          end
          3'b001 : begin
            aluCtr = aluSLL;
          end
          default : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluSRL;
              end
              7'h20 : begin
                aluCtr = aluSRA;
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h1b : begin
        case(funct3)
          3'b000 : begin
            aluCtr = aluADD;
          end
          3'b001 : begin
            aluCtr = aluSLL;
          end
          3'b101 : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluSRL;
              end
              7'h20 : begin
                aluCtr = aluSRA;
              end
              default : begin
              end
            endcase
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        aluCtr = aluADD;
      end
      7'h33 : begin
        case(funct3)
          3'b000 : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluADD;
              end
              7'h20 : begin
                aluCtr = aluSUB;
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            aluCtr = aluSLT;
          end
          3'b011 : begin
            aluCtr = aluSLTU;
          end
          3'b111 : begin
            aluCtr = aluAND;
          end
          3'b110 : begin
            aluCtr = aluOR;
          end
          3'b100 : begin
            aluCtr = aluXOR;
          end
          3'b001 : begin
            aluCtr = aluSLL;
          end
          default : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluSRL;
              end
              7'h20 : begin
                aluCtr = aluSRA;
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        case(funct3)
          3'b000 : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluADD;
              end
              7'h20 : begin
                aluCtr = aluSUB;
              end
              default : begin
              end
            endcase
          end
          3'b001 : begin
            aluCtr = aluSLL;
          end
          3'b101 : begin
            case(funct7)
              7'h0 : begin
                aluCtr = aluSRL;
              end
              7'h20 : begin
                aluCtr = aluSRA;
              end
              default : begin
              end
            endcase
          end
          default : begin
          end
        endcase
      end
      7'h63 : begin
        aluCtr = aluSUB;
      end
      7'h67 : begin
        aluCtr = aluADD;
      end
      7'h6f : begin
      end
      default : begin
        aluCtr = aluADD;
      end
    endcase
  end

  always @(*) begin
    aluSrc = 1'b0;
    case(opcode)
      7'h03 : begin
        aluSrc = 1'b0;
      end
      7'h13 : begin
        aluSrc = 1'b0;
      end
      7'h1b : begin
        aluSrc = 1'b0;
      end
      7'h23 : begin
        aluSrc = 1'b0;
      end
      7'h33 : begin
        aluSrc = 1'b1;
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        aluSrc = 1'b1;
      end
      7'h63 : begin
        aluSrc = 1'b1;
      end
      7'h67 : begin
        aluSrc = 1'b1;
      end
      7'h6f : begin
      end
      default : begin
        aluSrc = 1'b0;
      end
    endcase
  end

  always @(*) begin
    shiftCtr = 1'b0;
    case(opcode)
      7'h03 : begin
        shiftCtr = 1'b0;
      end
      7'h13 : begin
        shiftCtr = 1'b0;
        case(funct3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b111 : begin
          end
          3'b110 : begin
          end
          3'b100 : begin
          end
          3'b001 : begin
            shiftCtr = 1'b1;
          end
          default : begin
            shiftCtr = 1'b1;
          end
        endcase
      end
      7'h1b : begin
        shiftCtr = 1'b0;
        case(funct3)
          3'b001 : begin
            shiftCtr = 1'b1;
          end
          3'b101 : begin
            shiftCtr = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        shiftCtr = 1'b0;
      end
      7'h33 : begin
        shiftCtr = 1'b0;
        case(funct3)
          3'b000 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b111 : begin
          end
          3'b110 : begin
          end
          3'b100 : begin
          end
          3'b001 : begin
            shiftCtr = 1'b1;
          end
          default : begin
            shiftCtr = 1'b1;
          end
        endcase
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        shiftCtr = 1'b0;
        case(funct3)
          3'b001 : begin
            shiftCtr = 1'b1;
          end
          3'b101 : begin
            shiftCtr = 1'b1;
          end
          default : begin
          end
        endcase
      end
      7'h63 : begin
        shiftCtr = 1'b0;
      end
      7'h67 : begin
        shiftCtr = 1'b0;
      end
      7'h6f : begin
      end
      default : begin
        shiftCtr = 1'b0;
      end
    endcase
  end

  always @(*) begin
    strip32 = 1'b0;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
        strip32 = 1'b0;
      end
      7'h1b : begin
        strip32 = 1'b1;
      end
      7'h23 : begin
      end
      7'h33 : begin
        strip32 = 1'b0;
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        strip32 = 1'b1;
      end
      7'h63 : begin
      end
      7'h67 : begin
      end
      7'h6f : begin
      end
      default : begin
        strip32 = 1'b0;
      end
    endcase
  end

  always @(*) begin
    branch = 3'b000;
    case(opcode)
      7'h03 : begin
        branch = noBranch;
      end
      7'h13 : begin
        branch = noBranch;
      end
      7'h1b : begin
        branch = noBranch;
      end
      7'h23 : begin
        branch = noBranch;
      end
      7'h33 : begin
        branch = noBranch;
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        branch = noBranch;
      end
      7'h63 : begin
        case(funct3)
          3'b000 : begin
            branch = BEQ;
          end
          3'b001 : begin
            branch = BNE;
          end
          3'b100 : begin
            branch = BLT;
          end
          3'b101 : begin
            branch = BGE;
          end
          default : begin
          end
        endcase
      end
      7'h67 : begin
        branch = noBranch;
      end
      7'h6f : begin
        branch = noBranch;
      end
      default : begin
        branch = noBranch;
      end
    endcase
  end

  always @(*) begin
    jump = 1'b0;
    case(opcode)
      7'h03 : begin
        jump = 1'b0;
      end
      7'h13 : begin
        jump = 1'b0;
      end
      7'h1b : begin
        jump = 1'b0;
      end
      7'h23 : begin
        jump = 1'b0;
      end
      7'h33 : begin
        jump = 1'b0;
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
        jump = 1'b0;
      end
      7'h63 : begin
      end
      7'h67 : begin
        jump = 1'b1;
      end
      7'h6f : begin
        jump = 1'b1;
      end
      default : begin
        jump = 1'b0;
      end
    endcase
  end

  always @(*) begin
    jalr = 1'b0;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
      end
      7'h1b : begin
      end
      7'h23 : begin
      end
      7'h33 : begin
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
      end
      7'h63 : begin
      end
      7'h67 : begin
        jalr = 1'b1;
      end
      7'h6f : begin
        jalr = 1'b0;
      end
      default : begin
        jalr = 1'b0;
      end
    endcase
  end

  always @(*) begin
    load = 3'b000;
    case(opcode)
      7'h03 : begin
        case(funct3)
          3'b000 : begin
            load = LoadByte;
          end
          3'b001 : begin
            load = LoadHalfWord;
          end
          3'b010 : begin
            load = LoadWord;
          end
          3'b011 : begin
            load = LoadDoubleWord;
          end
          default : begin
          end
        endcase
      end
      7'h13 : begin
        load = noLoad;
      end
      7'h1b : begin
        load = noLoad;
      end
      7'h23 : begin
      end
      7'h33 : begin
        load = noLoad;
      end
      7'h37 : begin
        load = noLoad;
      end
      7'h17 : begin
        load = noLoad;
      end
      7'h3b : begin
        load = noLoad;
      end
      7'h63 : begin
      end
      7'h67 : begin
        load = noLoad;
      end
      7'h6f : begin
        load = noLoad;
      end
      default : begin
        load = noLoad;
      end
    endcase
  end

  always @(*) begin
    store = 3'b000;
    case(opcode)
      7'h03 : begin
      end
      7'h13 : begin
      end
      7'h1b : begin
      end
      7'h23 : begin
        case(funct3)
          3'b000 : begin
            store = StoreByte;
          end
          3'b001 : begin
            store = StoreHalfWord;
          end
          3'b010 : begin
            store = StoreWord;
          end
          3'b011 : begin
            store = StoreDoubleWord;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
      end
      7'h37 : begin
      end
      7'h17 : begin
      end
      7'h3b : begin
      end
      7'h63 : begin
      end
      7'h67 : begin
      end
      7'h6f : begin
      end
      default : begin
        store = noStore;
      end
    endcase
  end

  always @(*) begin
    case(opcode)
      7'h03 : begin
        memWriteEnable = 1'b0;
      end
      7'h13 : begin
        memWriteEnable = 1'b0;
      end
      7'h1b : begin
        memWriteEnable = 1'b0;
      end
      7'h23 : begin
        memWriteEnable = 1'b1;
      end
      7'h33 : begin
        memWriteEnable = 1'b0;
      end
      7'h37 : begin
        memWriteEnable = 1'b0;
      end
      7'h17 : begin
        memWriteEnable = 1'b0;
      end
      7'h3b : begin
        memWriteEnable = 1'b0;
      end
      7'h63 : begin
        memWriteEnable = 1'b0;
      end
      7'h67 : begin
        memWriteEnable = 1'b0;
      end
      7'h6f : begin
        memWriteEnable = 1'b0;
      end
      default : begin
        memWriteEnable = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(opcode)
      7'h03 : begin
        exRes = aluRes;
      end
      7'h13 : begin
        exRes = aluRes;
      end
      7'h1b : begin
        exRes = aluRes;
      end
      7'h23 : begin
        exRes = aluRes;
      end
      7'h33 : begin
        exRes = aluRes;
      end
      7'h37 : begin
        exRes = LUI;
      end
      7'h17 : begin
        exRes = AUIPC;
      end
      7'h3b : begin
        exRes = aluRes;
      end
      7'h63 : begin
        exRes = aluRes;
      end
      7'h67 : begin
        exRes = pc_plus_4;
      end
      7'h6f : begin
        exRes = pc_plus_4;
      end
      default : begin
        exRes = aluRes;
      end
    endcase
  end

  always @(*) begin
    case(opcode)
      7'h03 : begin
        regWriteEnable = 1'b1;
      end
      7'h13 : begin
        regWriteEnable = 1'b1;
      end
      7'h1b : begin
        regWriteEnable = 1'b1;
      end
      7'h23 : begin
        regWriteEnable = 1'b0;
      end
      7'h33 : begin
        regWriteEnable = 1'b1;
      end
      7'h37 : begin
        regWriteEnable = 1'b1;
      end
      7'h17 : begin
        regWriteEnable = 1'b1;
      end
      7'h3b : begin
        regWriteEnable = 1'b1;
      end
      7'h63 : begin
        regWriteEnable = 1'b0;
      end
      7'h67 : begin
        regWriteEnable = 1'b1;
      end
      7'h6f : begin
        regWriteEnable = 1'b1;
      end
      default : begin
        regWriteEnable = 1'b0;
      end
    endcase
  end


endmodule

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

  wire       [15:0]   coreArea_instRom_addr;
  wire       [31:0]   coreArea_instRom_data;
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

  Rom coreArea_instRom (
    .clk  (core_clk                   ), //i
    .rst  (core_reset                 ), //i
    .addr (coreArea_instRom_addr[15:0]), //i
    .data (coreArea_instRom_data[31:0])  //o
  );
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
  assign coreArea_instRom_addr = coreArea_pc[15 : 0];
  assign instruction = coreArea_instRom_data;
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

module Rom (
  input               clk,
  input               rst,
  input      [15:0]   addr,
  output reg [31:0]   data
);

  wire       [31:0]   coreArea_rom_douta;
  wire                core_clk;
  wire                core_reset;

  RomIP coreArea_rom (
    .addra (addr[15:0]              ), //i
    .clka  (core_clk                ), //i
    .douta (coreArea_rom_douta[31:0])  //o
  );
  assign core_clk = clk;
  assign core_reset = rst;
  always @(*) begin
    if(core_reset) begin
      data = 32'h0;
    end else begin
      data = coreArea_rom_douta;
    end
  end


endmodule
