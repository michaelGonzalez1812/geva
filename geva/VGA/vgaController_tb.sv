module vgaController_tb();

//timeunit 39ns;

logic [9:0] hcnt, vcnt;
logic vgaclk=0, reset, hsync, vsync, sync_b, blank_b;

always #1 vgaclk = ~vgaclk;


// instantiate device under test
vgaController dut(vgaclk, reset, hsync, vsync, sync_b, blank_b, hcnt, vcnt);


// apply inputs one at a time
// checking results
initial begin
reset=1; #3 reset=0;

end



endmodule
