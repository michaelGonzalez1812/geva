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
	
	Entradas: - Bit A 
              - Bit B
			  - Bit de acarreo
				
	Restricciones:
				- sumador de un bit únicamente 

   Salidas: - Resultado de la suma de A y B 
			- Acarreo de la suma

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
***********************************************
**/

module sumador1bit(
		input  A1bit,
		B1bit,
		Cin1bit,
		output logic Q1bit,
		Cout1bit);

		assign Q1bit = A1bit^B1bit^Cin1bit;
		assign Cout1bit =  (A1bit & B1bit) | (A1bit & Cin1bit) | (B1bit & Cin1bit);
endmodule
		
