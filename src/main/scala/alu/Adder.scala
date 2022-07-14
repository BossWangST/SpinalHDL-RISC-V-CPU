package alu

import spinal.core._
import spinal.lib._

class Adder extends Component {
	val io = new Bundle {
		val data1 = in UInt (64 bits)
		val data2 = in UInt (64 bits)
		val carryIn = in Bool()
		val carryOut = out Bool()
		val overflow = out Bool()
		val sign = out Bool()
		val zero = out Bool()
		val adderResult = out UInt (64 bits)
	}
	noIoPrefix()

	val tempResult = UInt(65 bits) //one more bit for carry out

	//CAUTION: Here we need to use +^ as add with carry
	tempResult := io.data1 +^ io.data2 + io.carryIn.asUInt

	when(tempResult === 0) {
		io.zero := True
	} otherwise {
		io.zero := False
	}

	// Only when data1 and data2 are same sign while tempResult has a reversed 'sign bit', overflow happens
	io.overflow := (io.data1.msb & io.data2.msb & ~tempResult(63)) | (~io.data1.msb & ~io.data2.msb & tempResult(63))

	io.sign := tempResult(63)

	io.carryOut := tempResult.msb

	io.adderResult := tempResult(63 downto 0)
}

object AdderVerilog {
	def main(args: Array[String]): Unit = {
		SpinalVerilog(new Adder)
	}
}