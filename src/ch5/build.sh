#! /bin/bash
yosys -p "synth_ice40 -json debounce_top.json" debounce_top.v debounce_filter.v ../ch4/led_toggle.v
nextpnr-ice40 --hx1k --json debounce_top.json --pcf ../common/goboard.pcf --sdc ../common/clock.sdc --package vq100 --asc debounce_top.asc
icepack debounce_top.asc debounce_top.bin
