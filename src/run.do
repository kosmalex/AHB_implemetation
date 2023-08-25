quit -sim
file delete -force work
vlib work

vlog pkg.sv *.sv

vsim -novopt tb
log -r /*

do wave.do

run -all


