/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				Sumador de un bit
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero Rojas
				 Victor Montero
				 Jorge
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas: - Valor a convertir
				
	Restricciones:
				- valor de conversión de manera directa entre 0-255 

   Salidas: - Resultado de la conversión

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
***********************************************
**/
module LUT #(parameter N = 8)
		(input logic [N-1:0] Vec1
		 output logic [N-1:0] lut_vec);

	    always @* begin
            case (Vec1) 
                32'b1: value = 32'b00111111010101110110101010100100;
                default: value = 32'b0; //default 0 
            endcase 
        end

endmodule 
