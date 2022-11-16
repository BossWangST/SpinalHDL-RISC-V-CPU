package dataroad

import spinal.core._

class ila extends BlackBox {
	val io = new Bundle {
		val clk = in Bool()
		val probe0 = in Bool()
		val probe1 = in UInt (64 bits) // pc
		val probe2 = in UInt (32 bits) // inst
		val probe3 = in UInt (64 bits) // x1
		val probe4 = in UInt (64 bits) // x2
		val probe5 = in UInt (64 bits) // x3
		val probe6 = in UInt (64 bits) // x4
		val probe7 = in UInt (64 bits) // x5
		val probe8 = in UInt (64 bits) // x6
		val probe9 = in UInt (64 bits) // x7
		val probe10 = in UInt (64 bits) // x8
		val probe11 = in UInt (64 bits) // x9
		val probe12 = in UInt (64 bits) // x10
		val probe13 = in UInt(64 bits) // write_data
		val probe14 = in UInt(64 bits) // read_data
	}

	noIoPrefix()
}
