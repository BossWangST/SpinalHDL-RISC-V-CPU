package ram

import spinal.core._

class vio_0 extends BlackBox {
	val io = new Bundle {
		val clk = in Bool()


		val probe_out0 = out Bool()
		val probe_out1 = out UInt (8 bits)
		val probe_out2 = out UInt (16 bits)
		val probe_in0 = in UInt (16 bits)
	}
	noIoPrefix()
}
