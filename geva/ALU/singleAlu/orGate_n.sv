module orGate_n  #(parameter N=8)
					( input logic [N-1:0] A, B,
					  output logic [N-1:0] Y);

assign Y = A | B;

endmodule