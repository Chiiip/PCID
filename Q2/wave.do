onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TOP_test_bench/clock
add wave -noupdate /TOP_test_bench/reset
add wave -noupdate -radix unsigned /TOP_test_bench/mem_address
add wave -noupdate /TOP_test_bench/ready
add wave -noupdate /TOP_test_bench/mem_read_enable
add wave -noupdate /TOP_test_bench/mem_write_enable
add wave -noupdate -radix unsigned /TOP_test_bench/acc_data_out
add wave -noupdate -radix unsigned /TOP_test_bench/acc_data_in
add wave -noupdate -divider {FSM Internal}
add wave -noupdate -radix unsigned /TOP_test_bench/top/fsm_controller/current_state
add wave -noupdate -radix unsigned -childformat {{{/TOP_test_bench/top/fsm_controller/next_state[3]} -radix unsigned} {{/TOP_test_bench/top/fsm_controller/next_state[2]} -radix unsigned} {{/TOP_test_bench/top/fsm_controller/next_state[1]} -radix unsigned} {{/TOP_test_bench/top/fsm_controller/next_state[0]} -radix unsigned}} -subitemconfig {{/TOP_test_bench/top/fsm_controller/next_state[3]} {-height 15 -radix unsigned} {/TOP_test_bench/top/fsm_controller/next_state[2]} {-height 15 -radix unsigned} {/TOP_test_bench/top/fsm_controller/next_state[1]} {-height 15 -radix unsigned} {/TOP_test_bench/top/fsm_controller/next_state[0]} {-height 15 -radix unsigned}} /TOP_test_bench/top/fsm_controller/next_state
add wave -noupdate /TOP_test_bench/top/fsm_controller/acc_load
add wave -noupdate /TOP_test_bench/top/fsm_controller/acc_transfer
add wave -noupdate /TOP_test_bench/top/fsm_controller/acc_clear
add wave -noupdate -divider {ACC Internal}
add wave -noupdate -radix unsigned /TOP_test_bench/top/acc/data_in_reg
add wave -noupdate -divider Memory
add wave -noupdate -radix unsigned /TOP_test_bench/external_ram/address
add wave -noupdate /TOP_test_bench/external_ram/clock
add wave -noupdate -radix unsigned /TOP_test_bench/external_ram/data
add wave -noupdate /TOP_test_bench/external_ram/rden
add wave -noupdate /TOP_test_bench/external_ram/wren
add wave -noupdate -radix unsigned /TOP_test_bench/external_ram/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3203 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
configure wave -valuecolwidth 84
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3072 ns} {3273 ns}
