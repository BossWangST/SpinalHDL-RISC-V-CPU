package dataroad

import spinal.core._

class vio_0 extends BlackBox {
	val io = new Bundle {
		val clk = in Bool()

		val probe_in0 = in UInt (64 bits) // pc
	}
	noIoPrefix()
}
