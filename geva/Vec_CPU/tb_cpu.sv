//~ `New testbench
`timescale  1ns / 1ps

module tb_cpu;   

// vec_cpu Parameters
parameter PERIOD  = 1;


// vec_cpu Inputs
logic clk                            = 0 ;
logic reset                          = 1;
logic [15:0] instruction             ;
logic [31:0] mem_data;

// vec_cpu Outputs
logic wr_enable                      ;
logic [31:0] pc, cpu_addr, cpu_data;
logic [7:0]  out_data_vga;

always
	begin
	clk <= 1; # 1; clk <= 0; # 1;
end


imem inst_mem(pc,
            instruction);
            
data_mem_bb data_mem(
    clk,
    cpu_addr,
    0,
    wr_enable,
    cpu_data,
	out_data_vga,
    mem_data);


vec_cpu  u_vec_cpu (
    .clk                 (  clk                  ),
    .reset                     ( reset                      ),
    .instruction  ( instruction   ),
    .mem_data     ( mem_data      ),

    .wr_enable           (wr_enable            ),
    .pc           (pc            ),
    .cpu_addr                  ( cpu_addr                   ),
    .cpu_data                  ( cpu_data                   )
);

initial
begin

    #10;
    reset=0;#10;
    #100;
    // $stop;

    // $finish;
end

endmodule