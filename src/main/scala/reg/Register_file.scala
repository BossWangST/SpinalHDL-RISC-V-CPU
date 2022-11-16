package reg

import spinal.core._
import spinal.lib._


class Register_file extends Component {
	val io = new Bundle {
		val clk = in Bool()
		val rst = in Bool()

		val RegWrite = in Bool() // Enable Signal

		val readReg1 = in UInt (5 bits)
		val readReg2 = in UInt (5 bits)
		val writeReg = in UInt (5 bits)

		val writeData = in UInt (64 bits)
		val readData1 = out UInt (64 bits)
		val readData2 = out UInt (64 bits)
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

		//Define 32 general registers
		val Regs = Vec(Reg(UInt(64 bits)) init (0), 32)
		//Read Data
		io.readData1 := Regs(io.readReg1)
		io.readData2 := Regs(io.readReg2)
		//Write Data
		when(io.RegWrite) {
			//In fact, here is a trigger. So if you want to pause at anytime, just add "when(~pause signal){do sth..}otherwise{pause..}
			Regs(io.writeReg) := io.writeData
		}
	}
}

object Register_fileVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Register_file"
		).generate(new Register_file)
	}
}
