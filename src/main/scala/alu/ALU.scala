package alu

import spinal.core._
import spinal.lib._

class ALU extends Component {
	val io = new Bundle {
		val aluOp = in UInt (4 bits)
		val data1 = in UInt (64 bits)
		val data2 = in UInt (64 bits)
		val Zero = out Bool()
		val aluResult = out UInt (64 bits)
	}
	noIoPrefix()

	val sigCtr = Bool()
	val subCtr = Bool()
	val overflowCtr = Bool()
	val shiftCtr = UInt(2 bits)
	val logicCtr = UInt(2 bits)

	sigCtr := io.aluOp.mux(
		2 -> False,
		default -> True
	)
	subCtr := io.aluOp.mux(
		1 -> True,
		2 -> True,
		8 -> True,
		default -> False
	)
	overflowCtr := io.aluOp.mux(
		2 -> False,
		default -> True
	)
	shiftCtr := io.aluOp.mux(
		U"4'b0110" -> 0,
		U"4'b0111" -> 2,
		U"4'b1001" -> 1
	)
	logicCtr := io.aluOp.mux(
		3 -> 0,
		4 -> 1,
		5 -> 2
	)
}
