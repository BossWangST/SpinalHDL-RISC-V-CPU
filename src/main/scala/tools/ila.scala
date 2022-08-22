package tools

import spinal.core._

class ila extends BlackBox {
	val io = new Bundle {
		val clk = in Bool()
		val probe0 = in Bool()
		val probe1 = in UInt (64 bits)
		val probe2 = in UInt (64 bits)
		val probe3 = in UInt (64 bits)
		val probe4 = in UInt (32 bits)
	}

	noIoPrefix()
}
