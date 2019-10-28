module alu_module(
    input logic clk, reset, alu_st, 
    input logic [3:0] alu_op,
    input logic [7:0] esc,
    input logic [63:0] vec1, vec2,

    output logic alu_rdy,
    output logic [63:0] vec_result
);

logic out_en1, out_en2, in_sel_a;
logic [1:0] in_sel_b;
logic [3:0] int_alu_op;
logic [3:0] aluFlags1, aluFlags2, aluFlags3, aluFlags4;

logic [7:0] mux_alu1_A, mux_alu1_B, mux_alu2_A, mux_alu2_B, mux_alu3_A, mux_alu3_B, mux_alu4_A, mux_alu4_B;

logic [7:0] reg_alu1_A, reg_alu1_B, reg_alu2_A, reg_alu2_B, reg_alu3_A, reg_alu3_B, reg_alu4_A, reg_alu4_B;

logic [7:0] alu1_out, alu2_out, alu3_out, alu4_out;


// ALU Control
alu_mod_control alu_control(clk, reset, alu_st, alu_op,
            alu_rdy, out_en1, out_en2, in_sel_a, in_sel_b, int_alu_op);

//Muxes
assign mux_alu1_A = in_sel_a ? vec1[39:32] : vec1[7:0];
assign mux_alu1_B= in_sel_b == 0 ? vec2[7:0] : in_sel_b == 1 ? vec2[39:32] : in_sel_b == 2 ? esc : esc; 

assign mux_alu2_A= in_sel_a ? vec1[47:40] : vec1[15:8];
assign mux_alu2_B= in_sel_b == 0 ? vec2[15:8] : in_sel_b == 1 ? vec2[47:40] : in_sel_b == 2 ? esc : esc;

assign mux_alu3_A= in_sel_a ? vec1[55:48] : vec1[23:16];
assign mux_alu3_B= in_sel_b == 0 ? vec2[23:16] : in_sel_b == 1 ? vec2[55:48] : in_sel_b == 2 ? esc : esc;

assign mux_alu4_A= in_sel_a ? vec1[63:56] : vec1[31:24];
assign mux_alu4_B= in_sel_b == 0 ? vec2[31:24] : in_sel_b == 1 ? vec2[63:56] : in_sel_b == 2 ? esc : esc;

//ALUs
alu #(8) alu1(reg_alu1_A, reg_alu1_B, int_alu_op, alu1_out, aluFlags1);
alu #(8) alu2(reg_alu2_A, reg_alu2_B, int_alu_op, alu2_out, aluFlags2);
alu #(8) alu3(reg_alu3_A, reg_alu3_B, int_alu_op, alu3_out, aluFlags3);
alu #(8) alu4(reg_alu4_A, reg_alu4_B, int_alu_op, alu4_out, aluFlags4);

//Input Registers
Reg_N #(8) alu1_A(clk, 1'b1, reset, mux_alu1_A, reg_alu1_A);
Reg_N #(8) alu1_B(clk, 1'b1, reset, mux_alu1_B, reg_alu1_B);

Reg_N #(8) alu2_A(clk, 1'b1, reset, mux_alu2_A, reg_alu2_A);
Reg_N #(8) alu2_B(clk, 1'b1, reset, mux_alu2_B, reg_alu2_B);

Reg_N #(8) alu3_A(clk, 1'b1, reset, mux_alu3_A, reg_alu3_A);
Reg_N #(8) alu3_B(clk, 1'b1, reset, mux_alu3_B, reg_alu3_B);

Reg_N #(8) alu4_A(clk, 1'b1, reset, mux_alu4_A, reg_alu4_A);
Reg_N #(8) alu4_B(clk, 1'b1, reset, mux_alu4_B, reg_alu4_B);

//Output Registers
Reg_N #(8) alu1_0(clk, out_en1, reset, alu1_out, vec_result[7:0]);
Reg_N #(8) alu2_1(clk, out_en1, reset, alu2_out, vec_result[15:8]);
Reg_N #(8) alu3_2(clk, out_en1, reset, alu3_out, vec_result[23:16]);
Reg_N #(8) alu4_3(clk, out_en1, reset, alu4_out, vec_result[31:24]);

Reg_N #(8) alu1_4(clk, out_en2, reset, alu1_out, vec_result[39:32]);
Reg_N #(8) alu2_5(clk, out_en2, reset, alu2_out, vec_result[47:40]);
Reg_N #(8) alu3_6(clk, out_en2, reset, alu3_out, vec_result[55:48]);
Reg_N #(8) alu4_7(clk, out_en2, reset, alu4_out, vec_result[63:56]);
    
endmodule