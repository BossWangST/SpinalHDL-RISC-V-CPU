package alu

import spinal.core._
import spinal.lib._

class ALU extends Component {
	val io = new Bundle {
		val aluOp = in UInt (4 bits)
		val data1 = in SInt (64 bits) //from rs1
		val data2 = in SInt (64 bits) //from rs2 or immediate
		val Zero = out Bool()
		val aluResult = out SInt (64 bits)
	}
	noIoPrefix()

	//get control signal for each module: Adder, Shifter, Logical calculator
	val opCtr = UInt(2 bits)
	switch(io.aluOp) {
		is(U"4'b0000", U"4'b1000") {
			opCtr := 0 //for Adder
		}
		is(U"4'b0001", U"4'b0010") {
			opCtr := 1 //for SLT & SLTU
		}
		is(U"4'b0110", U"4'b0111", U"4'b1001") {
			opCtr := 2 //for Shifter
		}
		is(U"4'b0011", U"4'b0100", U"4'b0101") {
			opCtr := 3 //for logic calculator
		}
		default {
			opCtr := 0
		}
	}
	val signCtr = io.aluOp.mux(
		U"4'b0010" -> False, //no need for adderSign
		default -> True
	)
	val subCtr = io.aluOp.mux(
		U"4'b0001" -> True, //True for subtraction
		U"4'b0010" -> True,
		U"4'b1000" -> True,
		default -> False
	)
	val overflowCtr = io.aluOp.mux(
		U"4'b0010" -> False, //no need for adderOverflow
		default -> True
	)
	val shiftCtr = io.aluOp.mux(
		U"4'b0110" -> U"2'b00", //SLL
		U"4'b0111" -> U"2'b10", //SRL
		U"4'b1001" -> U"2'b01", //SRA
		default -> U"2'b00"
	)
	val logicCtr = io.aluOp.mux(
		U"4'b0011" -> U"2'b00", //AND
		U"4'b0100" -> U"2'b01", //OR
		U"4'b0101" -> U"2'b10", //XOR
		default -> U"2'b00"
	)

	//Adder & SLT
	val adder = new Adder
	adder.io.data1 := io.data1.asUInt
	adder.io.data2 := subCtr ? ~io.data2.asUInt | io.data2.asUInt
	adder.io.subCtr := subCtr
	val adderOverflow = adder.io.overflow
	val adderSign = adder.io.sign
	val adderCarryOut = adder.io.carryOut
	io.Zero := adder.io.zero
	val adderResult = adder.io.adderResult.asSInt
	//for SLT & SLTU
	val sltLess = adderSign ^ adderOverflow
	val sltuLess = ~adderCarryOut
	val sltResult = (signCtr ? sltLess | sltuLess) ? S"64'b1" | S"64'b0"

	//Shifter
	val shifter = new Shifter
	shifter.io.data := io.data1.asUInt
	shifter.io.shamt := io.data2(4 downto 0).asUInt
	shifter.io.shiftCtr := shiftCtr
	val shiftResult = shifter.io.shiftResult.asSInt

	//Logical calculator
	val andResult = io.data1 & io.data2
	val orResult = io.data1 | io.data2
	val xorResult = io.data1 ^ io.data2
	val logicResult = logicCtr.mux(
		0 -> andResult,
		1 -> orResult,
		2 -> xorResult,
		default -> S"64'b0"
	)

	io.aluResult := opCtr.mux(
		0 -> adderResult,
		1 -> sltResult,
		2 -> shiftResult,
		3 -> logicResult
	)
}

object ALUVerilog {
	def main(array: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/ALU"
		).generate(new ALU)
	}
}