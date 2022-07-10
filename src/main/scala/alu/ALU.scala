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

}
