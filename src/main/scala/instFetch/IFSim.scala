package instFetch

import spinal.core.sim._

object IFSim {
	def main(args: Array[String]): Unit = {
		SimConfig.withWave.compile(new Instruction_Fetcher).doSim { dut =>
			dut.clockDomain.forkStimulus(10)
			SimTimeout(10000)
			dut.clockDomain.waitSampling(10)

			dut.io.rst#=false
			dut.io.branch#=false
			dut.io.jump#=false
			dut.io.enable#=true
			dut.io.jumpAddr#=0
			dut.io.branchAddr#=0

			for(i<-1 to 20){
				dut.clockDomain.waitRisingEdge()
			}
			simSuccess()
		}
	}
}
