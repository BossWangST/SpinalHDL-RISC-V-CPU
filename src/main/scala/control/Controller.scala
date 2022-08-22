package control

import spinal.core._
import spinal.lib._

class Controller extends Component {
	val io = new Bundle {
		val instruction=in UInt(32 bits)

	}
	noIoPrefix()

}

object ControllerVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Controller"
		).generate(new Controller)
	}
}