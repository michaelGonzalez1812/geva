/*

ALU OPs
----------
0000	-> AND vector escalar
0001	-> AND vector vector
0010	->	OR vector escalar
0011	->	OR vector vector
0100	->	XOR vector escalar
0101	->	XOR vector		
0110	->  Corrimiento derecho vector
0111	->  Corrimiento izquierdo vector
1000	->	Rotación Derecha
1001	->	Rotación Izquierda
1010	->	Suma vector
1011	->  Suma vector escalar
1100	->	Resta vector
1101	->	Resta vector escalar

MEM OPs
-----------------
10	B	Cargar Vector
11	B	Cargar Escalar
00	B	Guardar Vector
01	B	Guardar Escalar

*/

`ifndef MODULE_P_CONTROL
`define MODULE_P_CONTROL

    module
    Processor_Control(
        input logic alu_rdy, mem_rdy,
        input logic [4:0] dec_opcode, ex_opcode,
        output logic pc_en, ex_en, cl_alu_st, cl_mem_st,
        esc_wr_en, vec_wr_en, cl_shift_op,
        output logic [1:0] cl_mem_op, cl_esc_wr, cl_vec_wr,
        output logic [3:0] cl_alu_op);

enum bit [1:0]{
    VEC_MEM = 2'd0,
    ALU = 2'd1,
    LUT = 2'd2} VEC_REG_MUX;

enum bit [1:0]{
    IMM = 2'd0,
    ESC_MEM = 2'd1,
    SHFT = 2'd2,
    SUM = 2'd3} ESC_REG_MUX;

enum bit [4:0]{
    INST_CV = 5'b01110, // cargar vector
    INST_CE = 5'b01111, // cargar escalar
    INST_CI = 5'b10110, // cargar inmediato
    INST_GV = 5'b10000, // guardar vector
    INST_GE = 5'b10001, //	B	Guardar Escalar	ge

    INST_ANDVE = 5'b00000, //	A	AND vector escalar	andve
    INST_ANDVV = 5'b00001, //	A	AND vector vector	andvv
    INST_ORVE = 5'b00010,  //	A	OR vector escalar	orve
    INST_ORVV = 5'b00011,  //	A	OR vector vector	orvv
    INST_XORE = 5'b00100,  //	A	XOR vector escalar	xore
    INST_XORV = 5'b00101,  //	A	XOR vector	xorv

    INST_CDV = 5'b00110, //	A	Corrimiento derecho vector	cdv
    INST_CIV = 5'b00111, //	A	Corrimiento izquierdo vector	civ
    INST_RDV = 5'b01000, //	A	Rotación Derecha	rd
    INST_RIV = 5'b01001, //	A	Rotación Izquierda	ri
    INST_CDE = 5'b10011, //	C	Corrimiento derecho escalar	cde
    INST_CIE = 5'b10100, //	C	Corrimiento izquierdo escalar	cie

    INST_SV = 5'b01010,  //	A	Suma vector	sv
    INST_SI = 5'b10101,  //	C	Suma inmediato sin signo	si
    INST_SVE = 5'b01011, //	A	Suma vector escalar	sve
    INST_RV = 5'b01100,  //	A	Resta vector	rv
    INST_RVE = 5'b01101, //	A	Resta vector escalar	rve

    INST_TB = 5'b10010, //	B	Tabla de busqueda	tb

    INST_STP = 5'b11111 //	A	Stop	stp

} INST_OPCODE;

//ALU op corresponds to the 4 Least Significant bBts of the opcode
assign cl_alu_op = dec_opcode [3:0];

//MEM op corresponds to the 2 Least Significant Bits of the opcode
assign cl_mem_op = dec_opcode [1:0];

//shift operation
assign cl_shift_op = (dec_opcode == INST_CDE); //only on when there is a right shift, otherwise always do left shift

//signal to start memory module
assign cl_mem_st = (dec_opcode >= 5'b01110) && (dec_opcode <= 5'b10001); //only on Memory instructions

//signal to start alu module
assign cl_alu_st = (dec_opcode >= 5'b00000) && (dec_opcode <= 5'b01101); //only on ALU vec instructions

//mux control signal for writing to escalar reg
assign cl_esc_wr = (dec_opcode == INST_CI) ? IMM : (dec_opcode == INST_CE) ? ESC_MEM : (dec_opcode == INST_CDE || dec_opcode == INST_CIE) ? SHFT : (dec_opcode == INST_SI) ? SUM : 2'b0;

//mux control signal for writing to vector reg
assign cl_vec_wr = (dec_opcode == INST_TB) ? LUT : ((dec_opcode >= 5'b00000) && (dec_opcode <= 5'b01101)) ? ALU : (dec_opcode == INST_CV) ? VEC_MEM : 2'b0;


//signal to stall processor on vector operations
logic stall;
assign stall = ~(((ex_opcode >= 5'b00000) && (ex_opcode <= 5'b01101) && ~alu_rdy) || ((ex_opcode >= 5'b01110) && (ex_opcode <= 5'b10001) && ~mem_rdy)) ;

assign pc_en = stall;

assign ex_en = stall;


//enable signal to write escalar reg file
assign esc_wr_en = (ex_opcode == INST_CI && mem_rdy) || (ex_opcode == INST_CE) || (ex_opcode == INST_CIE) || (ex_opcode == INST_SI);


//enable signal to write vector reg file
assign vec_wr_en = ex_opcode == INST_TB || ((ex_opcode >= 5'b00000) && (ex_opcode <= 5'b01101) && alu_rdy) || (ex_opcode == INST_CV && mem_rdy);



endmodule
`endif
