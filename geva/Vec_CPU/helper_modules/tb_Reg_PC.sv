//~ `New testbench
// `timescale  1ps

module tb_Reg_PC;

// Reg_PC Parameters
parameter PERIOD = 2;

// Reg_PC Inputs
logic clk = 0;
logic en = 0;
logic rst = 0;
logic [31:0] d_PC = 0;

// Reg_PC Outputs
logic [31:0] q_PC;

initial
    begin
        forever #(PERIOD / 2) clk = ~clk;
end

    Reg_PC u_Reg_PC(
        clk,
        en,
        rst,
        d_PC,

        q_PC);

initial
    begin

        rst=1; en =1; #10

        reset_test: assert (q_PC === 0)
            else $error("Assertion reset_test failed!");

        rst=0; d_PC= 32'b1;#10

        nomal_test: assert (q_PC === 32'b1)
            else $error("Assertion nomal_test failed!");

         rst=0; en=0; d_PC= 32'b0 ;#10

        disabled_test: assert (q_PC === 32'b1)
            else $error("Assertion disabled_test failed!");
        
        // $finish;
end

    endmodule