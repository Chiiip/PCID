onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Semaforo_test_bench/A
add wave -noupdate /Semaforo_test_bench/B
add wave -noupdate /Semaforo_test_bench/C
add wave -noupdate /Semaforo_test_bench/D
add wave -noupdate /Semaforo_test_bench/LO
add wave -noupdate /Semaforo_test_bench/NS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 206
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
WaveRestoreZoom {0 ps} {988 ps}
