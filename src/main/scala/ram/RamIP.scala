package ram

import spinal.core._
import spinal.lib._

class RamIP extends BlackBox {
	val io = new Bundle {
		val addra = in UInt (16 bits)
		val clka = in Bool()
		val dina = in UInt (64 bits)
		val douta = out UInt (64 bits)
		val wea = in Bool()
	}
	noIoPrefix()
}

object RamIPVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/RamIP"
		).generate(new RamIP)
	}
}