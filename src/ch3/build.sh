#! /bin/bash
yosys -p "synth_ice40 -json and_gate.json" and_gate.v
nextpnr-ice40 --hx1k --json and_gate.json --pcf ../common/goboard.pcf --package vq100 --asc and_gate.asc
icepack and_gate.asc and_gate.bin

yosys -p "synth_ice40 -json or_gate.json" or_gate.v
nextpnr-ice40 --hx1k --json or_gate.json --pcf ../common/goboard.pcf --package vq100 --asc or_gate.asc
icepack or_gate.asc or_gate.bin

yosys -p "synth_ice40 -json not_gate.json" not_gate.v
nextpnr-ice40 --hx1k --json not_gate.json --pcf ../common/goboard.pcf --package vq100 --asc not_gate.asc
icepack not_gate.asc not_gate.bin

yosys -p "synth_ice40 -top ch3_top -json ch3_top.json" ch3_top.v and_gate.v or_gate.v not_gate.v
nextpnr-ice40 --hx1k --json ch3_top.json --pcf ../common/goboard.pcf --package vq100 --asc ch3_top.asc
icepack ch3_top.asc ch3_top.bin
