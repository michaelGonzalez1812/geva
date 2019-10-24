module Reg_N #(
    WIDTH = 8
)(
    input logic clk, en,
    input logic [WIDTH-1:0] d_data,

    output logic [WIDTH-1:0] q_data
);
    
always_ff @(posedge clk)
    if (en) 
        q_data <= d_data;
    
endmodule