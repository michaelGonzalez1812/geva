/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				memory addr decoder
       
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

module data_mem_addr_deco (
    input logic [31:0] cpu_addr,
    input logic [31:0] vga_addr,
    input logic cpu_wren,
    output addrs_deco_ctrl_sig addrs_deco_ctrl);

    enum bit [1:0] {
        BLOCK0 = 2'd0, 
        BLOCK1 = 2'd1, 
        BLOCK2 = 2'd2
    } BLOCKS; 

    logic [31:0] vga_addr_decoded;
    logic [31:0] cpu_addr_decoded;


    assign vga_addr_decoded = 
        (vga_addr > 32'd131071) ? (vga_addr - 32'd131072) :
        (vga_addr > 32'd65535)  ? (vga_addr - 32'd65536)  : vga_addr;

    assign addrs_deco_ctrl.addr_vga = vga_addr_decoded[15:0];

    assign cpu_addr_decoded = 
        (cpu_addr > 32'd32767) ? (cpu_addr - 32'd32768) :
        (cpu_addr > 32'd16383) ? (cpu_addr - 32'd16384) : cpu_addr;

    assign addrs_deco_ctrl.addr_cpu = cpu_addr_decoded[13:0];

    assign addrs_deco_ctrl.out_vga_mtx_sel = 
        (vga_addr > 32'd131071) ? BLOCK2 :
        (vga_addr > 32'd65535)  ? BLOCK1 : BLOCK0;
    
    assign addrs_deco_ctrl.out_cpu_mtx_sel = 
        (cpu_addr > 32'd32767) ? BLOCK2 :
        (cpu_addr > 32'd16383) ? BLOCK1 : BLOCK0;

    assign addrs_deco_ctrl.wren_cpu_block0 = 
        (cpu_wren == 1'b1 && addrs_deco_ctrl.out_cpu_mtx_sel == BLOCK0) ? 1'b1 : 1'b0;

    assign addrs_deco_ctrl.wren_cpu_block1 = 
        (cpu_wren == 1'b1 && addrs_deco_ctrl.out_cpu_mtx_sel == BLOCK1) ? 1'b1 : 1'b0;
    
    assign addrs_deco_ctrl.wren_cpu_block2 = 
        (cpu_wren == 1'b1 && addrs_deco_ctrl.out_cpu_mtx_sel == BLOCK2) ? 1'b1 : 1'b0;
endmodule