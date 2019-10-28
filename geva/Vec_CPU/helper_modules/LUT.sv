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
	
	Entradas: - Vectro con 16 valores a convertir
				
	Restricciones:
				- vector de 128 bits

   Salidas: - Vector con todos los resutlados de la conversión conccatenados

            
		Arquitectura de Computadores II 2019
				Prof. Jefferson Gonzales
***********************************************
**/
module LUT #(parameter N = 8)
		(input logic [N-1:0] Vec1,
		 output logic [N-1:0] lut_vec);

        //valores temprales 
        logic [7:0] tmp1;
	    logic [7:0] tmp2;
	    logic [7:0] tmp3;
	    logic [7:0] tmp4;
	    logic [7:0] tmp5;
	    logic [7:0] tmp6;
	    logic [7:0] tmp7;
	    logic [7:0] tmp8;

        //dividimos el vector en partes
	    logic [7:0] pixel1;
		logic [7:0] pixel3;
	    logic [7:0] pixel2;
		logic [7:0] pixel4;
		logic [7:0] pixel5;
		logic [7:0] pixel6;
		logic [7:0] pixel7;
		logic [7:0] pixel8;

		assign pixel1 = Vec1 [7:0];
		assign pixel2 = Vec1 [15:8];
		assign pixel3 = Vec1 [23:16];
		assign pixel4 = Vec1 [31:24];
		assign pixel5 = Vec1 [39:32];
		assign pixel6 = Vec1 [47:40];
		assign pixel7 = Vec1 [55:48];
		assign pixel8 = Vec1 [63:56];

		//obtenemos el valor del lut para cada datos
        LUT_aux lut1(pixel1,tmp1);
        LUT_aux lut2(pixel2,tmp2);
        LUT_aux lut3(pixel3,tmp3);
        LUT_aux lut4(pixel4,tmp4);
        LUT_aux lut5(pixel5,tmp5);
        LUT_aux lut6(pixel6,tmp6);
        LUT_aux lut7(pixel7,tmp7);
        LUT_aux lut8(pixel8,tmp8);

		//unimos la salida
        assign lut_vec = {tmp8,tmp7,tmp6,tmp5,tmp4,tmp3,tmp2,tmp1};

endmodule 
