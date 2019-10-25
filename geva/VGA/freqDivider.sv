module freqDivider (input logic clk, reset,							 
							 output logic pixclk);
						
		
			always_ff @(posedge clk, posedge reset)
					if (reset) pixclk=0;
					else pixclk=~pixclk;
					
		//n_counter #(2) div(clk, reset, pixclk);
		
endmodule
