module Reg_PC(
    input logic clk, en, rst,
    input logic [31:0] d_PC,

    output logic [31:0] q_PC
);
    
always_ff @(posedge clk, posedge rst)
if (rst) q_PC <= 0;
else  if (en)  q_PC <= d_PC;
    
endmodule