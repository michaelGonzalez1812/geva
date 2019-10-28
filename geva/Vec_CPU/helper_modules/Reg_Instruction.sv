module Reg_Instruction 
    (
    input logic clk, en, reset,
    input logic [15:0] d_inst,
    output logic [15:0] q_inst
);
    
always_ff @(posedge clk)
if (reset) begin
    q_inst <= 16'hF000;
end
else if (en) 
        q_inst <= d_inst;
    
endmodule