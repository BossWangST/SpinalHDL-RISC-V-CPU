package alu

import spinal.core._
import spinal.lib._

class Shifter extends Component {
	val io = new Bundle {
		val data = in UInt (64 bits)
		val shamt = in UInt (5 bits)
		val shiftCtr = in UInt (2 bits)
		val shiftResult = out UInt (64 bits)
	}
	noIoPrefix()

	/*
	shiftCtr =
		00 left shift
		01 arithmetical right shift
		10 logical right shift
	 */

	val tempShift = UInt(64 bits)
	//trick: use right shift to get left shift
	tempShift := (io.shiftCtr === 0) ? io.data.reversed | io.data
	tempShift := tempShift |>> io.shamt

	val leftShiftResult = UInt(64 bits)
	leftShiftResult := tempShift.reversed

	val arithRightShiftResult = UInt(64 bits)
	val sraMask = UInt(64 bits)
	sraMask := ~(U"64'hffff_ffff_ffff_ffff" |>> io.shamt)
	arithRightShiftResult := tempShift | (sraMask & U((63 downto 0) -> io.data.msb))

	val logicRightShiftResult = tempShift

	io.shiftResult := io.shiftCtr.mux(
		0 -> leftShiftResult,
		1 -> arithRightShiftResult,
		2 -> logicRightShiftResult
	)
}

object ShifterVerilog {
	def main(args: Array[String]): Unit = {
		SpinalVerilog(new Shifter)
	}
}