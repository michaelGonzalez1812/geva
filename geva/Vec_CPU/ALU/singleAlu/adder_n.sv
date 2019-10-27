module adder_n #(parameter N=8)
				(input  logic [N-1:0] A, B, 
             input  logic Cin, 
             output logic [N-1:0] Y,
				 output logic Cout);
				 
				 assign {Cout,Y} = A + B + Cin;	 
				 
endmodule