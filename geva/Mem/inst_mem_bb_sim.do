vlib work
vlib 220model

vlog     inst_mem_block0.v
vlog     inst_mem_block1.v
vlog     inst_mem_block2.v
vlog -sv inst_mem_bb.sv
vlog -sv inst_mem_bb_test.sv

vsim -L altera_mf_ver -L lpm_ver inst_mem_bb_test

log -r /*
run -a
echo "DO NOT QUIT SIMULATION"