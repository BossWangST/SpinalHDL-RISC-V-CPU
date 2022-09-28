package control

import spinal.core._
import spinal.lib._
import _root_.tools.RV64I_Encoding

class Controller extends Component {
	val io = new Bundle {
		val instruction = in UInt (32 bits)
		// ALU
		val aluCtr = out UInt (4 bits) // 4 bits signal for ALU
		val aluSrc = out Bool() // select data2 for ALU, True => from register, False => immediate
		val shiftCtr = out Bool() // if instruction is shifting, then data2 should be lower 5 bits of immediate
		val strip32 = out Bool() // for some RV64I instructions, requiring the result to be lower 32 bits
		val exRes = out UInt (2 bits) // 2 bits signal to choose execution part result
		// exRes => 00 -- ALU result  01 -- PC+4  10 -- LUI  11 -- AUIPC
		// Register_file
		val regWriteEnable = out Bool() // register write operation enable signal
		// PC
		val branch = out UInt (3 bits)
		// branch => 000 -- DO NOT BRANCH  001 -- BEQ  010 -- BNE  011 -- BLT  100 -- BGE
		val jump = out Bool()
		val jalr = out Bool() // if JALR, then jump address is True => ALU result, else False => immediate
		// Memory
		val load = out UInt (3 bits) // load data from memory to register, 000 => write_data is ALU result, 001 => LB, 010 => LH, 011 => LW, 100 => LD
		val store = out UInt (3 bits) // same as load
		val memWriteEnable = out Bool() // memory write operation enable signal
		// Register Index
		val rs1 = out UInt (5 bits)
		val rs2 = out UInt (5 bits)
		val rd = out UInt (5 bits)
	}
	noIoPrefix()

	// for R-type instruction
	val funct7 = io.instruction(31 downto 25)
	val rs2 = io.instruction(24 downto 20)
	val rs1 = io.instruction(19 downto 15)
	val funct3 = io.instruction(14 downto 12)
	val rd = io.instruction(11 downto 7)
	val opcode = io.instruction(6 downto 0)
	// for I-type
	val immediate = UInt(64 bits)
	immediate := U(io.instruction(31), 52 bits) @@ io.instruction(31 downto 20)
	// for S-type
	val store_immediate = io.instruction(31 downto 25) @@ io.instruction(11 downto 7)
	/*
	// for B-type
	val branch_immediate = io.instruction(31).asUInt @@ io.instruction(7).asUInt @@ io.instruction(30 downto 25) @@ io.instruction(11 downto 8)
	// for J-type
	val jump_immediate = io.instruction(31).asUInt @@ io.instruction(19 downto 12) @@ io.instruction(20).asUInt @@ io.instruction(30 downto 21)
	*/
	// for LUI & AUIPC
	val U_immediate = io.instruction(31 downto 12)

	io.rs2 := 0
	io.rs1 := 0
	io.rd := 0

	val aluADD = U"0000"
	val aluSLT = U"0001"
	val aluSLTU = U"0010"
	val aluAND = U"0011"
	val aluOR = U"0100"
	val aluXOR = U"0101"
	val aluSLL = U"0110"
	val aluSRL = U"0111"
	val aluSUB = U"1000"
	val aluSRA = U"1001"

	val noLoad = U"000"
	val LoadByte = U"001"
	val LoadHalfWord = U"010"
	val LoadWord = U"011"
	val LoadDoubleWord = U"100"
	val noStore = U"000"
	val StoreByte = U"001"
	val StoreHalfWord = U"010"
	val StoreWord = U"011"
	val StoreDoubleWord = U"100"

	val noBranch = U"000"
	val BEQ = U"001"
	val BNE = U"010"
	val BGE = U"100"
	val BLT = U"101"

	val aluRes = U"00"
	val pc_plus_4 = U"01"
	val LUI = U"10"
	val AUIPC = U"11"

	io.aluCtr := aluADD
	io.aluSrc := False
	io.shiftCtr := False
	io.strip32 := False

	io.branch := U"000"
	io.jump := False
	io.jalr := False

	io.load := U"000"
	io.store := U"000"

	switch(opcode) {
		default {
			io.rs2 := 0
			io.rs1 := 0
			io.rd := 0

			io.aluCtr := aluADD
			io.aluSrc := False
			io.shiftCtr := False
			io.strip32 := False
			io.exRes := aluRes

			io.regWriteEnable := False

			io.branch := noBranch
			io.jump := False
			io.jalr := False

			io.load := noLoad
			io.store := noStore
			io.memWriteEnable := False
		}
		is(U"00_000_11") {
			// LOAD

			// disable memory write enable signal
			io.memWriteEnable := False
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch
			// ALU = ADD
			io.aluSrc := False
			io.aluCtr := aluADD
			io.shiftCtr := False
			io.exRes := aluRes
			// Register, write memory data to rd
			io.regWriteEnable := True
			switch(funct3) {
				is(U"000") {
					// LB
					io.load := LoadByte
				}
				is(U"001") {
					// LH
					io.load := LoadHalfWord
				}
				is(U"010") {
					// LW
					io.load := LoadWord
				}
				is(U"011") {
					// LD
					io.load := LoadDoubleWord
				}
			}
		}
		is(U"00_100_11") {
			// OP-IMM

			//write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch
			// ALU data2 must be immediate
			io.aluSrc := False
			io.strip32 := False
			io.exRes := aluRes
			io.load := noLoad
			io.shiftCtr := False
			switch(funct3) {
				is(U"000") {
					// ADDI
					io.aluCtr := aluADD
				}
				is(U"010") {
					// SLTI
					io.aluCtr := aluSLT
				}
				is(U"011") {
					// SLTIU
					io.aluCtr := aluSLTU
				}
				is(U"111") {
					// ANDI
					io.aluCtr := aluAND
				}
				is(U"110") {
					// ORI
					io.aluCtr := aluOR
				}
				is(U"100") {
					// XORI
					io.aluCtr := aluXOR
				}
				is(U"001") {
					// SLLI
					io.aluCtr := aluSLL
					io.shiftCtr := True
				}
				is(U"101") {
					// SRLI SRAI
					io.shiftCtr := True
					switch(funct7) {
						is(U"0000000") {
							// SRLI
							io.aluCtr := aluSRL
						}
						is(U"0100000") {
							// SRAI
							io.aluCtr := aluSRA
						}
					}
				}
			}
		}
		is(U"00_110_11") {
			// OP-IMM-32

			// write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch

			io.aluSrc := False
			io.strip32 := True
			io.exRes := aluRes
			io.load := noLoad
			io.shiftCtr := False
			switch(funct3) {
				is(U"000") {
					// ADDIW
					io.aluCtr := aluADD
				}
				is(U"001") {
					// SLLIW
					io.aluCtr := aluSLL
					io.shiftCtr := True
				}
				is(U"101") {
					// SRLIW SRAIW
					io.shiftCtr := True
					switch(funct7) {
						is(U"0000000") {
							// SRLIW
							io.aluCtr := aluSRL
						}
						is(U"0100000") {
							// SRAIW
							io.aluCtr := aluSRA
						}
					}
				}
			}
		}
		is(U"01_000_11") {
			// STORE

			// disable register write enable signal
			io.regWriteEnable := False
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch
			// ALU = ADD
			io.aluSrc := False
			io.shiftCtr := False
			io.aluCtr := aluADD
			io.exRes := aluRes
			// Memory, write
			io.memWriteEnable := True
			switch(funct3) {
				is(U"000") {
					// SB
					io.store := StoreByte
				}
				is(U"001") {
					// SH
					io.store := StoreHalfWord
				}
				is(U"010") {
					// SW
					io.store := StoreWord
				}
				is(U"011") {
					// SD
					io.store := StoreDoubleWord
				}
			}
		}
		is(U"01_100_11") {
			// OP

			//write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch

			io.aluSrc := True
			io.strip32 := False
			io.exRes := aluRes
			io.load := noLoad
			io.shiftCtr := False
			switch(funct3) {
				is(U"000") {
					// ADD SUB
					switch(funct7) {
						is(U"0000000") {
							// ADD
							io.aluCtr := aluADD
						}
						is(U"0100000") {
							// SUB
							io.aluCtr := aluSUB
						}
					}
				}
				is(U"010") {
					// SLT
					io.aluCtr := aluSLT
				}
				is(U"011") {
					// SLTU
					io.aluCtr := aluSLTU
				}
				is(U"111") {
					// AND
					io.aluCtr := aluAND
				}
				is(U"110") {
					// OR
					io.aluCtr := aluOR
				}
				is(U"100") {
					// XOR
					io.aluCtr := aluXOR
				}
				is(U"001") {
					// SLL
					io.aluCtr := aluSLL
					io.shiftCtr := True
				}
				is(U"101") {
					// SRL SRA
					io.shiftCtr := True
					switch(funct7) {
						is(U"0000000") {
							// SRL
							io.aluCtr := aluSRL
						}
						is(U"0100000") {
							// SRA
							io.aluCtr := aluSRA
						}
					}
				}
			}
		}
		is(U"01_101_11") {
			// LUI

			// write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True

			io.exRes := LUI
			io.load := noLoad
		}
		is(U"00_101_11") {
			// AUIPC

			// write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True

			io.exRes := AUIPC
			io.load := noLoad
		}
		is(U"01_110_11") {
			// OP-32

			// write enable signal
			io.memWriteEnable := False
			io.regWriteEnable := True
			// disable branch & jump signal
			io.jump := False
			io.branch := noBranch

			io.aluSrc := True
			io.strip32 := True
			io.exRes := aluRes
			io.load := noLoad
			io.shiftCtr := False
			switch(funct3) {
				is(U"000") {
					// ADDW SUBW
					switch(funct7) {
						is(U"0000000") {
							// ADDW
							io.aluCtr := aluADD
						}
						is(U"0100000") {
							// SUBW
							io.aluCtr := aluSUB
						}
					}
				}
				is(U"001") {
					// SLLW
					io.aluCtr := aluSLL
					io.shiftCtr := True
				}
				is(U"101") {
					// SRLW SRAW
					io.shiftCtr := True
					switch(funct7) {
						is(U"0000000") {
							// SRLW
							io.aluCtr := aluSRL
						}
						is(U"0100000") {
							// SRAW
							io.aluCtr := aluSRA
						}
					}
				}
			}
		}
		is(U"11_000_11") {
			// BRANCH

			// disable write enable signals
			io.regWriteEnable := False
			io.memWriteEnable := False
			// branch
			io.exRes := aluRes
			// ALU
			io.aluCtr := aluSUB
			io.aluSrc := True
			io.shiftCtr := False
			switch(funct3) {
				is(U"000") {
					// BEQ
					io.branch := BEQ
				}
				is(U"001") {
					// BNE
					io.branch := BNE
				}
				is(U"100") {
					// BLT
					io.branch := BLT
				}
				is(U"101") {
					// BGE
					io.branch := BGE
				}
			}
		}
		is(U"11_001_11") {
			// JALR

			// disable memory write enable signal
			io.memWriteEnable := False
			// Register, store pc+4 into rd
			io.regWriteEnable := True
			io.rs1 := rs1
			io.rd := rd
			io.aluSrc := True
			io.aluCtr := aluADD
			io.shiftCtr := False
			// JALR
			io.jump := True
			io.branch := noBranch
			io.exRes := pc_plus_4
			io.load := noLoad
			io.jalr := True
		}
		is(U"11_011_11") {
			// JAL

			// disable memory write enable signal
			io.memWriteEnable := False
			// Register, store pc+4 into rd
			io.regWriteEnable := True
			// JAL
			io.jump := True
			io.branch := noBranch
			io.exRes := pc_plus_4
			io.load := noLoad
			io.jalr := False
		}
	}


}

object ControllerVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Controller"
		).generate(new Controller)
	}
}