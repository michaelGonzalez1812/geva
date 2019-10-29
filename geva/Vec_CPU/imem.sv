module imem(input logic [31:0] a,
				output logic [15:0] ir);
				
logic [15:0] RAM[40961:0];

initial
	// $readmemh("memfile.dat", RAM);
	$readmemb("C:/Users/JorgeAgueroZamora/Documents/TEC/Arqui2/Proyecto2/geva/testCodeH.dat", RAM);
assign ir = RAM[a[31:2]]; // word aligned

endmodule