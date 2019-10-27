vlib work
vlib 220model

vlog -sv data_mem_tb.sv
vlog data_mem.v

vsim -L altera_mf_ver -L lpm_ver data_mem_tb

log -r /*
run -a
echo "DO NOT QUIT SIMULATION"