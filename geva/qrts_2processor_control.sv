//########### Test 5 ####################
    alu_rdy=1;
    mem_rdy=1;
    dec_opcode = INST_CV;
    ex_opcode= INST_SI; #10

assert (pc_en === 1) else $error("Test5 pc_en is false, should be true");
assert (ex_en === 1) else $error("Test5 ex_en is false, should be true");
assert (cl_alu_st === 0) else $error("Test5 cl_alu_st is false, should be true");
assert (cl_mem_st === 1) else $error("Test5 cl_mem_st is true, should be false");
assert (esc_wr_en === 1) else $error("Test5 esc_wr_en is false, should be true");
assert (vec_wr_en === 0) else $error("Test5 vec_wr_en failed, should be false");
assert (cl_shift_op === 0) else $error("Test5 cl_shift_op failed, should be 0 (default)");
assert (cl_mem_op === INST_CV[1:0]) else $error("Test5 cl_mem_op failed, should be last 2 digits of instruction");
assert (cl_esc_wr === 0) else $error("Test5 cl_esc_wr failed, should be 0 (default)");
assert (cl_vec_wr === VEC_MEM) else $error("Test5 cl_vec_wr failed, should select the MEM input (==0)");
assert (cl_alu_op === INST_CV[3:0]) else $error("Test5 cl_alu_op failed, should be the last 4 digist of the instruction");