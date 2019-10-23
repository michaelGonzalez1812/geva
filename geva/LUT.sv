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
module LUT #(parameter N = 128)
		(input logic [N-1:0] Vec1
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
	    logic [7:0] tmp9;
	    logic [7:0] tmp10;
	    logic [7:0] tmp11;
	    logic [7:0] tmp12;
	    logic [7:0] tmp13;
	    logic [7:0] tmp14;
	    logic [7:0] tmp15;
	    logic [7:0] tmp16;

        //dividimos el vector en partes
	    logic [7:0] pixel1 = [7:0]Vec1;
	    logic [7:0] pixel2 = [15:8]Vec2;
	    logic [7:0] pixel3 = [23:16]Vec3;
	    logic [7:0] pixel4 = [31:24]Vec4;
	    logic [7:0] pixel5 = [39:31]Vec5;
	    logic [7:0] pixel6 = [47:40]Vec6;
	    logic [7:0] pixel7 = [55:48]Vec7;
	    logic [7:0] pixel8 = [63:56]Vec8;
	    logic [7:0] pixel9 = [71:64]Vec9;
	    logic [7:0] pixel10 = [79:72]Vec10;
	    logic [7:0] pixel11 = [87:80]Vec11;
	    logic [7:0] pixel12 = [95:88]Vec12;
	    logic [7:0] pixel13 = [103:96]Vec13;
	    logic [7:0] pixel14 = [111:104]Vec14;
	    logic [7:0] pixel15 = [119:112]Vec15;
	    logic [7:0] pixel16 = [127:120]Vec16;



        LUT_aux lut1(pixel1,tmp1);
        LUT_aux lut2(pixel2,tmp2);
        LUT_aux lut3(pixel3,tmp3);
        LUT_aux lut4(pixel4,tmp4);
        LUT_aux lut5(pixel5,tmp5);
        LUT_aux lut6(pixel6,tmp6);
        LUT_aux lut7(pixel7,tmp7);
        LUT_aux lut8(pixel8,tmp8);
        LUT_aux lut9(pixel9,tmp9);
        LUT_aux lut10(pixel10,tmp10);
        LUT_aux lut11(pixel11,tmp11);
        LUT_aux lut12(pixel12,tmp12);
        LUT_aux lut13(pixel13,tmp13);
        LUT_aux lut14(pixel14,tmp14);
        LUT_aux lut15(pixel15,tmp15);
        LUT_aux lut16(pixel16,tmp16);

        assing lut_vec = {tmp16,tmp15,tmp14,tmp13,tmp12,tmp11,tmp10,tmp9,tmp8,tmp7,tmp6,tmp5,tmp4,tmp3,tmp2,tmp1};

endmodule 
