module n_and #(parameter N=8)
				(input  logic [N-1:0] A,       
             output logic Y);

	

logic [N-1:0] x;

	genvar i;
	
	generate
		assign x[0] = A[0];
		for (i=1; i<N; i=i+1) begin: forloop
			assign x[i] = A[i] & x[i-1];
		end
	endgenerate
	
	assign Y = x[N-1];
	
	
endmodule