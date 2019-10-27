package cpu_inst_types;

    typedef struct packed {
        logic [4:0] opcode;
        logic [2:0] wb_addr;
        logic [2:0] r1_addr;
        logic [2:0] r2_addr;
        logic [1:0] padd;
    } A_instruction;

    typedef struct packed {
        logic [4:0] opcode;
        logic [2:0] wb_addr;
        logic [2:0] r1_addr;
        logic [4:0] padd;
    } B_instruction;

    typedef struct packed {
        logic [4:0] opcode;
        logic [2:0] wb_addr;
        logic [2:0] r1_addr;
        logic [4:0] immediate;        
    } C_instruction;

    typedef struct packed {
        logic [4:0] opcode;
        logic [2:0] wb_addr;
        logic [7:0] immediate;

    } D_instruction;
endpackage