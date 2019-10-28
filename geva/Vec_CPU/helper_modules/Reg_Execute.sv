module Reg_Execute(
    input logic clk, en, reset,
    input logic [4:0] d_opcode,
    input logic [31:0] d_reg1_data, d_reg2_data,
    input logic [7:0] d_immediate,
    input logic [63:0] d_vec1_data, d_vec2_data,
    input logic [2:0] d_wb_register,

    output logic [4:0] q_opcode,
    output logic [31:0] q_reg1_data, q_reg2_data,
    output logic [7:0] q_immediate,
    output logic [63:0] q_vec1_data, q_vec2_data,
    output logic [2:0] q_wb_register
);

always_ff @(posedge clk)
if (reset) begin
    q_opcode <= 5'b10100;
    q_reg1_data <= 32'b0;
    q_reg2_data <= 32'b0;
    q_immediate <= 8'b0;
    q_vec1_data <= 64'b0;
    q_vec2_data <= 64'b0;
    q_wb_register <= 64'b0;
end
else if (en) begin
q_opcode <= d_opcode;

q_reg1_data <= d_reg1_data;
q_reg2_data <= d_reg2_data;

q_immediate <= d_immediate;

q_vec1_data <= d_vec1_data;
q_vec2_data <= d_vec2_data;

q_wb_register <= d_wb_register;

    end



endmodule
