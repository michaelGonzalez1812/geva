/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				caja negra para los tres 
                bloques de memoria
       
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

module data_mem_bb (
    input logic clk,
    input logic [31:0] cpu_addr,
    input logic [31:0] vga_addr,
    input logic cpu_wren,
    input  logic [31:0] data_cpu,
	output logic [7:0]  out_data_vga,
    output logic [31:0] out_data_cpu);

    enum bit [1:0] {
        BLOCK0 = 2'd0, 
        BLOCK1 = 2'd1, 
        BLOCK2 = 2'd2
    } BLOCKS; 

    logic [7:0]  out_data_vga_block0;
    logic [7:0]  out_data_vga_block1;
    logic [7:0]  out_data_vga_block2;

    logic [31:0] out_data_cpu_block0;
    logic [31:0] out_data_cpu_block1;
    logic [31:0] out_data_cpu_block2;

    addrs_deco_ctrl_sig addrs_deco_ctrl;

    data_mem_addr_deco addr_deco(
        .cpu_addr ( cpu_addr ),
        .vga_addr ( vga_addr ),
        .cpu_wren ( cpu_wren ),
        .addrs_deco_ctrl ( addrs_deco_ctrl )
    );

    data_mem data_mem_block0 (
        .address_a ( addrs_deco_ctrl.addr_vga ),
        .address_b ( addrs_deco_ctrl.addr_cpu ),
        .clock ( clk ),
        .data_a ( 8'b0 ),
        .data_b ( data_cpu ),
        .wren_a ( 1'b0 ),
        .wren_b ( addrs_deco_ctrl.wren_cpu_block0 ),
        .q_a ( out_data_vga_block0 ),
        .q_b ( out_data_cpu_block0 )
        );

    data_mem data_mem_block1 (
        .address_a ( addrs_deco_ctrl.addr_vga ),
        .address_b ( addrs_deco_ctrl.addr_cpu ),
        .clock ( clk ),
        .data_a ( 8'b0 ),
        .data_b ( data_cpu ),
        .wren_a ( 1'b0 ),
        .wren_b ( addrs_deco_ctrl.wren_cpu_block1 ),
        .q_a ( out_data_vga_block1 ),
        .q_b ( out_data_cpu_block1 )
        );

    data_mem_keys data_mem_block2 (
        .address_a ( addrs_deco_ctrl.addr_vga ),
        .address_b ( addrs_deco_ctrl.addr_cpu ),
        .clock ( clk ),
        .data_a ( 8'b0 ),
        .data_b ( data_cpu ),
        .wren_a ( 1'b0 ),
        .wren_b ( addrs_deco_ctrl.wren_cpu_block2 ),
        .q_a ( out_data_vga_block2 ),
        .q_b ( out_data_cpu_block2 )
        );

    assign out_data_vga = 
        (addrs_deco_ctrl.out_vga_mtx_sel == BLOCK0) ? out_data_vga_block0 :
        (addrs_deco_ctrl.out_vga_mtx_sel == BLOCK1) ? out_data_vga_block1 :
                                                      out_data_vga_block2;

    assign out_data_cpu = 
        (addrs_deco_ctrl.out_cpu_mtx_sel == BLOCK0) ? out_data_cpu_block0 :
        (addrs_deco_ctrl.out_cpu_mtx_sel == BLOCK1) ? out_data_cpu_block1 :
                                                      out_data_cpu_block2;
endmodule