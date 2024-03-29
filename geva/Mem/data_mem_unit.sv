/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero Rojas
				 Victor Montero
				 Jorge
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas: - Valor a convertir
				
	Restricciones:

   Salidas: - Resultado de la conversión

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
************************************************/

import interfaces_def_pkg::*;

module data_mem_unit (
	input logic clk,
    input logic mem_start,
	input logic reset,
    input logic [1:0] mem_op,
	input logic [31:0] base_addr,
	input logic [31:0] mem_data_read, //from ram
	input logic [31:0] data_in_esc,
	input logic [63:0] data_in_vec,
	output logic [31:0] addr,
	output logic [31:0] data_to_mem,
    output logic mem_rdy,
	output logic wr_en,
    output logic [31:0] data_out_esc,
	output logic [63:0] data_out_vec);

	mem_unit_ctl_flags ctl_flags;

	enum bit [1:0] { 
		LD_VEC = 2'b10,
		LD_ESC = 2'b11,
		ST_VEC = 2'b0,
		ST_ESC = 2'b1
	} MEM_OP;

	logic in_wr_en;
	data_mem_unit_vec vec_unit(
		.clk ( clk ),
		.reset ( reset ),
		.mem_start( mem_start ),
		.cpu_addr ( base_addr ),
		.mem_data_read ( mem_data_read ),
		.vec_data_in ( data_in_vec ),
		.wr_en ( wr_en ),
		.ctl_flags ( ctl_flags ),
		.vec_data_out ( data_out_vec ),
		.mem_ready ( mem_rdy ),
		.in_wr_en( in_wr_en)

	);
	
	assign wr_en = (( mem_op == ST_VEC  || mem_op == ST_ESC ) && in_wr_en == 1'b1 ) ? 1'b1 : 1'b0;
	assign addr = ( mem_op == LD_ESC || mem_op == ST_ESC ) ? base_addr : ctl_flags.addr;
	assign data_out_esc = mem_data_read;
	assign data_to_mem = ( mem_op == ST_VEC ) ? ctl_flags.p_data : data_in_esc;
endmodule