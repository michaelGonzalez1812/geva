module freqDivider_tb();

//timeunit 39ns;

logic [9:0] cnt;
logic vgaclk = 0, reset;

always #1 vgaclk = ~vgaclk;


// instantiate device under test
freqDivider dut(vgaclk, reset, cnt);

initial begin
reset=1; #2 reset=0;

end

endmodule
