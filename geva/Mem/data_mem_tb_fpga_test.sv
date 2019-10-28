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

`timescale 1 ns / 1 ns


module data_mem_tb_fpga_test ();
    logic clk;
    logic wren_a;
    logic [7:0] q_a;
    int contador;
	 

	 
    data_mem_tb_fpga DUT(
        clk,
        wren_a,
        q_a);

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
        wren_a = 1'b0;
    end
endmodule
