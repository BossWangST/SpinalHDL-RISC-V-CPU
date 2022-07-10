package reg

import spinal.core.sim._

//Register_file's testbench
object Register_fileSim {
	def main(args: Array[String]): Unit = {
		SimConfig.withWave.compile(new Register_file).doSim { dut =>
			//get clock
			dut.clockDomain.forkStimulus(10)
			SimTimeout(10000)
			dut.clockDomain.waitSampling(10)

			for (i <- 1 to 20) {
				//test write
				dut.io.writeReg #= i + 1
				dut.io.writeData #= i + 1
				if (i < 10) {
					dut.io.RegWrite #= true
				} else {
					dut.io.RegWrite #= false
				}

				//test read
				dut.io.readReg1 #= i
				dut.io.readReg2 #= i - 1

				dut.clockDomain.waitRisingEdge()
				if (i == 7) {
					dut.clockDomain.assertReset()
				} else {
					dut.clockDomain.deassertReset()
				}
			}

			simSuccess()
		}
	}

}
