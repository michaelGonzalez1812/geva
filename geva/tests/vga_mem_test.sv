module vga_mem_test (
    input logic clk, reset, image_select,
    output logic pixlclk, hsync, vsync, sync_b, blank_b,
    output logic [7:0] R, G, B);

    logic [7:0] video_data;
    logic [31:0] video_address;
    logic [31:0] out_data_cpu;
	 

    vgaModule vga (
        .clk ( clk ),
        .reset ( reset ), 
        .image_select ( image_select ),
        .video_data ( video_data ),
        .pixlclk ( pixlclk ), 
        .hsync ( hsync ), 
        .vsync ( vsync ),
        .sync_b ( sync_b ), 
        .blank_b ( blank_b ),
        .R ( R ), 
        .G ( G ), 
        .B ( B ),
        .video_address ( video_address )
        );

    data_mem_bb data_mem (
        .clk ( clk ),
        .cpu_addr ( 32'b0 ),
        .vga_addr ( video_address ),
        .cpu_wren ( 1'b0 ),
        .data_cpu ( 32'b0 ),
        .out_data_vga ( video_data ),
        .out_data_cpu ( out_data_cpu )
        );  
endmodule
