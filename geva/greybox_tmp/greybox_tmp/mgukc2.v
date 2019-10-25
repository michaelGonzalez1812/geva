//altsyncram ADDRESS_REG_B="CLOCK0" CBX_SINGLE_OUTPUT_FILE="ON" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_INPUT_B="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_B="BYPASS" INDATA_REG_B="CLOCK0" INTENDED_DEVICE_FAMILY=""Cyclone V"" LPM_TYPE="altsyncram" NUMWORDS_A=65536 NUMWORDS_B=14564 OPERATION_MODE="BIDIR_DUAL_PORT" OUTDATA_ACLR_A="NONE" OUTDATA_ACLR_B="NONE" OUTDATA_REG_A="CLOCK0" OUTDATA_REG_B="CLOCK0" POWER_UP_UNINITIALIZED="FALSE" RAM_BLOCK_TYPE="M10K" READ_DURING_WRITE_MODE_MIXED_PORTS="DONT_CARE" READ_DURING_WRITE_MODE_PORT_A="NEW_DATA_NO_NBE_READ" READ_DURING_WRITE_MODE_PORT_B="NEW_DATA_NO_NBE_READ" WIDTH_A=8 WIDTH_B=36 WIDTH_BYTEENA_A=1 WIDTH_BYTEENA_B=1 WIDTH_ECCSTATUS=3 WIDTHAD_A=16 WIDTHAD_B=14 WRCONTROL_WRADDRESS_REG_B="CLOCK0" address_a address_b clock0 data_a data_b q_a q_b wren_a wren_b
//VERSION_BEGIN 18.1 cbx_mgl 2018:09:12:13:10:36:SJ cbx_stratixii 2018:09:12:13:04:24:SJ cbx_util_mgl 2018:09:12:13:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2018  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details.



//synthesis_resources = altsyncram 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mgukc2
	( 
	address_a,
	address_b,
	clock0,
	data_a,
	data_b,
	q_a,
	q_b,
	wren_a,
	wren_b) /* synthesis synthesis_clearbox=1 */;
	input   [15:0]  address_a;
	input   [13:0]  address_b;
	input   clock0;
	input   [7:0]  data_a;
	input   [35:0]  data_b;
	output   [7:0]  q_a;
	output   [35:0]  q_b;
	input   wren_a;
	input   wren_b;

	wire  [7:0]   wire_mgl_prim1_q_a;
	wire  [35:0]   wire_mgl_prim1_q_b;

	altsyncram   mgl_prim1
	( 
	.address_a(address_a),
	.address_b(address_b),
	.clock0(clock0),
	.data_a(data_a),
	.data_b(data_b),
	.q_a(wire_mgl_prim1_q_a),
	.q_b(wire_mgl_prim1_q_b),
	.wren_a(wren_a),
	.wren_b(wren_b));
	defparam
		mgl_prim1.address_reg_b = "CLOCK0",
		mgl_prim1.clock_enable_input_a = "BYPASS",
		mgl_prim1.clock_enable_input_b = "BYPASS",
		mgl_prim1.clock_enable_output_a = "BYPASS",
		mgl_prim1.clock_enable_output_b = "BYPASS",
		mgl_prim1.indata_reg_b = "CLOCK0",
		mgl_prim1.intended_device_family = ""Cyclone V"",
		mgl_prim1.lpm_type = "altsyncram",
		mgl_prim1.numwords_a = 65536,
		mgl_prim1.numwords_b = 14564,
		mgl_prim1.operation_mode = "BIDIR_DUAL_PORT",
		mgl_prim1.outdata_aclr_a = "NONE",
		mgl_prim1.outdata_aclr_b = "NONE",
		mgl_prim1.outdata_reg_a = "CLOCK0",
		mgl_prim1.outdata_reg_b = "CLOCK0",
		mgl_prim1.power_up_uninitialized = "FALSE",
		mgl_prim1.ram_block_type = "M10K",
		mgl_prim1.read_during_write_mode_mixed_ports = "DONT_CARE",
		mgl_prim1.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		mgl_prim1.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
		mgl_prim1.width_a = 8,
		mgl_prim1.width_b = 36,
		mgl_prim1.width_byteena_a = 1,
		mgl_prim1.width_byteena_b = 1,
		mgl_prim1.width_eccstatus = 3,
		mgl_prim1.widthad_a = 16,
		mgl_prim1.widthad_b = 14,
		mgl_prim1.wrcontrol_wraddress_reg_b = "CLOCK0";
	assign
		q_a = wire_mgl_prim1_q_a,
		q_b = wire_mgl_prim1_q_b;
endmodule //mgukc2
//VALID FILE
