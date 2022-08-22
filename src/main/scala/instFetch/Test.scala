package instFetch

import spinal.core._
import spinal.lib._
import _root_.tools._

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


	val IF = new Instruction_Fetcher
	IF.io.rst := rst
	IF.io.clk := clk


	val vio = new vio_0
	vio.io.clk := io.clk_50M
	IF.io.enable := vio.io.probe_out0
	IF.io.branch := vio.io.probe_out1
	IF.io.jump := vio.io.probe_out2
	IF.io.branchAddr := vio.io.probe_out3
	IF.io.jumpAddr := vio.io.probe_out4
	/*
	IF.io.enable := True
	IF.io.branch := False
	IF.io.jump := False
	IF.io.branchAddr := 0
	IF.io.jumpAddr := 0
	*/


	val ila_0 = new ila
	ila_0.io.clk := io.clk_50M
	ila_0.io.probe0 := clk
	ila_0.io.probe1 := IF.io.pc_debug
	ila_0.io.probe2 := IF.io.next_pc_debug
	ila_0.io.probe3 := IF.io.pc_reg_debug
	ila_0.io.probe4 := IF.io.instruction


}

object TestVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Test"
		).generate(new Test)
	}
}