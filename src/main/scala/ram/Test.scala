package ram

import spinal.core._
import spinal.lib._
import _root_.tools.PLL

class Test extends Component {
	val io = new Bundle {
		val clk_50M = in Bool()
		val rst = in Bool()
	}
	noIoPrefix()

	val pll = new PLL
	pll.io.clkIn := io.clk_50M
	pll.io.reset := ~io.rst
	val clk = pll.io.clkOut
	val rst = ~io.rst

	val ram = new Ram
	ram.io.clk := clk
	ram.io.rst := rst

	val vio = new vio_0
	vio.io.clk := io.clk_50M
	ram.io.write_en := vio.io.probe_out0
	ram.io.addr := vio.io.probe_out1
	ram.io.data_in := vio.io.probe_out2
	vio.io.probe_in0 := ram.io.data_out
}

object TestVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Test"
		).generate(new Test)
	}
}