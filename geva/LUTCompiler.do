vlib work
vlog -sv LUT_tb.sv LUT.sv LUT_aux.sv
vsim LUT_tb
log -r /*
run -a
echo "DO NOT QUIT SIMULATION"