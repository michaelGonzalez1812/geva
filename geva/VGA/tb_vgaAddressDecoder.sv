//~ `New testbench
// `timescale  1ms / 1ps

module tb_vgaAddressDecoder;

// vgaAddressDecoder Parameters
parameter PERIOD  = 2;


// vgaAddressDecoder Inputs
logic clk =0;
logic reset =1;
logic image_select                   = 0 ;

logic [9:0] hcnt =0;
logic [9:0] vcnt=0;
// logic hsync, vsync, sync_b, blank_b;
// logic [9:0] hcnt, vcnt;
// logic [7:0] R, G, B;

// logic [7:0] video_data = 1;

// vgaAddressDecoder Outputs
logic [31:0] video_address           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;

 
end

always_ff @(posedge clk) begin
       hcnt++;
    if(hcnt == 10'd600) begin
        hcnt=0;
        vcnt++;
        if (vcnt == 10'd400) vcnt = 0;
    end
end

// vgaModule vgaMod( clk, reset, video_data, hsync, vsync, sync_b, blank_b, hcnt, vcnt, R, G, B);

vgaAddressDecoder u_vgaAddressDecoder(image_select, hcnt, vcnt, video_address);

initial
begin

    #10; reset=0;
   
end

endmodule