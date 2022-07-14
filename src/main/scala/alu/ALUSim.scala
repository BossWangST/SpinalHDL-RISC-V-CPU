package alu

import spinal.core.sim._

object ALUSim {
	def main(args: Array[String]): Unit = {
		SimConfig.withWave.compile(new ALU).doSim { dut =>
			dut.clockDomain.forkStimulus(10)
			SimTimeout(10000)
			dut.clockDomain.waitSampling(10)
			var data1 = 10
			var data2 = 20
			var aluOp = 0
			var aluResult = 0
			//ADD SUB
			dut.io.data1 #= data1
			dut.io.data2 #= data2
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			dut.clockDomain.waitRisingEdge()
			aluOp = 8
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			//SLT SLTU
			dut.clockDomain.waitRisingEdge()
			aluOp = 1
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			dut.clockDomain.waitRisingEdge()
			data1 = -10
			aluOp = 2
			dut.io.data1 #= data1
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			//AND OR XOR
			dut.clockDomain.waitRisingEdge()
			data1 = 1
			aluOp = 3
			dut.io.data1 #= data1
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			dut.clockDomain.waitRisingEdge()
			data1 = 65536
			aluOp = 4
			dut.io.data1 #= data1
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			//SLL SRL SRA
			dut.clockDomain.waitRisingEdge()
			data1 = 128
			data2 = 2
			aluOp = 6
			dut.io.data1 #= data1
			dut.io.data2 #= data2
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			dut.clockDomain.waitRisingEdge()
			data1 = -2
			aluOp = 7
			dut.io.data1 #= data1
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			dut.clockDomain.waitRisingEdge()
			aluOp = 9
			dut.io.aluOp #= aluOp
			aluResult = dut.io.aluResult.toInt

			simSuccess()
		}
	}
}
