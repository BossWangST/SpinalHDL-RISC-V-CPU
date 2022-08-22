package rom

import tools.PLL
import spinal.core._
import spinal.lib._

class Rom extends Component {
	val io = new Bundle {
		val clk = in Bool()
		val rst = in Bool()
		val addr = in UInt (64 bits)
		val data = out UInt (32 bits)
	}
	noIoPrefix()

	val clkCtrl = new Area {

		val coreClockDomain = ClockDomain.internal(
			name = "core",
			frequency = FixedFrequency(25 MHz)
		)

		coreClockDomain.clock := io.clk
		coreClockDomain.reset := io.rst
	}

	val coreArea = new ClockingArea(clkCtrl.coreClockDomain) {
		val rom = new RomIP
		rom.io.clka := ClockDomain.current.clock
		rom.io.addra := io.addr
		when(ClockDomain.current.reset) {
			io.data := 0
		} otherwise {
			io.data := rom.io.douta
		}
	}

}

object RomVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Rom"
		).generate(new Rom)
	}
}