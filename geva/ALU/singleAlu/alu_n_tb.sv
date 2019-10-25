module alu_n_tb();

logic [7:0] A, B, Y;
logic [3:0] ctrl;
logic [3:0] aluflags;

// instantiate device under test
alu #(8) dut(A, B, ctrl, Y, aluflags);
// apply inputs one at a time
// checking results
initial begin
//aluflags = {Negative, Zero, carry, Overflow}
//SUMA ctrl=0
//0 + 0
A = 0; B = 0; ctrl=0; #10;
assert (Y === 0) else $error("0 + 0 = 0 failed");
assert (aluflags[2] === 1) else $error("0+0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("0+0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("0+0 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("0+0 Operation, Carry flag failed");

//2 + 2
A = 2; B = 2; ctrl=0; #10;
assert (Y === 4) else $error("2 + 2 = 4 failed.");
assert (aluflags[2] === 0) else $error("2 + 2 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("2 + 2 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("2 + 2 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("2 + 2 Operation, Carry flag failed");

//127 + 4
A = 'b01111111; B = 'b0100; ctrl=0; #10;
assert (Y === 'b10000011) else $error("7 + 4 =  failed.");
assert (aluflags[2] === 0) else $error("127 + 4 Operation, Zero flag failed");
assert (aluflags[0] === 1) else $error("127 + 4 Operation, Overflow flag failed");
assert (aluflags[3] === 1) else $error("127 + 4 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("127 + 4 Operation, Carry flag failed");

//127 + 0
A = 127; B = 0; ctrl=0; #10;
assert (Y === 127) else $error("127 + 0 = 1 failed.");
assert (aluflags[2] === 0) else $error("127 + 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("127 + 0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("127 + 0 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("127 + 0 Operation, Carry flag failed");



//RESTA ctrl=1
// 2 - 4
A = 2; B = 4; ctrl=1; #10;
assert (Y === ('b11111110)) else $error("2 - 4 = -2 failed.");
assert (aluflags[2] === 0) else $error("2 - 4 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("2 - 4 Operation, Overflow flag failed");
assert (aluflags[3] === 1) else $error("2 - 4 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("2 - 4 Operation, Carry flag failed");

//7 - 4
A = 7; B = 4; ctrl=1; #10;
assert (Y === 3) else $error("7 - 4= 3 failed.");
assert (aluflags[2] === 0) else $error("7 - 4 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("7 - 4 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("7 - 4 Operation, Negative flag failed");
assert (aluflags[1] === 1) else $error("7 - 4 Operation, Carry flag failed");

//5 - 5
A = 'b0101; B = 'b0101; ctrl=1; #10;
assert (Y === 'b0000) else $error("5 - 5 = 0 failed.");
assert (aluflags[2] === 1) else $error("5 - 5 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("5 - 5 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("5 - 5 Operation, Negative flag failed");
assert (aluflags[1] === 1) else $error("5 - 5 Operation, Carry flag failed");


//0 - 0
A = 0; B = 0; ctrl=1; #10;
assert (Y === 0) else $error("0 - 0 = 0 failed.");
assert (aluflags[2] === 1) else $error("0 - 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("0 - 0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("0 - 0 Operation, Negative flag failed");
assert (aluflags[1] === 1) else $error("0 - 0 Operation, Carry flag failed");


//AND ctrl=2
//1 AND 1
A = 1; B = 1; ctrl=2; #10;
assert (Y === 1) else $error("1 AND 1 = 1 failed.");
assert (aluflags[2] === 0) else $error("1 AND 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 AND 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("1 AND 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("1 AND 1 Operation, Carry flag failed");

//4 AND 2
A = 4; B = 2; ctrl=2; #10;
assert (Y === 0) else $error("4 AND 2 = 0 failed.");
assert (aluflags[2] === 1) else $error("4 AND 2 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("4 AND 2 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("4 AND 2 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("4 AND 2 Operation, Carry flag failed");

//5 AND 5
A = 5; B = 5; ctrl=2; #10;
assert (Y === 5) else $error("5 AND 5 = 5 failed.");
assert (aluflags[2] === 0) else $error("5 AND 5 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("5 AND 5 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("5 AND 5 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("5 AND 5 Operation, Carry flag failed");

//7 AND 0
A = 7; B = 0; ctrl=2; #10;
assert (Y === 0) else $error("7 AND 0 = 0 failed.");
assert (aluflags[2] === 1) else $error("7 AND 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("7 AND 05 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("7 AND 0 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("7 AND 0 Operation, Carry flag failed");


//OR ctrl=3
//1 OR 1
A = 1; B = 1; ctrl=3; #10;
assert (Y === 1) else $error("1 OR 1 = 1 failed.");
assert (aluflags[2] === 0) else $error("1 OR 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 OR 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("1 OR 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("1 OR 1 Operation, Carry flag failed");

//4 OR 0
A = 4; B = 0; ctrl=3; #10;
assert (Y === 4) else $error("4 OR 0 = 4 failed.");
assert (aluflags[2] === 0) else $error("4 OR 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("4 OR 0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("4 OR 0 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("4 OR 0 Operation, Carry flag failed");

//0 OR 0
A = 0; B = 0; ctrl=3; #10;
assert (Y === 0) else $error("0 OR 0 = 0 failed.");
assert (aluflags[2] === 1) else $error("0 OR 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("0 OR 0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("0 OR 0 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("0 OR 0 Operation, Carry flag failed");

//3 OR -5
A = 3; B = 'b11111011; ctrl=3; #10;
assert (Y === 'b11111011) else $error("3 OR -5 = -5 failed.");
assert (aluflags[2] === 0) else $error("3 OR -5 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("3 OR -5 Operation, Overflow flag failed");
assert (aluflags[3] === 1) else $error("3 OR -5 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("3 OR -5 Operation, Carry flag failed");

//NOR

//OR ctrl=4
//1 NOR 1
A = 1; B = 1; ctrl=4; #10;
assert (Y === 'b11111110) else $error("1 NOR 1 = 'b11111110 failed.");
assert (aluflags[2] === 0) else $error("1 NOR 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 NOR 1 Operation, Overflow flag failed");
assert (aluflags[3] === 1) else $error("1 NOR 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("1 NOR 1 Operation, Carry flag failed");



//XOR ctrl=5
//1 XOR 1
A = 'b00000001; B = 'b00000001; ctrl=5; #10;
assert (Y === 'b00000000) else $error("1 XOR 1 = 0 failed.");
assert (aluflags[2] === 1) else $error("1 XOR 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 XOR 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("1 XOR 1 Operation, Negative flag failed");
assert (aluflags[1] === 1) else $error("1 XOR 1 Operation, Carry flag failed");

//1 XOR 0
A = 'b00000001; B = 'b00000000; ctrl=5; #10;
assert (Y === 'b00000001) else $error("1 XOR 0 = 1 failed.");
assert (aluflags[2] === 0) else $error("1 XOR 0 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 XOR 0 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("1 XOR 0 Operation, Negative flag failed");
assert (aluflags[1] === 1) else $error("1 XOR 0 Operation, Carry flag failed");

//1 XOR 5
A = 'b00000001; B = 'b00000101; ctrl=5; #10;
assert (Y === 'b00000100) else $error("1 XOR 5 = 4 failed.");
assert (aluflags[2] === 0) else $error("1 XOR 5 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 XOR 5 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("1 XOR 5 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("1 XOR 5 Operation, Carry flag failed");

//1 XOR -5
A = 'b00000001; B = 'b11111011; ctrl=5; #10;
assert (Y === 'b11111010) else $error("1 XOR -5 = -6 failed.");
assert (aluflags[2] === 0) else $error("1 XOR 5 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("1 XOR 5 Operation, Overflow flag failed");
assert (aluflags[3] === 1) else $error("1 XOR 5 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("1 XOR 5 Operation, Carry flag failed");


//Shif left ctrl=6
//Shif left 'b00000001 << 2
A = 2; B = 'b00000001; ctrl=6; #10;
assert (Y === 'b00000100) else $error("'b00000001 << 2 = 'b00000100 failed.");
assert (aluflags[2] === 0) else $error("'b00000001 << 2 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00000001 << 2 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00000001 << 2 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00000001 << 2 Operation, Carry flag failed");

//Shif left 'b00001001 << 1
A = 1; B = 'b00001001; ctrl=6; #10;
assert (Y === 'b00010010) else $error("'b00001001 << 1 = 'b00010010 failed.");
assert (aluflags[2] === 0) else $error("'b00001001 << 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00001001 << 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00001001 << 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00001001 << 1 Operation, Carry flag failed");

//Shif left 'b00000101 << 1
A = 1; B = 'b00000101; ctrl=6; #10;
assert (Y === 'b00001010) else $error("'b00000101 << 1 = 'b00001010 failed.");
assert (aluflags[2] === 0) else $error("'b00000101 << 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00000101 << 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00000101 << 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00000101 << 1 Operation, Carry flag failed");

//Shif left 'b10000000 << 1
A = 1; B = 'b10000000; ctrl=6; #10;
assert (Y === 'b00000000) else $error("'b10000000 << 1 = 'b00000000 failed.");
assert (aluflags[2] === 1) else $error("'b00001000 << 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00001000 << 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00001000 << 1Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00001000 << 1 Operation, Carry flag failed");


//Shif right ctrl=7
//Shif right 'b00000001 >> 1
A = 'b00000001; B = 'b00000001; ctrl=7; #10;
assert (Y === 'b00000000) else $error("'b00000001 >> 1 = 'b00000000 failed.");
assert (aluflags[2] === 1) else $error("'b00000001 >> 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00000001 >> 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00000001 >> 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00000001 >> 1 Operation, Carry flag failed");

//Shif right 'b00001000 >> 1
A = 1; B = 'b00001000; ctrl=7; #10;
assert (Y === 'b00000100) else $error("'b00001000 >> 1 = 'b00000100 failed.");
assert (aluflags[2] === 0) else $error("'b00001000 >> 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00001000 >> 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00001000 >> 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00001000 >> 1 Operation, Carry flag failed");

//Shif right 'b00001111 >> 2
A = 2; B = 'b00001111; ctrl=7; #10;
assert (Y === 'b00000011) else $error("'b00001111 >> 2 = 'b00000011 >> 1 failed.");
assert (aluflags[2] === 0) else $error("'b00001111 >> 2 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00001111 >> 2 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00001111 >> 2 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00001111 >> 2 Operation, Carry flag failed");

//Shif right 'b00000111 >> 3
A = 'b00000011; B = 'b00000111; ctrl=7; #10;
assert (Y === 'b00000000) else $error("'b00000111 >> 3 = 'b00000000 >> 1 failed.");
assert (aluflags[2] === 1) else $error("'b00000111 >> 3 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00000111 >> 3 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00000111 >> 3 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00000111 >> 3 Operation, Carry flag failed");

//Arith Shift ctrl=8
//Arith Shift 'b0001 >>> 1
A = 'b00000001; B = 'b00000001; ctrl=8; #10;
assert (Y === 'b00000000) else $error("'b00000001 >>> 1 = 'b00000000 failed.");
assert (aluflags[2] === 1) else $error("'b00000001 >>> 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b00000001 >>> 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b00000001 >>> 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b00000001  >>> 1 Operation, Carry flag failed");


//Arith Shift 'b11111001 >>> 1
A = 'b00000001; B = 'b11111001; ctrl=8; #10;
assert (Y === 'b11111100) else $error("'b11111001 >>> 1 = 'b11111100 failed.");
assert (aluflags[2] === 0) else $error("'b11111001 >>> 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b11111001 >>> 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b11111001 A >>> 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b11111001 >>> 1 Operation, Carry flag failed");

//Arith Shift 'b1101 >>> 1
A = 'b00000010; B = 'b11000001; ctrl=8; #10;
assert (Y === 'b11110000) else $error("'b11000001 >>> 1 = 'b11100000 failed.");
assert (aluflags[2] === 0) else $error("'b11000001 >>> 1 Operation, Zero flag failed");
assert (aluflags[0] === 0) else $error("'b11000001 >>> 1 Operation, Overflow flag failed");
assert (aluflags[3] === 0) else $error("'b11000001 >>> 1 Operation, Negative flag failed");
assert (aluflags[1] === 0) else $error("'b11000001 >>> 1 Operation, Carry flag failed");




// left rotate
A = 'b00000010; B = 'b11000001; ctrl=9; #10;
assert (Y === 'b00000111) else $error("left rotate failed");

// right rotate
A = 'b00000010; B = 'b11000001; ctrl=10; #10;
assert (Y === 'b01110000) else $error("right rotate failed");

end

endmodule
