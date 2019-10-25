module LUT_tb();
    logic clk;
    logic [127:0] Vec1;
    logic [127:0] lut_vec; 
    logic [16:0] contador;

    LUT DUT( Vec1,
                lut_vec);
 
    initial begin
		// ADD
        clk=1'b0;
		contador = 16'b0;

        //Vec1 = 10101100 01010000 11101110 01010100 10101111 11111100 10011101 10000001 10011110 10001101 10000000 00000111 11100011 10101010 10001111 10111100;
        //result 10011001 10111000 00110101 10000101 10010100 01001111 01110111 01111111 01101011 00101100 01000100 10100100 00101111 00001001 10100001 01100111
        Vec1 = 128'b10101100010100001110111001010100101011111111110010011101100000011001111010001101100000000000011111100011101010101000111110111100;
    
        #2;
	end
	
	always begin
		#1
		clk=~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 3)
			$stop;
	end

endmodule