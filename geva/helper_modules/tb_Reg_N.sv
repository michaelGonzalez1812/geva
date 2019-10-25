//~ `New testbench
// `timescale  1ps

module tb_Reg_N;

// Reg_PC Parameters
parameter PERIOD = 2;

// Reg_PC Inputs
logic clk = 0;
logic en = 0;

logic [31:0] d_data = 0;

// Reg_PC Outputs
logic [31:0] q_data;

initial
    begin
        forever #(PERIOD / 2) clk = ~clk;
end

    Reg_N u_Reg_N(
        clk,
        en,
    
        d_data,

        q_data);

initial
    begin

        en =1;d_data= 32'b1; #10

        normal_test: assert (q_data === 32'b1)
            else $error("Assertion normal_test failed!");

        d_data= 32'd11;#10

        disabled_test: assert (q_data === 32'b1)
            else $error("Assertion disabled_test failed!");
        
        // $finish;
end

    endmodule