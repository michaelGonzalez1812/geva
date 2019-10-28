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
module LUT_aux #(parameter N = 8)
		(input logic [N-1:0] Vec1,
		 output logic [N-1:0] lut_vec);

	    always @* begin
            case (Vec1) 
				8'b1: lut_vec = 8'b11001;
				8'b10: lut_vec = 8'b11011111;
				8'b11: lut_vec = 8'b10111110;
				8'b100: lut_vec = 8'b10001110;
				8'b101: lut_vec = 8'b11001000;
				8'b110: lut_vec = 8'b111100;
				8'b111: lut_vec = 8'b10100100;
				8'b1000: lut_vec = 8'b10010010;
				8'b1001: lut_vec = 8'b10101010;
				8'b1010: lut_vec = 8'b1000001;
				8'b1011: lut_vec = 8'b110000;
				8'b1100: lut_vec = 8'b1010011;
				8'b1101: lut_vec = 8'b0;
				8'b1110: lut_vec = 8'b1011110;
				8'b1111: lut_vec = 8'b1100101;
				8'b10000: lut_vec = 8'b1011101;
				8'b10001: lut_vec = 8'b11101000;
				8'b10010: lut_vec = 8'b11110110;
				8'b10011: lut_vec = 8'b1000000;
				8'b10100: lut_vec = 8'b101011;
				8'b10101: lut_vec = 8'b101010;
				8'b10110: lut_vec = 8'b10010110;
				8'b10111: lut_vec = 8'b1001011;
				8'b11000: lut_vec = 8'b11100101;
				8'b11001: lut_vec = 8'b1;
				8'b11010: lut_vec = 8'b10100101;
				8'b11011: lut_vec = 8'b111001;
				8'b11100: lut_vec = 8'b11010001;
				8'b11101: lut_vec = 8'b10010101;
				8'b11110: lut_vec = 8'b11111011;
				8'b11111: lut_vec = 8'b10110110;
				8'b100000: lut_vec = 8'b11000001;
				8'b100001: lut_vec = 8'b110001;
				8'b100010: lut_vec = 8'b10100110;
				8'b100011: lut_vec = 8'b10010000;
				8'b100100: lut_vec = 8'b11111111;
				8'b100101: lut_vec = 8'b11101101;
				8'b100110: lut_vec = 8'b1101000;
				8'b100111: lut_vec = 8'b1110010;
				8'b101000: lut_vec = 8'b10001011;
				8'b101001: lut_vec = 8'b11100110;
				8'b101010: lut_vec = 8'b10101;
				8'b101011: lut_vec = 8'b10100;
				8'b101100: lut_vec = 8'b10001101;
				8'b101101: lut_vec = 8'b1100110;
				8'b101110: lut_vec = 8'b11111110;
				8'b101111: lut_vec = 8'b11100011;
				8'b110000: lut_vec = 8'b1011;
				8'b110001: lut_vec = 8'b100001;
				8'b110010: lut_vec = 8'b1001010;
				8'b110011: lut_vec = 8'b110100;
				8'b110100: lut_vec = 8'b110011;
				8'b110101: lut_vec = 8'b11101110;
				8'b110110: lut_vec = 8'b10011100;
				8'b110111: lut_vec = 8'b10001001;
				8'b111000: lut_vec = 8'b11101011;
				8'b111001: lut_vec = 8'b11011;
				8'b111010: lut_vec = 8'b10111001;
				8'b111011: lut_vec = 8'b1011001;
				8'b111100: lut_vec = 8'b110;
				8'b111101: lut_vec = 8'b1111100;
				8'b111110: lut_vec = 8'b10111101;
				8'b111111: lut_vec = 8'b10100011;
				8'b1000000: lut_vec = 8'b10011;
				8'b1000001: lut_vec = 8'b1010;
				8'b1000010: lut_vec = 8'b11001100;
				8'b1000011: lut_vec = 8'b10100010;
				8'b1000100: lut_vec = 8'b10000000;
				8'b1000101: lut_vec = 8'b11111001;
				8'b1000110: lut_vec = 8'b10000010;
				8'b1000111: lut_vec = 8'b10010011;
				8'b1001000: lut_vec = 8'b10101110;
				8'b1001001: lut_vec = 8'b11001101;
				8'b1001010: lut_vec = 8'b110010;
				8'b1001011: lut_vec = 8'b10111;
				8'b1001100: lut_vec = 8'b10001000;
				8'b1001101: lut_vec = 8'b10100111;
				8'b1001110: lut_vec = 8'b11001010;
				8'b1001111: lut_vec = 8'b11111100;
				8'b1010000: lut_vec = 8'b10111000;
				8'b1010001: lut_vec = 8'b11011001;
				8'b1010010: lut_vec = 8'b10011011;
				8'b1010011: lut_vec = 8'b1100;
				8'b1010100: lut_vec = 8'b10000101;
				8'b1010101: lut_vec = 8'b11000110;
				8'b1010110: lut_vec = 8'b1110100;
				8'b1010111: lut_vec = 8'b1011000;
				8'b1011000: lut_vec = 8'b1010111;
				8'b1011001: lut_vec = 8'b111011;
				8'b1011010: lut_vec = 8'b10000011;
				8'b1011011: lut_vec = 8'b10011111;
				8'b1011100: lut_vec = 8'b10001010;
				8'b1011101: lut_vec = 8'b10000;
				8'b1011110: lut_vec = 8'b1110;
				8'b1011111: lut_vec = 8'b10111011;
				8'b1100000: lut_vec = 8'b10010001;
				8'b1100001: lut_vec = 8'b11101010;
				8'b1100010: lut_vec = 8'b1111011;
				8'b1100011: lut_vec = 8'b11111000;
				8'b1100100: lut_vec = 8'b11001001;
				8'b1100101: lut_vec = 8'b1111;
				8'b1100110: lut_vec = 8'b101101;
				8'b1100111: lut_vec = 8'b10111100;
				8'b1101000: lut_vec = 8'b100110;
				8'b1101001: lut_vec = 8'b1110000;
				8'b1101010: lut_vec = 8'b10101001;
				8'b1101011: lut_vec = 8'b10011110;
				8'b1101100: lut_vec = 8'b10001100;
				8'b1101101: lut_vec = 8'b1110110;
				8'b1101110: lut_vec = 8'b10100000;
				8'b1101111: lut_vec = 8'b11111101;
				8'b1110000: lut_vec = 8'b1101001;
				8'b1110001: lut_vec = 8'b11110000;
				8'b1110010: lut_vec = 8'b100111;
				8'b1110011: lut_vec = 8'b10101101;
				8'b1110100: lut_vec = 8'b1010110;
				8'b1110101: lut_vec = 8'b10000110;
				8'b1110110: lut_vec = 8'b1101101;
				8'b1110111: lut_vec = 8'b10011101;
				8'b1111000: lut_vec = 8'b10000100;
				8'b1111001: lut_vec = 8'b11011011;
				8'b1111010: lut_vec = 8'b10110101;
				8'b1111011: lut_vec = 8'b1100010;
				8'b1111100: lut_vec = 8'b111101;
				8'b1111101: lut_vec = 8'b11100111;
				8'b1111110: lut_vec = 8'b10000111;
				8'b1111111: lut_vec = 8'b10000001;
				8'b10000000: lut_vec = 8'b1000100;
				8'b10000001: lut_vec = 8'b1111111;
				8'b10000010: lut_vec = 8'b1000110;
				8'b10000011: lut_vec = 8'b1011010;
				8'b10000100: lut_vec = 8'b1111000;
				8'b10000101: lut_vec = 8'b1010100;
				8'b10000110: lut_vec = 8'b1110101;
				8'b10000111: lut_vec = 8'b1111110;
				8'b10001000: lut_vec = 8'b1001100;
				8'b10001001: lut_vec = 8'b110111;
				8'b10001010: lut_vec = 8'b1011100;
				8'b10001011: lut_vec = 8'b101000;
				8'b10001100: lut_vec = 8'b1101100;
				8'b10001101: lut_vec = 8'b101100;
				8'b10001110: lut_vec = 8'b100;
				8'b10001111: lut_vec = 8'b10100001;
				8'b10010000: lut_vec = 8'b100011;
				8'b10010001: lut_vec = 8'b1100000;
				8'b10010010: lut_vec = 8'b1000;
				8'b10010011: lut_vec = 8'b1000111;
				8'b10010100: lut_vec = 8'b10101111;
				8'b10010101: lut_vec = 8'b11101;
				8'b10010110: lut_vec = 8'b10110;
				8'b10010111: lut_vec = 8'b10101000;
				8'b10011000: lut_vec = 8'b10101011;
				8'b10011001: lut_vec = 8'b10101100;
				8'b10011010: lut_vec = 8'b10110011;
				8'b10011011: lut_vec = 8'b1010010;
				8'b10011100: lut_vec = 8'b110110;
				8'b10011101: lut_vec = 8'b1110111;
				8'b10011110: lut_vec = 8'b1101011;
				8'b10011111: lut_vec = 8'b1011011;
				8'b10100000: lut_vec = 8'b1101110;
				8'b10100001: lut_vec = 8'b10001111;
				8'b10100010: lut_vec = 8'b1000011;
				8'b10100011: lut_vec = 8'b111111;
				8'b10100100: lut_vec = 8'b111;
				8'b10100101: lut_vec = 8'b11010;
				8'b10100110: lut_vec = 8'b100010;
				8'b10100111: lut_vec = 8'b1001101;
				8'b10101000: lut_vec = 8'b10010111;
				8'b10101001: lut_vec = 8'b1101010;
				8'b10101010: lut_vec = 8'b1001;
				8'b10101011: lut_vec = 8'b10011000;
				8'b10101100: lut_vec = 8'b10011001;
				8'b10101101: lut_vec = 8'b1110011;
				8'b10101110: lut_vec = 8'b1001000;
				8'b10101111: lut_vec = 8'b10010100;
				8'b10110000: lut_vec = 8'b10110111;
				8'b10110001: lut_vec = 8'b11110111;
				8'b10110010: lut_vec = 8'b10110100;
				8'b10110011: lut_vec = 8'b10011010;
				8'b10110100: lut_vec = 8'b10110010;
				8'b10110101: lut_vec = 8'b1111010;
				8'b10110110: lut_vec = 8'b11111;
				8'b10110111: lut_vec = 8'b10110000;
				8'b10111000: lut_vec = 8'b1010000;
				8'b10111001: lut_vec = 8'b111010;
				8'b10111010: lut_vec = 8'b11110101;
				8'b10111011: lut_vec = 8'b1011111;
				8'b10111100: lut_vec = 8'b1100111;
				8'b10111101: lut_vec = 8'b111110;
				8'b10111110: lut_vec = 8'b11;
				8'b10111111: lut_vec = 8'b11110001;
				8'b11000000: lut_vec = 8'b11010010;
				8'b11000001: lut_vec = 8'b100000;
				8'b11000010: lut_vec = 8'b11011000;
				8'b11000011: lut_vec = 8'b11010101;
				8'b11000100: lut_vec = 8'b11110100;
				8'b11000101: lut_vec = 8'b11011110;
				8'b11000110: lut_vec = 8'b1010101;
				8'b11000111: lut_vec = 8'b11110010;
				8'b11001000: lut_vec = 8'b101;
				8'b11001001: lut_vec = 8'b1100100;
				8'b11001010: lut_vec = 8'b1001110;
				8'b11001011: lut_vec = 8'b11110011;
				8'b11001100: lut_vec = 8'b1000010;
				8'b11001101: lut_vec = 8'b1001001;
				8'b11001110: lut_vec = 8'b11101111;
				8'b11001111: lut_vec = 8'b11101100;
				8'b11010000: lut_vec = 8'b11101001;
				8'b11010001: lut_vec = 8'b11100;
				8'b11010010: lut_vec = 8'b11000000;
				8'b11010011: lut_vec = 8'b11100010;
				8'b11010100: lut_vec = 8'b11100100;
				8'b11010101: lut_vec = 8'b11000011;
				8'b11010110: lut_vec = 8'b11100001;
				8'b11010111: lut_vec = 8'b11100000;
				8'b11011000: lut_vec = 8'b11000010;
				8'b11011001: lut_vec = 8'b1010001;
				8'b11011010: lut_vec = 8'b11111010;
				8'b11011011: lut_vec = 8'b1111001;
				8'b11011100: lut_vec = 8'b11011101;
				8'b11011101: lut_vec = 8'b11011100;
				8'b11011110: lut_vec = 8'b11000101;
				8'b11011111: lut_vec = 8'b10;
				8'b11100000: lut_vec = 8'b11010111;
				8'b11100001: lut_vec = 8'b11010110;
				8'b11100010: lut_vec = 8'b11010011;
				8'b11100011: lut_vec = 8'b101111;
				8'b11100100: lut_vec = 8'b11010100;
				8'b11100101: lut_vec = 8'b11000;
				8'b11100110: lut_vec = 8'b101001;
				8'b11100111: lut_vec = 8'b1111101;
				8'b11101000: lut_vec = 8'b10001;
				8'b11101001: lut_vec = 8'b11010000;
				8'b11101010: lut_vec = 8'b1100001;
				8'b11101011: lut_vec = 8'b111000;
				8'b11101100: lut_vec = 8'b11001111;
				8'b11101101: lut_vec = 8'b100101;
				8'b11101110: lut_vec = 8'b110101;
				8'b11101111: lut_vec = 8'b11001110;
				8'b11110000: lut_vec = 8'b1110001;
				8'b11110001: lut_vec = 8'b10111111;
				8'b11110010: lut_vec = 8'b11000111;
				8'b11110011: lut_vec = 8'b11001011;
				8'b11110100: lut_vec = 8'b11000100;
				8'b11110101: lut_vec = 8'b10111010;
				8'b11110110: lut_vec = 8'b10010;
				8'b11110111: lut_vec = 8'b10110001;
				8'b11111000: lut_vec = 8'b1100011;
				8'b11111001: lut_vec = 8'b1000101;
				8'b11111010: lut_vec = 8'b11011010;
				8'b11111011: lut_vec = 8'b11110;
				8'b11111100: lut_vec = 8'b1001111;
				8'b11111101: lut_vec = 8'b1101111;
				8'b11111110: lut_vec = 8'b101110;
				8'b11111111: lut_vec = 8'b100100;
                default: lut_vec = 32'b1101; //default 0 
            endcase 
        end

endmodule 