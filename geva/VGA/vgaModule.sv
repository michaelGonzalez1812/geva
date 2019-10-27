module vgaModule(
    input logic clk, reset,
    input logic [7:0] video_data,
output logic hsync, vsync, sync_b, blank_b,
output logic [9:0] hcnt, vcnt,
output logic [7:0] R, G, B
);

logic pixclk;

//all channels show the same color to have greyscale
assign {R,G,B} = {video_data,video_data,video_data};

//frequency divider
freqDivider fdiv(clk, reset, pixclk);

//VGA Controller to generate VGA signals
vgaController vgaCont(pixclk, reset,
hsync, vsync, sync_b, blank_b,
hcnt, vcnt);

    
endmodule