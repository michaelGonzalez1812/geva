vlib work
vlib 220model

vlog -sv interfaces_def_pkg.sv
vlog     data_mem.v
vlog     data_mem_keys.v
vlog -sv data_mem_addr_deco.sv
vlog -sv data_mem_bb.sv
vlog -sv data_mem_unit_vec.sv
vlog -sv data_mem_unit.sv
vlog -sv data_mem_unit_test.sv

vsim -L altera_mf_ver -L lpm_ver data_mem_unit_test
do wave.do
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"