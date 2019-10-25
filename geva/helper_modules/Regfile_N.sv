module Regfile_N #(parameter WIDTH = 32)
                    (input logic clk,
					input logic we,
					input logic [3:0] rd_addr1, rd_addr2, wr_addr,
					input logic [WIDTH-1:0] wr_data,
					output logic [WIDTH-1:0] reg1_data, reg2_data);
					
logic [WIDTH-1:0] rf[7:0];

// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 15 reads PC + 8 instead
always_ff @(posedge clk)
	
	if (we) begin //Si el write eneable está activo, trate de escribir
		
		 rf[wr_addr] <= wr_data; //Escriba si el registro es diferente a la posición cero.

	end
	
assign reg1_data = rf[rd_addr1]; //asignar el valor de la dirección a rd1
assign reg2_data = rf[rd_addr2]; //asignar el valor de la dirección a rd1


endmodule