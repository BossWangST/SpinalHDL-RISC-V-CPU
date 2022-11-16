package instFetch

import rom.Rom
import spinal.core._
import spinal.lib._

class Instruction_Fetcher extends Component {
	val io = new Bundle {
		val clk = in Bool()
		val rst = in Bool()

		val branch = in Bool()
		val jump = in Bool()
		val enable = in Bool()

		val branchAddr = in UInt (12 bits)
		val jumpAddr = in UInt (20 bits)

		val instruction = out UInt (32 bits)


		val pc_debug = out UInt (64 bits)
		val next_pc_debug = out UInt (64 bits)
		val pc_reg_debug = out UInt (64 bits)
	}
	noIoPrefix()
	val clkCtrl = new Area {

		val coreClockDomain = ClockDomain.internal(
			name = "core",
			frequency = FixedFrequency(100 MHz)
		)

		coreClockDomain.clock := io.clk
		coreClockDomain.reset := io.rst
	}

	val coreArea = new ClockingArea(clkCtrl.coreClockDomain) {

		val pc = UInt(64 bits)
		io.pc_debug := pc

		val pc_add_4 = pc + 4
		val jumpAddr = UInt(64 bits)
		// left shift 1 bit then sign extended
		jumpAddr := pc + U((42 downto 0) -> io.jumpAddr.msb) @@ io.jumpAddr @@ U"0"
		val branchAddr = UInt(64 bits)
		branchAddr := pc + U((50 downto 0) -> io.branchAddr.msb) @@ io.branchAddr @@ U"0"

		val next_pc = io.jump ? jumpAddr | (io.branch ? branchAddr | pc_add_4)
		io.next_pc_debug := next_pc

		val instRom = new Rom
		instRom.io.clk := ClockDomain.current.clock
		instRom.io.rst := ClockDomain.current.reset
		instRom.io.addr := pc(15 downto 0)
		io.instruction := instRom.io.data


//		io.instruction := 0

		//pc := io.enable ? next_pc | pc
		val pc_reg = RegNextWhen(next_pc, io.enable) init (0)
		io.pc_reg_debug := pc_reg
		pc := pc_reg

		when(ClockDomain.current.reset) {
			pc := 0
			next_pc := 0
		}

	}

}

object Instruction_FetcherVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Instruction_Fetcher"
		).addStandardMemBlackboxing(blackboxAll)
			.generate(new Instruction_Fetcher)
	}
}