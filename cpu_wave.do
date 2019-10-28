onerror {resume}
quietly virtual function -install /tb_cpu -env /tb_cpu/u_vec_cpu { &{/tb_cpu/instruction[15], /tb_cpu/instruction[14], /tb_cpu/instruction[13], /tb_cpu/instruction[12], /tb_cpu/instruction[11] }} Fetch
quietly virtual function -install /tb_cpu -env /tb_cpu/u_vec_cpu { &{/tb_cpu/instruction[7], /tb_cpu/instruction[6], /tb_cpu/instruction[5], /tb_cpu/instruction[4], /tb_cpu/instruction[3], /tb_cpu/instruction[2], /tb_cpu/instruction[1], /tb_cpu/instruction[0] }} FetchImm
quietly virtual function -install /tb_cpu -env /tb_cpu/u_vec_cpu { &{/tb_cpu/instruction[10], /tb_cpu/instruction[9], /tb_cpu/instruction[8] }} FetchRD
quietly virtual function -install /tb_cpu -env /tb_cpu/u_vec_cpu { &{/tb_cpu/instruction[7], /tb_cpu/instruction[6], /tb_cpu/instruction[5] }} FetchR1
quietly virtual function -install /tb_cpu -env /tb_cpu/u_vec_cpu { &{/tb_cpu/instruction[4], /tb_cpu/instruction[3], /tb_cpu/instruction[2] }} FetchR2
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Main Control} /tb_cpu/clk
add wave -noupdate -group {Main Control} /tb_cpu/reset
add wave -noupdate -group {Main Control} /tb_cpu/u_vec_cpu/pc_en
add wave -noupdate -group {Main Control} /tb_cpu/u_vec_cpu/ex_en
add wave -noupdate -group Fetch -label FetchOpcode /tb_cpu/Fetch
add wave -noupdate -group Fetch -radix unsigned /tb_cpu/FetchRD
add wave -noupdate -group Fetch -radix unsigned /tb_cpu/FetchR1
add wave -noupdate -group Fetch -radix unsigned /tb_cpu/FetchR2
add wave -noupdate -group Fetch -radix unsigned /tb_cpu/FetchImm
add wave -noupdate -group Fetch -radix decimal /tb_cpu/pc
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_a.opcode
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_a.wb_addr
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_a.r1_addr
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_a.r2_addr
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_c.immediate
add wave -noupdate -group Decode -group Instruction /tb_cpu/u_vec_cpu/inst_d.immediate
add wave -noupdate -group Decode -group EscRegfile /tb_cpu/u_vec_cpu/inst_a.r1_addr
add wave -noupdate -group Decode -group EscRegfile /tb_cpu/u_vec_cpu/inst_a.r2_addr
add wave -noupdate -group Decode -group EscRegfile /tb_cpu/u_vec_cpu/reg1_data
add wave -noupdate -group Decode -group EscRegfile /tb_cpu/u_vec_cpu/reg2_data
add wave -noupdate -group Decode -group VecRegfile /tb_cpu/u_vec_cpu/inst_a.r1_addr
add wave -noupdate -group Decode -group VecRegfile /tb_cpu/u_vec_cpu/inst_a.r2_addr
add wave -noupdate -group Decode -group VecRegfile /tb_cpu/u_vec_cpu/vec1_data
add wave -noupdate -group Decode -group VecRegfile /tb_cpu/u_vec_cpu/vec2_data
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_alu_st
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_mem_st
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_shift_op
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_mem_op
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_esc_wr
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_vec_wr
add wave -noupdate -group Decode -group ControlSignals /tb_cpu/u_vec_cpu/cl_alu_op
add wave -noupdate -group Execute /tb_cpu/u_vec_cpu/ex_opcode
add wave -noupdate -group Execute /tb_cpu/u_vec_cpu/pc_en
add wave -noupdate -group Execute /tb_cpu/u_vec_cpu/ex_en
add wave -noupdate -group Execute -group Mem /tb_cpu/u_vec_cpu/ex_mem_op
add wave -noupdate -group Execute -group Mem /tb_cpu/u_vec_cpu/mem_rdy
add wave -noupdate -group Execute -group Mem /tb_cpu/u_vec_cpu/mem_data_out_esc
add wave -noupdate -group Execute -group Mem /tb_cpu/u_vec_cpu/mem_data_out_vec
add wave -noupdate -group Execute -group Mem /tb_cpu/u_vec_cpu/ex_mem_st
add wave -noupdate -group Execute -group regfileMuxes /tb_cpu/u_vec_cpu/ex_esc_wr
add wave -noupdate -group Execute -group regfileMuxes /tb_cpu/u_vec_cpu/ex_vec_wr
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_reg1_data
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_reg2_data
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_immediate
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_vec1_data
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_vec2_data
add wave -noupdate -group Execute -group ExRegister -radix unsigned /tb_cpu/u_vec_cpu/ex_shift_op
add wave -noupdate -group Execute -group otherResults -radix unsigned /tb_cpu/u_vec_cpu/lut_vec_result
add wave -noupdate -group Execute -group otherResults -radix unsigned /tb_cpu/u_vec_cpu/adder_esc_result
add wave -noupdate -group Execute -group otherResults -radix unsigned /tb_cpu/u_vec_cpu/shifter_esc_result
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/rd_addr1
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/rd_addr2
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/wr_addr
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/wr_data
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/reg1_data
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vecRegs/reg2_data
add wave -noupdate -group Execute -group {Vector Regfile} /tb_cpu/u_vec_cpu/vec_wr_en
add wave -noupdate -group Execute -group {Vector Regfile} -radix unsigned /tb_cpu/u_vec_cpu/wr_data_vec
add wave -noupdate -group Execute -group {Vector Regfile} -radix unsigned /tb_cpu/u_vec_cpu/wb_register_addr
add wave -noupdate -group Execute -group {Escalar Regfile} /tb_cpu/u_vec_cpu/esc_wr_en
add wave -noupdate -group Execute -group {Escalar Regfile} /tb_cpu/u_vec_cpu/escalarRegs/rd_addr1
add wave -noupdate -group Execute -group {Escalar Regfile} /tb_cpu/u_vec_cpu/escalarRegs/rd_addr2
add wave -noupdate -group Execute -group {Escalar Regfile} /tb_cpu/u_vec_cpu/escalarRegs/wr_addr
add wave -noupdate -group Execute -group {Escalar Regfile} -radix unsigned /tb_cpu/u_vec_cpu/escalarRegs/wr_data
add wave -noupdate -group Execute -group {Escalar Regfile} -radix unsigned /tb_cpu/u_vec_cpu/escalarRegs/reg1_data
add wave -noupdate -group Execute -group {Escalar Regfile} -radix unsigned /tb_cpu/u_vec_cpu/escalarRegs/reg2_data
add wave -noupdate -group Execute -group {Escalar Regfile} -radix unsigned /tb_cpu/u_vec_cpu/wr_data_esc
add wave -noupdate -group Execute -group {Escalar Regfile} -radix unsigned /tb_cpu/u_vec_cpu/wb_register_addr
add wave -noupdate -group Execute -group ALU /tb_cpu/u_vec_cpu/ex_alu_st
add wave -noupdate -group Execute -group ALU /tb_cpu/u_vec_cpu/alu_rdy
add wave -noupdate -group Execute -group ALU /tb_cpu/u_vec_cpu/alu_vec_result
add wave -noupdate -group Execute -group ALU /tb_cpu/u_vec_cpu/ex_alu_op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {93 ps}
