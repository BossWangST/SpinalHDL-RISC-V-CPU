package alu

import spinal.core._
import spinal.lib._

class ALU extends Component {
	val io = new Bundle {
		val aluOp = in UInt (4 bits)
		val data1 = in UInt (64 bits) //from rs1
		val data2 = in UInt (64 bits) //from rs2 or immediate
		val Zero = out Bool()
		val aluResult = out UInt (64 bits)
	}
	noIoPrefix()

	//get control signal for each module: Adder, Shifter, Logical calculator
	val opCtr = UInt(2 bits)
	switch(io.aluOp) {
		is(U"4'b0000", U"4'b1000") {
			opCtr := 0
		}
		is(U"4'b0001", U"4'b0010") {
			opCtr := 1
		}
		is(U"4'b0110", U"4'b0111", U"4'b1001") {
			opCtr := 2
		}
		is(U"4'b0011", U"4'b0100", U"4'b0101") {
			opCtr := 3
		}
		default {
			opCtr := 0
		}
	}
	val signCtr = io.aluOp.mux(
		U"4'b0010" -> False,
		default -> True
	)
	val subCtr = io.aluOp.mux(
		U"4'b0001" -> True,
		U"4'b0010" -> True,
		U"4'b1000" -> True,
		default -> False
	)
	val overflowCtr = io.aluOp.mux(
		U"4'b0010" -> False,
		default -> True
	)
	val shiftCtr = io.aluOp.mux(
		U"4'b0110" -> U"2'b00",
		U"4'b0111" -> U"2'b10",
		U"4'b1001" -> U"2'b01",
		default -> U"2'b00"
	)
	val logicCtr = io.aluOp.mux(
		U"4'b0011" -> U"2'b00",
		U"4'b0100" -> U"2'b01",
		U"4'b0101" -> U"2'b10",
		default -> U"2'b00"
	)

	//Adder & SLT
	val adder = new Adder
	adder.io.data1 := io.data1
	adder.io.data2 := subCtr ? io.data2.reversed | io.data2
	adder.io.carryIn := subCtr
	val adderOverflow = adder.io.overflow
	val adderSign = adder.io.sign
	val adderCarryOut = adder.io.carryOut
	io.Zero := adder.io.zero
	val adderResult = adder.io.adderResult
	//for SLT & SLTU
	val carryFlag = subCtr ^ adderCarryOut
	val signFlag = (adderOverflow & overflowCtr) ^ adderSign
	val sltResult = (signCtr ? signFlag | carryFlag) ? U"64'b1" | U"64'b0"

	//Shifter
	val shifter = new Shifter
	shifter.io.data := io.data1
	shifter.io.shamt := io.data2(4 downto 0)
	shifter.io.shiftCtr := shiftCtr
	val shiftResult = shifter.io.shiftResult

	//Logical calculator
	val andResult = io.data1 & io.data2
	val orResult = io.data1 | io.data2
	val xorResult = io.data1 ^ io.data2
	val logicResult = logicCtr.mux(
		0 -> andResult,
		1 -> orResult,
		2 -> xorResult,
		default -> U"64'b0"
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