onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /data_mem_unit_test/clk
add wave -noupdate -radix unsigned /data_mem_unit_test/mem_start
add wave -noupdate -radix unsigned /data_mem_unit_test/mem_op
add wave -noupdate -radix unsigned /data_mem_unit_test/base_addr
add wave -noupdate -radix unsigned /data_mem_unit_test/data_in_esc
add wave -noupdate -radix unsigned /data_mem_unit_test/data_in_vec
add wave -noupdate -radix unsigned /data_mem_unit_test/addr
add wave -noupdate -radix unsigned /data_mem_unit_test/data_to_mem
add wave -noupdate -radix unsigned /data_mem_unit_test/mem_rdy
add wave -noupdate -radix unsigned /data_mem_unit_test/wr_en
add wave -noupdate -radix unsigned /data_mem_unit_test/data_out_esc
add wave -noupdate -radix unsigned /data_mem_unit_test/data_out_vec
add wave -noupdate -radix unsigned /data_mem_unit_test/out_data_vga
add wave -noupdate -radix unsigned /data_mem_unit_test/out_data_cpu
add wave -noupdate -radix unsigned /data_mem_unit_test/MEM_OP
add wave -noupdate /data_mem_unit_test/DUT/vec_unit/clk
add wave -noupdate -color Magenta -radix unsigned /data_mem_unit_test/DUT/vec_unit/mem_start
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/cpu_addr
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/mem_data_read
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/vec_data_in
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/wr_en
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/ctl_flags
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/vec_data_out
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/mem_ready
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/STATES_TYPES
add wave -noupdate -radix unsigned /data_mem_unit_test/DUT/vec_unit/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6241 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {16 ns}
