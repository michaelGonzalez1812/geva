module imem(input logic [31:0] a,
				output logic [15:0] ir);
				
logic [15:0] RAM[67:0];

initial
	// $readmemh("memfile.dat", RAM);
	$readmemb("testCodeH.dat", RAM);
assign ir = RAM[a[31:2]]; // word aligned

endmodule