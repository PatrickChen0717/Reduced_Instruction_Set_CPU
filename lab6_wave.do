onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/CPUDUT1/DUT3/present_state
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R0
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R1
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R2
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R3
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R4
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R5
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R6
add wave -noupdate /cpu_tb/CPUDUT1/DP/REGFILE/R7
add wave -noupdate /cpu_tb/load
add wave -noupdate /cpu_tb/clk
add wave -noupdate /cpu_tb/reset
add wave -noupdate /cpu_tb/s
add wave -noupdate /cpu_tb/CPUDUT1/DP/Z_out
add wave -noupdate /cpu_tb/CPUDUT1/DP/V_out
add wave -noupdate /cpu_tb/CPUDUT1/DP/N_out
add wave -noupdate /cpu_tb/in
add wave -noupdate /cpu_tb/CPUDUT1/N
add wave -noupdate /cpu_tb/CPUDUT1/V
add wave -noupdate /cpu_tb/CPUDUT1/Z
add wave -noupdate /cpu_tb/CPUDUT1/w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {775 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
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
WaveRestoreZoom {352 ps} {808 ps}
