onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /FSM_test_bench/u
add wave -noupdate -radix unsigned /FSM_test_bench/v
add wave -noupdate -radix unsigned /FSM_test_bench/x
add wave -noupdate -radix unsigned /FSM_test_bench/y
add wave -noupdate -radix unsigned /FSM_test_bench/address
add wave -noupdate -radix unsigned /FSM_test_bench/read_enable
add wave -noupdate -format Literal -radix unsigned /FSM_test_bench/active_MAC
add wave -noupdate -format Literal -radix unsigned /FSM_test_bench/reset_MAC
add wave -noupdate -format Literal -radix unsigned /FSM_test_bench/ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
