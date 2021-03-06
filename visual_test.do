# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog visual.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v leftwhite.v middlewhite.v rightwhite.v black_key.v background_mem.v

#load simulation using mux as the top level simulation module
vsim -L altera_mf_ver -L altera_mf visual -t ns

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force (pressed_key) 10101
force {reset} 0
force {CLOCK_50} 0 0ns, 1 {5ns} -r 10ns
run 10ns

force {reset} 1
run 200000ns