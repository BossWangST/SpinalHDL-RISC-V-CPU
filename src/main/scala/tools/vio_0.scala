package tools

import spinal.core._
import spinal.lib._

class vio_0 extends BlackBox {
	val io = new Bundle {
		val clk = in Bool()


		val probe_out0=out Bool()
		val probe_out1=out Bool()
		val probe_out2=out Bool()
		val probe_out3=out UInt(12 bits)
		val probe_out4=out UInt(20 bits)
	}
	noIoPrefix()
}
