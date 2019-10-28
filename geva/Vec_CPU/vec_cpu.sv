

import cpu_inst_types::*;

module vec_cpu (
    input logic clk, reset,
    input logic [15:0] instruction,
    input logic [31:0] mem_data,

    output logic wr_enable,
    output logic [31:0] pc, cpu_addr, cpu_data
);
    


logic [31:0] ex_reg1_data, ex_reg2_data;
logic [7:0] ex_immediate;
logic [63:0] ex_vec1_data, ex_vec2_data, alu_vec_result, lut_vec_result;
logic [31:0] mem_data_out_esc;
logic [63:0] mem_data_out_vec;
logic [31:0] adder_esc_result;
logic [31:0] shifter_esc_result;
logic [31:0] pc_plus4, inner_pc;
logic [15:0] inner_instruction;

A_instruction inst_a;
// assign inst_a = inner_instruction;
B_instruction inst_b; 
// assign inst_b = inner_instruction;
C_instruction inst_c;
// assign inst_c = inner_instruction;
D_instruction inst_d;
// assign inst_d = inner_instruction;

always_comb begin
    if(reset)begin
        inst_a <= 0;
        inst_b <= 0;
        inst_c <= 0;
        inst_d <= 0;
    end
    else begin
        inst_a <= inner_instruction;
        inst_b <= inner_instruction;
        inst_c <= inner_instruction;
        inst_d <= inner_instruction;
    end
end

//################################ control ################################
logic alu_rdy, mem_rdy;
logic [4:0] dec_opcode, ex_opcode;
assign dec_opcode = inst_a.opcode;
logic pc_en, ex_en, cl_alu_st, cl_mem_st, esc_wr_en, vec_wr_en, cl_shift_op;
logic [1:0] cl_mem_op, cl_esc_wr, cl_vec_wr;
logic [3:0] cl_alu_op;

logic ex_alu_st, ex_mem_st, ex_shift_op;
logic [1:0] ex_mem_op, ex_esc_wr, ex_vec_wr;
logic [3:0] ex_alu_op;


Processor_Control cpu_control( alu_rdy, mem_rdy, dec_opcode, ex_opcode, pc_en, ex_en, cl_alu_st, cl_mem_st, esc_wr_en, vec_wr_en, cl_shift_op, cl_mem_op, cl_esc_wr, cl_vec_wr, cl_alu_op);

Reg_Control ex_control(clk, ex_en, reset, cl_alu_st, cl_mem_st, cl_shift_op, cl_mem_op, cl_esc_wr, cl_vec_wr,
    cl_alu_op, ex_alu_st, ex_mem_st, ex_shift_op, ex_mem_op, ex_esc_wr, ex_vec_wr, ex_alu_op);



//################################ Fetch ################################

logic cout;


Reg_PC pcReg(clk, pc_en, reset, pc_plus4, inner_pc);
adder_n #(32) pc_adder(inner_pc, 32'd4, 1'b0, pc_plus4, cout);

assign pc = inner_pc;

Reg_N #(16) instruction_register(clk, 1'b1, reset, instruction, inner_instruction);






//######################## Decode ################################


//register files
logic [2:0] rd_addr1, rd_addr2, wb_register_addr; // coming from execute register
logic [31:0] wr_data_esc; // to be conected in mux
logic [31:0] reg1_data, reg2_data;
logic [63:0] vec1_data, vec2_data, wr_data_vec;

Regfile_N #(32) escalarRegs(clk, esc_wr_en, inst_a.r1_addr, inst_a.r2_addr, wb_register_addr, wr_data_esc, reg1_data, reg2_data);

Regfile_N #(64) vecRegs(clk, vec_wr_en, inst_a.r1_addr, inst_a.r1_addr, wb_register_addr, wr_data_vec, vec1_data, vec2_data);

assign wr_data_esc = ex_esc_wr == 0 ? {24'b0,ex_immediate} : ex_esc_wr == 1 ? mem_data_out_esc : ex_esc_wr == 2 ?  shifter_esc_result : adder_esc_result;

assign wr_data_vec = ex_vec_wr == 0 ? mem_data_out_vec : ex_vec_wr == 1 ? alu_vec_result: lut_vec_result ;

//######################## Execute ################################

Reg_Execute ex_register(clk, ex_en, reset, inst_a.opcode, reg1_data, reg2_data, inst_d.immediate,
    vec1_data, vec2_data, inst_a.wb_addr, ex_opcode, ex_reg1_data, ex_reg2_data,  ex_immediate,
    ex_vec1_data, ex_vec2_data, wb_register_addr);

alu_module seg_pipe_alu(clk, reset, ex_alu_st, ex_alu_op, ex_reg2_data[7:0], ex_vec1_data, ex_vec2_data, alu_rdy,
    alu_vec_result);


LUT lut_vec(ex_vec2_data, lut_vec_result);

data_mem_unit data_module(clk, ex_mem_st, reset, ex_mem_op, ex_reg1_data, mem_data, ex_reg2_data, ex_vec2_data,
	cpu_addr, cpu_data, mem_rdy, wr_enable, mem_data_out_esc, mem_data_out_vec);
    

shifter_module shift_esc ( ex_reg1_data, ex_immediate[4:0], ex_shift_op, shifter_esc_result);


logic esc_adder_cout;
adder_n #(32) adder_esc	(ex_reg1_data, {27'b0, ex_immediate[4:0]}, 1'b0, adder_esc_result, esc_adder_cout);

endmodule