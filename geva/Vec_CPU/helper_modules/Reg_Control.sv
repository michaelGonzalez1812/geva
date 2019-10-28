module Reg_Control (
    input logic clk, en, reset,
    input logic d_cl_alu_st, d_cl_mem_st, d_cl_shift_op,
    input logic [1:0] d_cl_mem_op, d_cl_esc_wr, d_cl_vec_wr,
    input logic [3:0] d_cl_alu_op,

    output logic q_cl_alu_st, q_cl_mem_st, q_cl_shift_op,
    output logic [1:0] q_cl_mem_op, q_cl_esc_wr, q_cl_vec_wr,
    output logic [3:0] q_cl_alu_op
);
    
always_ff @(posedge clk)
if (reset) begin
    q_cl_alu_st <= 0;
    q_cl_mem_st <= 0;
    q_cl_shift_op <= 0;
    q_cl_mem_op <= 0;
    q_cl_esc_wr <= 0;
    q_cl_vec_wr <= 0;
    q_cl_alu_op <= 0;
end
else if (en) begin

q_cl_alu_st <= d_cl_alu_st;
q_cl_mem_st <= d_cl_mem_st;
q_cl_shift_op <= d_cl_shift_op;

q_cl_mem_op <= d_cl_mem_op;
q_cl_esc_wr <= d_cl_esc_wr;
q_cl_vec_wr <= d_cl_vec_wr;

q_cl_alu_op <= d_cl_alu_op;

    end

endmodule