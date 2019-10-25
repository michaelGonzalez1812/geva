//~ `New testbench
// `timescale  1ns / 1ps

module tb_Reg_Execute;

// Reg_Execute Parameters
parameter PERIOD = 2;

// Reg_Execute Inputs
logic clk = 0;
logic en = 0;
logic [4:0] d_opcode = 0;
logic [31:0] d_reg1_data = 0;
logic [31:0] d_reg2_data = 0;
logic [7:0] d_immediate = 0;
logic [127:0] d_vec1_data = 0;
logic [127:0] d_vec2_data = 0;
logic [2:0] d_wb_register = 0;

// Reg_Execute Outputs
logic [4:0] q_opcode;
logic [31:0] q_reg1_data, q_reg2_data;

logic [7:0] q_immediate;
logic [127:0] q_vec1_data, q_vec2_data;

logic [2:0] q_wb_register;

initial
    begin
        forever #(PERIOD / 2) clk = ~clk;
end

    Reg_Execute u_Reg_Execute(
        clk,
        en,
        d_opcode,
        d_reg1_data,
        d_reg2_data,
        d_immediate,
        d_vec1_data,
        d_vec2_data,
        d_wb_register,

        q_opcode,
        q_reg1_data,
        q_reg2_data,
        q_immediate,
        q_vec1_data,
        q_vec2_data,
        q_wb_register);

initial
    begin
        en=1;
        d_opcode=5'd8;
        d_reg1_data=32'd5;
        d_reg2_data=32'd15;
        d_immediate=8'd8;
        d_vec1_data=128'd32;
        d_vec2_data=128'd90;
        d_wb_register=3'd3;
        #10

        normal_check: assert (q_opcode === 5'd8 && q_reg1_data === 32'd5 && q_reg2_data === 32'd15 && q_immediate === 8'd8 && q_vec1_data === 128'd32 && q_vec2_data === 128'd90 && q_wb_register === 3'd3) 
            else $error("Assertion normal check failed!");


        en=0;
        d_opcode=5'd12;
        d_reg1_data=32'd7;
        d_reg2_data=32'd19;
        d_immediate=8'd3;
        d_vec1_data=128'd39;
        d_vec2_data=128'd45;
        d_wb_register=3'd2;
        #10

        disabled_check: assert (q_opcode === 5'd8 && q_reg1_data === 32'd5 && q_reg2_data === 32'd15 && q_immediate === 8'd8 && q_vec1_data === 128'd32 && q_vec2_data === 128'd90 && q_wb_register === 3'd3) 
            else $error("Assertion disabled_check failed!");

        // $finish;
end

    endmodule