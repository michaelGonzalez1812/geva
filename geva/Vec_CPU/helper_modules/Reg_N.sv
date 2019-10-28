module Reg_N # (parameter WIDTH = 8)
    (
    input logic clk, en, reset,
    input logic [WIDTH-1:0] d_data,
    output logic [WIDTH-1:0] q_data
);
    
always_ff @(posedge clk)
if (reset) begin
    q_data <= 0;
end
else if (en) 
        q_data <= d_data;
    
endmodule