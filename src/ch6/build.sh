#! /bin/bash
yosys -p "synth_ice40 -json demux_lfsr_top.json" demux_lfsr_top.v demux_1_to_4.v lfsr_22.v 
nextpnr-ice40 --hx1k --json demux_lfsr_top.json --pcf ../common/goboard.pcf --sdc ../common/clock.sdc --package vq100 --asc demux_lfsr_top.asc
icepack demux_lfsr_top.asc demux_lfsr_top.bin

yosys -p "synth_ice40 -json demux_count_top.json" demux_count_top.v demux_1_to_4.v count_and_toggle.sv 
nextpnr-ice40 --hx1k --json demux_count_top.json --pcf ../common/goboard.pcf --sdc ../common/clock.sdc --package vq100 --asc demux_count_top.asc
icepack demux_count_top.asc demux_count_top.bin
