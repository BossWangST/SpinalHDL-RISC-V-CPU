package rom

import spinal.core._
import spinal.lib._

class RomIP extends BlackBox {
	val io = new Bundle {
		val addra = in UInt (64 bits)
		val clka = in Bool()
		val douta = out UInt (32 bits)
	}
	noIoPrefix()
}

object RomIPVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/RomIP"
		).generate(new RomIP)
	}
}