module arithShifter_n #(parameter N=8)
				(input  logic [N-1:0] B, 
             input  logic [$clog2(N)-1:0] A, 
             output logic [N-1:0] Y);

                // logic signed [N-1:0] B_signed = $signed(B);
			 assign Y = $signed(B) >>> A;
			
				 
endmodule