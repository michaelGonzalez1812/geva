`timescale 1 ns / 1 ns
module vga_mem_test_sim ();

    logic clk, reset, image_select;
    logic pixlclk, hsync, vsync, sync_b, blank_b;
    logic [7:0] R, G, B;

    vga_mem_test DUT (
        .clk ( clk ),
        .reset ( reset ),
        .image_select ( image_select ),
        .pixlclk ( pixlclk ),
        .hsync ( hsync ),
        .vsync ( vsync ),
        .sync_b ( sync_b ),
        .blank_b ( blank_b ),
        .R ( R ),
        .G ( G ),
        .B ( B )
    );

    always begin
		#1
		clk = ~clk;
	end


	initial begin
        clk = 1'b0;
        reset = 0'b0;
        image_select = 0'b1;
        
        #3
        reset = 0'b1;

        #2
        reset = 0'b0;

        #6000;
    end
endmodule