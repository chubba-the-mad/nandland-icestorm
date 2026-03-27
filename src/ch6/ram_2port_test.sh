verilator --binary -j 0 --trace -Wno-fatal ram_2port.sv ram_2port_tb.sv
./obj_dir/Vram_2port --trace
