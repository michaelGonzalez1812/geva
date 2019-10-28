//~ `New testbench
// `timescale  1ns / 1ps

module tb_Reg_Control;

// Reg_Control Parameters
parameter PERIOD = 10;

// Reg_Control Inputs
logic clk = 0;
logic en = 0;
logic reset = 1;
logic d_cl_alu_st = 0;
logic d_cl_mem_st = 0;
logic d_cl_shift_op = 0;
logic [1:0] d_cl_mem_op = 0;
logic [1:0] d_cl_esc_wr = 0;
logic [1:0] d_cl_vec_wr = 0;
logic [3:0] d_cl_alu_op = 0;

// Reg_Control Outputs
logic q_cl_alu_st;
logic q_cl_mem_st;
logic q_cl_shift_op;
logic [1:0] q_cl_mem_op;
logic [1:0] q_cl_esc_wr;
logic [1:0] q_cl_vec_wr;
logic [3:0] q_cl_alu_op;

initial
    begin
        forever #(PERIOD / 2) clk = ~clk;
end

    Reg_Control u_Reg_Control(clk, en, reset,
                              d_cl_alu_st, d_cl_mem_st, d_cl_shift_op,
                              d_cl_mem_op, d_cl_esc_wr, d_cl_vec_wr,
                              d_cl_alu_op,

                              q_cl_alu_st, q_cl_mem_st, q_cl_shift_op,
                              q_cl_mem_op, q_cl_esc_wr, q_cl_vec_wr,
                              q_cl_alu_op);

initial begin

    #5;
    reset = 0;
    en = 1;
    d_cl_alu_st = 1;
    d_cl_mem_st = 1;
    d_cl_shift_op = 0;
    d_cl_mem_op = 2'd2;
    d_cl_esc_wr = 2'd2;
    d_cl_vec_wr = 2'd1;
    d_cl_alu_op = 4'd3;
    #10

    normal_check : assert(q_cl_alu_st === 1 &&q_cl_mem_st === 1 && q_cl_shift_op === 0 && q_cl_mem_op === 2'd2 && q_cl_esc_wr === 2'd2 && q_cl_vec_wr === 2'd1 && q_cl_alu_op === 4'd3) else $error("Assertion normal_check failed!");

    en = 0;
    d_cl_alu_st = 0;
    d_cl_mem_st = 0;
    d_cl_shift_op = 1;
    d_cl_mem_op = 2'd3;
    d_cl_esc_wr = 2'd3;
    d_cl_vec_wr = 2'd0;
    d_cl_alu_op = 4'd4;
    #10
    
    disabled_check : assert(q_cl_alu_st === 1 &&q_cl_mem_st === 1 &&q_cl_shift_op === 0 && q_cl_mem_op === 2'd2 &&q_cl_esc_wr === 2'd2 &&q_cl_vec_wr === 2'd1 && q_cl_alu_op === 4'd3) else $error("Assertion disabled_check failed!");
// $finish;
end

    endmodule