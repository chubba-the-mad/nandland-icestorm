verilator --binary -j 0 --trace -Wno-fatal fifo.sv fifo_tb.sv
./obj_dir/Vfifo --trace
