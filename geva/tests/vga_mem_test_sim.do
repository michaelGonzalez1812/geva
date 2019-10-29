vlib work
vlib 220model

vlog -sv ./../Mem/interfaces_def_pkg.sv
vlog     ./../Mem/data_mem.v
vlog     ./../Mem/data_mem_keys.v
vlog -sv ./../Mem/data_mem_addr_deco.sv
vlog -sv ./../Mem/data_mem_bb.sv
vlog -sv ./../VGA/freqDivider.sv
vlog -sv ./../VGA/vgaAddressDecoder.sv
vlog -sv ./../VGA/vgaController.sv
vlog -sv ./../VGA/vgaModule.sv
vlog -sv vga_mem_test.sv
vlog -sv vga_mem_test_sim.sv

vsim -L altera_mf_ver -L lpm_ver vga_mem_test_sim

log -r /*
run -a
echo "DO NOT QUIT SIMULATION"