/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				prueba para unidad de 
                memoria de datos
       
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

`timescale 1 ns / 1 ns

module data_mem_unit_test ();

    //input
    logic clk;
    logic mem_start;
    logic [1:0] mem_op;
	logic [31:0] base_addr;
	logic [31:0] data_in_esc;
	logic [63:0] data_in_vec;
    //output
	logic [31:0] addr;
    logic [31:0] data_to_mem;
    logic mem_rdy;
	logic wr_en;
    logic [31:0] data_out_esc;
	logic [63:0] data_out_vec;

    logic [7:0] out_data_vga;
    logic [31:0] out_data_cpu;


	enum bit [1:0] { 
		LD_VEC = 2'b00,
		LD_ESC = 2'b01,
		ST_VEC = 2'b10,
		ST_ESC = 2'b11
	} MEM_OP;

    data_mem_unit DUT (
        .clk ( clk ),
        .mem_start( mem_start),
        .mem_op ( mem_op ),
        .base_addr ( base_addr ),
        .mem_data_read ( out_data_cpu ),
        .data_in_esc ( data_in_esc ),
        .data_in_vec ( data_in_vec ),
        .addr ( addr ),
        .data_to_mem ( data_to_mem ),
        .mem_rdy ( mem_rdy ),
        .wr_en ( wr_en ),
        .data_out_esc ( data_out_esc ),
        .data_out_vec ( data_out_vec )
    );

    data_mem_bb	data_mem (
        .clk ( clk ),
        .cpu_addr ( addr ),
        .vga_addr ( 32'b0 ),
        .cpu_wren ( wr_en ),
        .data_cpu ( data_to_mem ),
        .out_data_vga ( out_data_vga ),
        .out_data_cpu ( out_data_cpu )
    );

    always begin
		#1
		clk = ~clk;
	end

    initial begin
        clk = 0;
        mem_start = 0;
        base_addr = 0;
        data_in_esc = 0;

        #3
        mem_op = ST_VEC;
        data_in_vec = 64'h11111111ffffffff;

        #2
        mem_start = 1;

        #2
        mem_start = 0;

        #6
        mem_op = LD_VEC;
        mem_start = 1;

        #2
        mem_start = 0;

        #2
        base_addr = 1;
        mem_op = LD_VEC;
        
        #2
        base_addr = 1;
        mem_op = ST_ESC;
        data_in_esc = 32'h2222222222222222;

        #16
        $stop;
    end


endmodule