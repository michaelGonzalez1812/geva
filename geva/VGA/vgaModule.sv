module vgaModule(
    input logic clk, reset, image_select,
    input logic [7:0] video_data,
output logic pixlclk, hsync, vsync, sync_b, blank_b,
output logic [7:0] R, G, B,
output logic [31:0] video_address
);

logic inner_pixclk;
logic [9:0] hcnt, vcnt;

//all channels show the same color to have greyscale
assign {R,G,B} = {video_data,video_data,video_data};

//frequency divider
freqDivider fdiv(clk, reset, inner_pixclk);

//VGA Controller to generate VGA signals
vgaController vgaCont(inner_pixclk, reset,
hsync, vsync, sync_b, blank_b,
hcnt, vcnt);

vgaAddressDecoder vga_addr_dec (image_select, hcnt, vcnt, video_address );


assign pixlclk = inner_pixclk;

    
endmodule