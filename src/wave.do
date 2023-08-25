onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gray55 /tb/dut/HRESETn
add wave -noupdate -expand -group Chap3 /tb/dut/HCLK
add wave -noupdate -expand -group Chap3 /tb/dut/HTRANS
add wave -noupdate -expand -group Chap3 /tb/dut/HADDR
add wave -noupdate -expand -group Chap3 /tb/dut/HWRITE
add wave -noupdate -expand -group Chap3 /tb/dut/HBURST
add wave -noupdate -expand -group Chap3 /tb/dut/HREADY
add wave -noupdate -expand -group Chap3 /tb/dut/HRDATA
add wave -noupdate -expand -group MASTER /tb/dut/master_0/buffer
add wave -noupdate -group S1 /tb/dut/slave_1/HSELx
add wave -noupdate -group S1 /tb/dut/slave_1/HADDR
add wave -noupdate -group S1 /tb/dut/slave_1/HWRITE
add wave -noupdate -group S1 /tb/dut/slave_1/HSIZE
add wave -noupdate -group S1 /tb/dut/slave_1/HBURST
add wave -noupdate -group S1 /tb/dut/slave_1/HPROT
add wave -noupdate -group S1 /tb/dut/slave_1/HTRANS
add wave -noupdate -group S1 /tb/dut/slave_1/HMASTLOCK
add wave -noupdate -group S1 /tb/dut/slave_1/HREADY
add wave -noupdate -group S1 /tb/dut/slave_1/HWDATA
add wave -noupdate -group S1 /tb/dut/slave_1/HREADYOUT
add wave -noupdate -group S1 /tb/dut/slave_1/HRESP
add wave -noupdate -group S1 /tb/dut/slave_1/HRDATA
add wave -noupdate -group S1 /tb/dut/slave_1/HRESET
add wave -noupdate -group S1 -expand /tb/dut/slave_1/reg0
add wave -noupdate -group S1 /tb/dut/slave_1/comb1
add wave -noupdate /tb/dut/slave_1/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {275 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {50 ns} {442 ns}
