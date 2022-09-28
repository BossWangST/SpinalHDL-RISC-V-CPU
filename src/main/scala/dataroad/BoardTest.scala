package dataroad

import spinal.core._
import spinal.lib._
import _root_.tools.PLL

class BoardTest extends Component {
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

}

object BoardTestVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/BoardTest"
		).generate(new BoardTest)
	}
}