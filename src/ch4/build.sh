#! /bin/bash
yosys -p "synth_ice40 -json led_toggle.json" led_toggle.v
nextpnr-ice40 --hx1k --json led_toggle.json --pcf ../common/goboard.pcf --sdc ../common/clock.sdc --package vq100 --asc led_toggle.asc
icepack led_toggle.asc led_toggle.bin
