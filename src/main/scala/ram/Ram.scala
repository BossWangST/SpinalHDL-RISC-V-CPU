package ram

import spinal.core._
import spinal.lib._

class Ram extends Component {
	val io = new Bundle {
		val clk = in Bool()
		val rst = in Bool()
		val addr = in UInt (16 bits)
		val data_out = out UInt (64 bits)
		val data_in = in UInt (64 bits)
		val write_en = in Bool()
	}
	noIoPrefix()

	val ram = new RamIP
	ram.io.clka := io.clk
	ram.io.addra := io.addr
	ram.io.dina := io.data_in
	ram.io.wea := io.write_en
	when(io.rst) {
		io.data_out := 0
	} otherwise {
		io.data_out := ram.io.douta
	}
}

object RamVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Ram"
		).generate(new Ram)
	}
}