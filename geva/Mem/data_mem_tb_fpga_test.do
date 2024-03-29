vlib work
vlib 220model

vlog -sv interfaces_def_pkg.sv
vlog     data_mem.v
vlog     data_mem_keys.v
vlog -sv data_mem_addr_deco.sv
vlog -sv data_mem_bb.sv
vlog -sv data_mem_bb_test.sv
vlog -sv data_mem_tb_fpga.sv
vlog -sv data_mem_tb_fpga_test.sv

vsim -L altera_mf_ver -L lpm_ver data_mem_tb_fpga_test

log -r /*
run -a
echo "DO NOT QUIT SIMULATION"