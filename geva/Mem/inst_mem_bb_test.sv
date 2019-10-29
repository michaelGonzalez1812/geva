/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				caja negra para los tres 
                bloques de memoria de instrucciones
       
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

module inst_mem_bb_test ();
    
    logic [31:0] address;
    logic clk;
    logic [15:0] q;

    inst_mem_bb DUT (
        .address ( address ),
        .clock ( clk ),
        .q ( q )
    );

    always begin
		#1
		clk = ~clk;
	end

    initial begin
        clk = 0;
        address = 32'd2;
        
        #5
        address = 32'd65538;

        #16
        $stop;
    end
endmodule