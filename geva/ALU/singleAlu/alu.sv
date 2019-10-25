// ALU OPs
// ----------
// 0000	-> AND vector escalar - 2
// 0001	-> AND vector vector - 2
// 0010	->	OR vector escalar - 3
// 0011	->	OR vector vector - 3
// 0100	->	XOR vector escalar - 5
// 0101	->	XOR vector		- 5
// 0110	->  Corrimiento derecho vector - 7
// 0111	->  Corrimiento izquierdo vector - 7
// 1000	->	Rotación Derecha
// 1001	->	Rotación Izquierda
// 1010	->	Suma vector
// 1011	->  Suma vector escalar
// 1100	->	Resta vector
// 1101	->	Resta vector escalar


// Single ALU OPs
// --------------
// 	   0:		Y = sum;
//     1:		Y = substr;
//     2:		Y = and_op;
//     3:		Y = or_op;
//     4:		Y = nor_op;
//     5:		Y = xor_op;
//     6:		Y = leftShift_op;
//     7:		Y = rightShift_op;
//     8:		Y = arithShift_op;
//     9:		Y =	leftRotate_op;
//     10:		Y = rightRotate_op;


module alu #(parameter N=8)
				(input  logic [N-1:0] A, B, 
             input  logic [3:0]  Control, 
             output logic [N-1:0] Y, 
             output logic [3:0] AluFlags); 

logic Cout, Negative, Zero, Carry, Overflow;

logic [N-1:0] sum, B_calc, and_r, or_r,
xor_r, leftShift_r, rightShift_r, arithShift_r,leftRotate_r, rightRotate_r;

//~B (inverted) or B, if substracting C[0]=1 or adding C[0]=0 
//also works as not operation
assign B_calc= Control[0] ? ~B : B;
					
					
//modules & operations
adder_n #(N) sumador(A, B_calc, Control[0], sum, Cout);
andGate_n #(N) compAnd(A, B, and_r);
orGate_n #(N) compOR(A,B, or_r);
xorGate_n #(N) compXor(A,B, xor_r);
leftShifter_n #(N) ls(B, A[$clog2(N)-1:0], leftShift_r);
rightShifter_n #(N) rs(B, A[$clog2(N)-1:0], rightShift_r);
arithShifter_n #(N) as(B, A[$clog2(N)-1:0], arithShift_r);
leftRotate_n #(N) leftrotate(B, A[$clog2(N)-1:0], leftRotate_r);
rightRotate_n #(N) rightrotate(B, A[$clog2(N)-1:0], rightRotate_r);




//control module
ALUcontrolMux16_n #(N) control(sum, sum, and_r, or_r, ~or_r,xor_r,leftShift_r,rightShift_r, arithShift_r, leftRotate_r, rightRotate_r, Control, Y);
									 


//output flags
assign Zero = &(~Y);
assign Negative = Y[N-1];
assign Overflow = (~Control[1]) & (A[N-1] ^ sum[N-1]) & ~(A[N-1] ^ B[N-1] ^ Control[0]);
assign Carry = (~Control[1]) & Cout;


assign AluFlags = {Negative, Zero, Carry, Overflow};
				 
endmodule