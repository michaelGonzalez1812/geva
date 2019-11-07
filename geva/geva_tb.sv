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


module geva_tb ();
    logic clk, reset, image_select, alg_select;
    logic pixlclk, hsync, vsync, sync_b, blank_b;
    logic [7:0] R, G, B;
	 
    int contador;
    geva DUT(
        clk, reset, image_select, alg_select,
        pixlclk, hsync, vsync, sync_b, blank_b,
        R, G, B);

    always begin
		#1
		clk = ~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 2000)
			$stop;
	end

    initial begin
        clk = 0;
        reset = 0;
        image_select = 0;
        alg_select = 0;

        #3
        reset = 1;
        
        #2
        reset = 0;


    end
endmodule
