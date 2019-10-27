

import cpu_inst_types::*;

module vec_cpu (
    input logic clk, reset,
    input logic [15:0] instruction,
    input logic [31:0] mem_data,

    output logic wr_enable,
    output logic [31:0] pc, cpu_addr, cpu_data
);
    


//################################ control ################################
logic alu_rdy, mem_rdy;
logic [4:0] dec_opcode = inst_a.opcode, ex_opcode;
logic pc_en, ex_en, cl_alu_st, cl_mem_st, esc_wr_en, vec_wr_en, cl_shift_op;
logic [1:0] cl_mem_op, cl_esc_wr, cl_vec_wr;
logic [3:0] cl_alu_op;

logic ex_alu_st, ex_mem_st, ex_shift_op;
logic [1:0] ex_mem_op, ex_esc_wr, ex_vec_wr;
logic [3:0] ex_alu_op;


Processor_Control cpu_control( alu_rdy, mem_rdy, dec_opcode, ex_opcode, pc_en, ex_en, cl_alu_st, cl_mem_st, esc_wr_en, vec_wr_en, cl_shift_op, cl_mem_op, cl_esc_wr, cl_vec_wr, cl_alu_op);

Reg_Control ex_control(clk, ex_en, cl_alu_st, cl_mem_st, cl_shift_op, cl_mem_op, cl_esc_wr, cl_vec_wr,
    cl_alu_op, ex_alu_st, ex_mem_st, ex_shift_op, ex_mem_op, ex_esc_wr, ex_vec_wr, ex_alu_op);



//################################ Fetch ################################
logic [31:0] pc_plus4, inner_pc;
logic [15:0] inner_instruction;
logic cout;


Reg_PC pcReg(clk, pc_en, reset, pc_plus4, inner_pc);
adder_n #(32) pc_adder(inner_pc, 32'b1, 0, pc_plus4, cout);

assign pc = inner_pc;

Reg_N intruction_register(clk, 1, instruction, inner_instruction);

A_instruction inst_a = inner_instruction;
B_instruction inst_b = inner_instruction;
C_instruction inst_c = inner_instruction;
D_instruction inst_d = inner_instruction;




//######################## Decode ################################


//register files
logic [2:0] rd_addr1, rd_addr2, wb_register_addr; // coming from execute register
logic [31:0] wr_data_cccccccc; // to be conected in mux
logic [31:0] reg1_data, reg2_data;
logic [64:0] vec1_data, vec2_data;

Regfile_N #(32) escalarRegs(clk, we, inst_a.r1_addr, inst_a.r2_addr, wb_register_addr, wr_data_cccccccc, reg1_data, reg2_data);

Regfile_N #(64) vecRegs(clk, we, inst_a.r1_addr, inst_a.r1_addr, wb_register_addr, wr_data_cccccccc, vec1_data, vec2_data);


//######################## Execute ################################

logic [31:0] ex_reg1_data, ex_reg2_data;
logic [7:0] ex_immediate;
logic [64:0] ex_vec1_data, ex_vec2_data;

Reg_Execute ex_register(clk, ex_en, inst_a.opcode, reg1_data, reg2_data, inst_d.immediate,
    vec1_data, vec2_data, inst_a.wb_addr, ex_opcode, ex_reg1_data, ex_reg2_data,  ex_immediate,
    ex_vec1_data, ex_vec2_data, wb_register_addr);

alu_module seg_pipe_alu(
    clk, reset, ex_alu_st, 
    ex_alu_op,
    ex_reg2_data,
    ex_vec1_data, ex_vec2_data,

    output logic alu_rdy,
    output logic [63:0] vec_result
);

endmodule