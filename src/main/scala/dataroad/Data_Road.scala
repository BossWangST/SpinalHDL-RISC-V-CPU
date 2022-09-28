package dataroad

import alu.ALU
import control.Controller
import instFetch.Instruction_Fetcher
import reg.Register_file
import rom.Rom
import spinal.core._
import spinal.lib._

class Data_Road extends Component {
	val io = new Bundle {
		val clk = in Bool()
		val rst = in Bool()
	}
	noIoPrefix()

	val inst_fetcher = new Instruction_Fetcher // get instructions
	val controller = new Controller // get control signals from instruction
	val reg = new Register_file // 64-bit registers
	val alu = new ALU
	val rom = new Rom

	// signals for IF
	val IF_enable = Bool()
	val branchAddr = UInt(12 bits)
	val jumpAddr = UInt(20 bits)

	when(True) {
		IF_enable := True
	} otherwise {
		IF_enable := False
	}

	inst_fetcher.io.clk := io.clk
	inst_fetcher.io.rst := io.rst
	val branch = Bool()
	inst_fetcher.io.branch := branch
	inst_fetcher.io.jump := controller.io.jump | controller.io.jalr
	inst_fetcher.io.enable := IF_enable
	inst_fetcher.io.branchAddr := branchAddr
	inst_fetcher.io.jumpAddr := jumpAddr

	// signals for Controller
	controller.io.instruction := inst_fetcher.io.instruction

	// signals for register file
	reg.io.readReg1 := controller.io.rs1
	reg.io.readReg2 := controller.io.rs2
	reg.io.writeReg := controller.io.rd
	reg.io.RegWrite := controller.io.regWriteEnable

	// signals for ALU
	val data1 = reg.io.readData1
	val immediate = UInt(64 bits)
	when(controller.io.store =/= 0) {
		immediate := controller.io.instruction(31 downto 25) @@ controller.io.instruction(11 downto 7)
	} otherwise {
		immediate := U(controller.io.instruction(31), 52 bits) @@ controller.io.instruction(31 downto 20)
	}

	when(controller.io.branch =/= 0) {
		branchAddr := controller.io.instruction(31).asUInt @@ controller.io.instruction(7).asUInt @@ controller.io.instruction(30 downto 25) @@ controller.io.instruction(11 downto 8)
	}
	when(controller.io.jump) {
		jumpAddr := controller.io.instruction(31).asUInt @@ controller.io.instruction(19 downto 12) @@ controller.io.instruction(20).asUInt @@ controller.io.instruction(30 downto 21)
	} elsewhen (controller.io.jalr) {
		jumpAddr := alu.io.aluResult
	}
	val data2 = controller.io.aluSrc ? reg.io.readData2 | immediate

	when(controller.io.strip32) {
		data1 := U"32'b0" @@ data1(31 downto 0)
		data2 := U"32'b0" @@ data2(31 downto 0)
	}

	alu.io.aluOp := controller.io.aluCtr
	alu.io.data1 := data1
	alu.io.data2 := data2

	switch(controller.io.branch) {
		default {
			branch := False
		}
		is(1) {
			branch := alu.io.Zero ? True | False
		}
		is(2) {
			branch := alu.io.Zero ? False | True
		}
		is(3) {
			branch := (alu.io.aluResult < 0) ? True | False
		}
		is(4) {
			branch := (alu.io.aluResult >= 0) ? True | False
		}
	}

	val upper_immediate = inst_fetcher.io.instruction(31 downto 12) @@ U"12'b0"

	val write_data = UInt(64 bits)
	switch(controller.io.exRes) {
		is(0) {
			write_data := alu.io.aluResult.asUInt
		}
		is(1) {
			write_data := inst_fetcher.io.pc_debug + U"4"
		}
		is(2) {
			write_data := upper_immediate
		}
		is(3) {
			write_data := upper_immediate + inst_fetcher.io.pc_debug
		}
	}

	reg.io.writeData := (controller.io.load === 0) ? write_data |
		(controller.io.load === 1)

	// signals for ROM
	rom.io.clk := io.clk
	rom.io.rst := io.rst
	rom.io.addr := alu.io.aluResult
	rom.io.data
}

object Data_RoadVerilog {
	def main(args: Array[String]): Unit = {
		SpinalConfig(
			mode = Verilog,
			targetDirectory = "verilog/Data_Road"
		).generate(new Data_Road)
	}
}