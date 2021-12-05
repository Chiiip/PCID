onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /remote_controller_test_bench/clk
add wave -noupdate /remote_controller_test_bench/reset
add wave -noupdate /remote_controller_test_bench/serial
add wave -noupdate /remote_controller_test_bench/ready
add wave -noupdate /remote_controller_test_bench/remote_key
add wave -noupdate -divider {Internal registers}
add wave -noupdate -radix unsigned /remote_controller_test_bench/rc/current_state
add wave -noupdate -radix unsigned /remote_controller_test_bench/rc/next_state
add wave -noupdate /remote_controller_test_bench/rc/key_code
add wave -noupdate /remote_controller_test_bench/rc/key_inv_code
add wave -noupdate -radix unsigned /remote_controller_test_bench/rc/counter
add wave -noupdate /remote_controller_test_bench/rc/KEY_EXISTS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1833 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {7301 ns}
