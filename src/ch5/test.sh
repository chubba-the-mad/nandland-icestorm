verilator --binary -j 0 --trace -Wno-fatal debounce_filter.v debounce_filter_tb.sv
./obj_dir/Vdebounce_filter --trace
