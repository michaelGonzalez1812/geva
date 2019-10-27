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

`timescale 1 ns / 1 ns


module data_mem_bb_test ();

	logic clk;
    logic [31:0] cpu_addr;
    logic [31:0] vga_addr;
    logic cpu_wren;
    logic [31:0] data_cpu;
	logic [7:0]  out_data_vga;
    logic [31:0] out_data_cpu;

    int contador;

    data_mem_bb	DUT (
        .clk ( clk ),
        .cpu_addr ( cpu_addr ),
        .vga_addr ( vga_addr ),
        .cpu_wren ( cpu_wren ),
        .data_cpu ( data_cpu ),
        .out_data_vga ( out_data_vga ),
        .out_data_cpu ( out_data_cpu )
        );

    always begin
		#1
		clk = ~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 15)
			$stop;
	end


    initial begin
        clk = 0;
        cpu_addr = 32'b0;
        vga_addr = 32'b0;
        cpu_wren = 1'b0;
        data_cpu = 32'b0;
    end

    /*******************************
     * Prueba 1
     * Escritura cpu
     * lectura vga
     * bloque 0
     *******************************/
     /*
    initial begin
        #2;
        cpu_wren = 1'b1;
        data_cpu = 32'b1;

        #2;
        cpu_wren = 1'b0;
	end
    */

    /*******************************
     * Prueba 1
     * Escritura cpu
     * lectura vga
     * bloque 1
     *******************************/
     /*
    initial begin
        #2;
        cpu_addr = 32'd16393;
        vga_addr = 32'd65572;
        cpu_wren = 1'b1;
        data_cpu = 32'b10;

        #2;
        cpu_wren = 1'b0;
	end
    */
    
    /*******************************
     * Prueba 1
     * Escritura cpu
     * lectura vga
     * bloque 2
     *******************************/
    initial begin
        #3;
        cpu_addr = 32'd32768;
        vga_addr = 32'd131072;
        cpu_wren = 1'b1;
        data_cpu = 32'b100;

        #2;
        cpu_wren = 1'b0;

        #2;
        vga_addr = 32'd2;

        #2;
        vga_addr = 32'd131072;
	end
endmodule
