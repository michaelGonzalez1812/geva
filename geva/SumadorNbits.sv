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
				- sumador de n bits, por defecto 32 

   Salidas: - Resultado de la suma de A y B 
			- Acarreo de la suma

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
***********************************************
**/
module sumadorNbits #(parameter N = 32)
		(input logic [N-1:0] A,
		 input logic [N-1:0] B,
		 input logic Cin,
		 output logic Cout,
		 output logic [N-1:0] Q);

	    logic [N:0] carrys;
		 assign carrys[0] = Cin;
		 genvar i;

		 generate

			for(i=0;i<N;i=i+1)begin:sumador_completo
				sumador1bit sumai(A[i],B[i],carrys[i],Q[i],carrys[i+1]);
			end

		endgenerate

		assign Cout = carrys[N];

endmodule 
