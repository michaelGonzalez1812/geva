vlib work
vlib 220model

vlog -sv ./Mem/interfaces_def_pkg.sv
vlog     ./Mem/data_mem.v
vlog     ./Mem/data_mem_keys.v
vlog -sv ./Mem/data_mem_addr_deco.sv
vlog -sv ./Mem/data_mem_bb.sv
vlog -sv ./Mem/data_mem_unit_vec.sv
vlog -sv ./Mem/data_mem_unit.sv

vlog -sv ./VGA/freqDivider.sv
vlog -sv ./VGA/vgaAddressDecoder.sv
vlog -sv ./VGA/vgaController.sv
vlog -sv ./VGA/vgaModule.sv

vlog -sv ./Vec_CPU/ALU/singleAlu/adder_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/ALUcontrolMux16_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/andGate_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/arithShifter_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/leftRotate_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/leftShifter_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/n_and.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/orGate_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/register_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/rightRotate_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/rightShifter_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/xorGate_n.sv
vlog -sv ./Vec_CPU/ALU/singleAlu/alu.sv

vlog -sv ./Vec_CPU/helper_modules/Reg_N.sv

vlog -sv ./Vec_CPU/ALU/FourLaneALU/alu_mod_control.sv
vlog -sv ./Vec_CPU/ALU/FourLaneALU/alu_module.sv

vlog -sv ./Vec_CPU/helper_modules/LUT_aux.sv
vlog -sv ./Vec_CPU/helper_modules/LUT.sv
vlog -sv ./Vec_CPU/helper_modules/Reg_Control.sv
vlog -sv ./Vec_CPU/helper_modules/Reg_PC.sv
vlog -sv ./Vec_CPU/helper_modules/Reg_Execute.sv
vlog -sv ./Vec_CPU/helper_modules/Reg_Instruction.sv
vlog -sv ./Vec_CPU/helper_modules/Regfile_N.sv
vlog -sv ./Vec_CPU/helper_modules/shifter_module.sv

vlog -sv ./Vec_CPU/imem.sv
vlog -sv ./Vec_CPU/cpu_inst_types.sv
vlog -sv ./Vec_CPU/Processor_Control.sv
vlog -sv ./Vec_CPU/vec_cpu.sv

vlog -sv geva.sv
vlog -sv geva_tb.sv

do wave.do

vsim -L altera_mf_ver -L lpm_ver geva_tb
do wave.do

log -r /*
run -a
echo "DO NOT QUIT SIMULATION"