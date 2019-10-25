//~ `New testbench
// `timescale 1ns / 1ps

module tb_Processor_Control;

enum bit [1:0]{
    VEC_MEM = 2'b0,
    ALU = 2'b1,
    LUT = 2'd2} VEC_REG_MUX;

enum bit [1:0]{
    IMM = 2'b0,
    ESC_MEM = 2'b1,
    SHFT = 2'd2,
    SUM = 2'd3} ESC_REG_MUX;

// Processor Instructions
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

// Processor_Control Parameters
//parameter PERIOD = 10;

// Processor_Control Inputs
logic alu_rdy = 0;
logic mem_rdy = 0;
logic [4:0] dec_opcode = 0;
logic [4:0] ex_opcode = 0;

// Processor_Control Outputs
logic pc_en;
logic ex_en;
logic cl_alu_st;
logic cl_mem_st;
logic esc_wr_en;
logic vec_wr_en;
logic cl_shift_op;
logic [1:0] cl_mem_op;
logic [1:0] cl_esc_wr;
logic [1:0] cl_vec_wr;
logic [3:0] cl_alu_op;

//logic clk;
//
//initial
//    begin
//        forever #(PERIOD / 2) clk = ~clk;
//end
//
//initial
//    begin
//        // #(PERIOD*2) rst_n  =  1;
//        end

Processor_Control u_Processor_Control(
    alu_rdy,
    mem_rdy,
    dec_opcode,
    ex_opcode,

    pc_en,
    ex_en,
    cl_alu_st,
    cl_mem_st,
    esc_wr_en,
    vec_wr_en,
    cl_shift_op,
    cl_mem_op,
    cl_esc_wr,
    cl_vec_wr,
    cl_alu_op);

initial
begin

//########### Test 1 ####################
    alu_rdy=0;
    mem_rdy=0;
    dec_opcode = INST_ANDVE;
    ex_opcode= INST_CDE; #10

assert (pc_en === 1) else $error("Test1 pc_en is false, should be true");
assert (ex_en === 1) else $error("Test1 ex_en is false, should be true");
assert (cl_alu_st === 1) else $error("Test1 cl_alu_st is false, should be true");
assert (cl_mem_st === 0) else $error("Test1 cl_mem_st is true, should be false");
assert (esc_wr_en === 1) else $error("Test1 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test1 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test1 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_ANDVE[1:0]) else $error("Test1 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test1 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === ALU) else $error("Test1 cl_vec_wr failed, should select tthe ALU input (==1)");
assert (cl_alu_op === INST_ANDVE[3:0]) else $error("Test1 cl_alu_op failed, should be the last 4 digist of the instruction");


   
//########### Test 2 ####################
    alu_rdy=0;
    mem_rdy=0;
    dec_opcode = INST_ANDVE;
    ex_opcode= INST_CV; #10

assert (pc_en === 0) else $error("Test2 pc_en is false, should be true");
assert (ex_en === 0) else $error("Test2 ex_en is false, should be true");
assert (cl_alu_st === 1) else $error("Test2 cl_alu_st is false, should be true");
assert (cl_mem_st === 0) else $error("Test2 cl_mem_st is true, should be false");
assert (esc_wr_en === 0) else $error("Test2 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test2 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test2 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_ANDVE[1:0]) else $error("Test2 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test2 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === ALU) else $error("Test2 cl_vec_wr failed, should select tthe ALU input (==1)");
assert (cl_alu_op === INST_ANDVE[3:0]) else $error("Test2 cl_alu_op failed, should be the last 4 digist of the instruction");

//########### Test 2.1 ####################
    alu_rdy=0;
    mem_rdy=1;
    dec_opcode = INST_ANDVE;
    ex_opcode= INST_CV; #10

assert (pc_en === 0) else $error("Test2.1 pc_en is false, should be true");
assert (ex_en === 0) else $error("Test2.1 ex_en is false, should be true");
assert (cl_alu_st === 1) else $error("Test2.1 cl_alu_st is false, should be true");
assert (cl_mem_st === 0) else $error("Test2.1 cl_mem_st is true, should be false");
assert (esc_wr_en === 0) else $error("Test2.1 esc_wr_en is false, should be true");
assert (vec_wr_en === 1) else $error("Test2.1 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test2.1 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_ANDVE[1:0]) else $error("Test2.1 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test2.1 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === ALU) else $error("Test2.1 cl_vec_wr failed, should select tthe ALU input (==1)");
assert (cl_alu_op === INST_ANDVE[3:0]) else $error("Test2.1 cl_alu_op failed, should be the last 4 digist of the instruction");


//########### Test 3 ####################
    alu_rdy=1;
    mem_rdy=1;
    dec_opcode = INST_CV;
    ex_opcode= INST_SI; #10

assert (pc_en === 1) else $error("Test3 pc_en is false, should be true");
assert (ex_en === 1) else $error("Test3 ex_en is false, should be true");
assert (cl_alu_st === 0) else $error("Test3 cl_alu_st is false, should be true");
assert (cl_mem_st === 1) else $error("Test3 cl_mem_st is true, should be false");
assert (esc_wr_en === 1) else $error("Test3 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test3 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test3 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_CV[1:0]) else $error("Test3 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test3 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === VEC_MEM) else $error("Test3 cl_vec_wr failed, should select the MEM input (==0)");
assert (cl_alu_op === INST_CV[3:0]) else $error("Test3 cl_alu_op failed, should be the last 4 digist of the instruction");


//########### Test 4 ####################
    alu_rdy=1;
    mem_rdy=0;
    dec_opcode = INST_CV;
    ex_opcode= INST_CV; #10

assert (pc_en === 0) else $error("Test4 pc_en is false, should be true");
assert (ex_en === 0) else $error("Test4 ex_en is false, should be true");
assert (cl_alu_st === 0) else $error("Test4 cl_alu_st is false, should be true");
assert (cl_mem_st === 1) else $error("Test4 cl_mem_st is true, should be false");
assert (esc_wr_en === 0) else $error("Test4 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test4 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test4 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_CV[1:0]) else $error("Test4 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test4 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === VEC_MEM) else $error("Test4 cl_vec_wr failed, should select the MEM input (==0)");
assert (cl_alu_op === INST_CV[3:0]) else $error("Test4 cl_alu_op failed, should be the last 4 digist of the instruction");


//########### Test 4.1 ####################
    alu_rdy=1;
    mem_rdy=1;
    dec_opcode = INST_CV;
    ex_opcode= INST_CV; #10

assert (pc_en === 1) else $error("Test4.1 pc_en is false, should be true");
assert (ex_en === 1) else $error("Test4.1 ex_en is false, should be true");
assert (cl_alu_st === 0) else $error("Test4.1 cl_alu_st is false, should be true");
assert (cl_mem_st === 1) else $error("Test4.1 cl_mem_st is true, should be false");
assert (esc_wr_en === 0) else $error("Test4.1 esc_wr_en is false, should be true");
assert (vec_wr_en === 1) else $error("Test4.1 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test4.1 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_CV[1:0]) else $error("Test4.1 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test4.1 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === VEC_MEM) else $error("Test4.1 cl_vec_wr failed, should select the MEM input (==0)");
assert (cl_alu_op === INST_CV[3:0]) else $error("Test4.1 cl_alu_op failed, should be the last 4 digist of the instruction");


//########### Test 5 ####################
    alu_rdy=0;
    mem_rdy=0;
    dec_opcode = INST_CDE;
    ex_opcode= INST_CIE; #10

assert (pc_en === 1) else $error("Test5 pc_en is false, should be true");
assert (ex_en === 1) else $error("Test5 ex_en is false, should be true");
assert (cl_alu_st === 0) else $error("Test5 cl_alu_st is false, should be true");
assert (cl_mem_st === 0) else $error("Test5 cl_mem_st is true, should be false");
assert (esc_wr_en === 1) else $error("Test5 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test5 vec_wr_en failed, should be false");
assert (cl_shift_op === 1) else $error("Test5 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_CDE[1:0]) else $error("Test5 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === SHFT) else $error("Test5 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === 0) else $error("Test5 cl_vec_wr failed, should select the default input (==0)");
assert (cl_alu_op === INST_CDE[3:0]) else $error("Test5 cl_alu_op failed, should be the last 4 digist of the instruction");
//    $finish;
end

    endmodule