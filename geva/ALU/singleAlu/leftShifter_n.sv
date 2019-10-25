module leftShifter_n #(parameter N=8)
				(input  logic [N-1:0] B, 
             input  logic [$clog2(N)-1:0]  A, 
             output logic [N-1:0] Y);
				 
				 assign Y = B << A;	 
				 
endmodule