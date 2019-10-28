module mem_capacity (
    input logic clk,
    input logic cpu_wren,
    input logic [31:0] cpu_addr,
    input logic [31:0] vga_addr,
    input logic [31:0] data_cpu,
    input logic [31:0] address,
    output logic [7:0]  out_data_vga,
    output logic [31:0] out_data_cpu,
    output logic [15:0] q);

    //input logic [15:0] q);

    data_mem_bb data_mem (
        .clk ( clk ),
        .cpu_addr ( cpu_addr ),
        .vga_addr ( vga_addr ),
        .cpu_wren ( cpu_wren ),
        .data_cpu ( data_cpu ),
        .out_data_vga ( out_data_vga ),
        .out_data_cpu ( out_data_cpu )
        );

    inst_mem_bb inst_mem (
        .address ( address ),
        .clock ( clk ),
        .q ( q )
    );	 

endmodule