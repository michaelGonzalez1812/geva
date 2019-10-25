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
// 1000	->	Rotación Derecha - 10
// 1001	->	Rotación Izquierda - 9
// 1010	->	Suma vector - 0
// 1011	->  Suma vector escalar - 0
// 1100	->	Resta vector - 1
// 1101	->	Resta vector escalar - 1


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
enum bit [3:0]{SUM_OP, SUBS_OP, AND_OP, OR_OP, NOR_OP, XOR_OP,
     LEFT_SHFT_OP, RIGHT_SHFT_OP, ARITH_SHFT_OP, LEFT_ROTATE_OP,      RIGTH_ROTATE_OP
} INTERNAL_ALU_OPS;

enum bit [3:0]{
    INST_ANDVE = 4'b0000, //	A	AND vector escalar	andve
    INST_ANDVV = 4'b0001, //	A	AND vector vector	andvv
    INST_ORVE = 4'b0010,  //	A	OR vector escalar	orve
    INST_ORVV = 4'b0011,  //	A	OR vector vector	orvv
    INST_XORE = 4'b0100,  //	A	XOR vector escalar	xore
    INST_XORV = 4'b0101,  //	A	XOR vector	xorv
    INST_CDV = 4'b0110, //	A	Corrimiento derecho vector	cdv
    INST_CIV = 4'b0111, //	A	Corrimiento izquierdo vector	civ
    INST_RDV = 4'b1000, //	A	Rotación Derecha	rd
    INST_RIV = 4'b1001, //	A	Rotación Izquierda	ri
    INST_SV = 4'b1010,  //	A	Suma vector	sv
    INST_SVE = 4'b1011, //	A	Suma vector escalar	sve
    INST_RV = 4'b1100,  //	A	Resta vector	rv
    INST_RVE = 4'b1101 //	A	Resta vector escalar	rve

} INST_ALU_OPS;

module alu_mod_control(
    input logic clk, reset, alu_start,
    input logic [3:0] alu_op,

    output logic alu_rdy, out_en1, out_en2, in_sel_a,
    
    output logic [1:0] in_sel_b,
    output logic [3:0] int_alu_op
);

typedef enum  { Waiting, Phase1, Phase2, Ready } state;

state current_state, next_state;

logic is_vector_escalar;
assign  is_vector_escalar = (alu_op == INST_ANDVE) || (alu_op == INST_ORVE) || (alu_op == INST_RVE) || (alu_op == INST_SVE) || (alu_op == INST_XORE);

// logic is_vec_esc = ;
//State register
always_ff @(posedge clk, posedge reset)
    if (reset) 			current_state <= Waiting;
    else 				current_state <= next_state;
            
//Next state logic
always_comb
    case (current_state)
        Waiting:	
            next_state = alu_start ? Phase1  : Waiting;

        Phase1:	        
            next_state = Phase2;
        
        Phase2:	         
            next_state = Ready;
        
        Ready:	       
            next_state = Waiting;      
        
    endcase

//alu_op translation
always_comb
case(alu_op)
    INST_ANDVE: //	A	AND vector escalar	andve
        int_alu_op = AND_OP;
    INST_ANDVV: //	A	AND vector vector	andvv
        int_alu_op = AND_OP;
    INST_ORVE: //	A	OR vector escalar	orve
        int_alu_op = OR_OP;
    INST_ORVV:  //	A	OR vector vector	orvv
        int_alu_op = OR_OP;
    INST_XORE:  //	A	XOR vector escalar	xore
        int_alu_op = XOR_OP;
    INST_XORV:  //	A	XOR vector	xorv
        int_alu_op = XOR_OP;
    INST_CDV : //	A	Corrimiento derecho vector	cdv
        int_alu_op = RIGHT_SHFT_OP;
    INST_CIV : //	A	Corrimiento izquierdo vector	civ
        int_alu_op = LEFT_SHFT_OP;
    INST_RDV : //	A	Rotación Derecha	rd
        int_alu_op = RIGTH_ROTATE_OP;
    INST_RIV : //	A	Rotación Izquierda	ri
        int_alu_op = LEFT_ROTATE_OP;
    INST_SV :  //	A	Suma vector	sv
        int_alu_op = SUM_OP;
    INST_SVE : //	A	Suma vector escalar	sve
        int_alu_op = SUM_OP;
    INST_RV :  //	A	Resta vector	rv
        int_alu_op = SUBS_OP;
    INST_RVE ://	A	Resta vector escalar	rve
        int_alu_op = SUBS_OP;
endcase


//output signal assignment
assign alu_rdy = current_state == Ready;
assign out_en1 = current_state == Phase1;
assign out_en2 = current_state == Phase2;

assign in_sel_a = current_state == Phase1;

assign in_sel_b = is_vector_escalar ? 2'd2 : current_state == Phase1 ? 2'd1 : 2'd0;

    
endmodule