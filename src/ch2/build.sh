#! /bin/bash
yosys -p "synth_ice40 -top switches_to_leds -json switches_to_leds.json" switches_to_leds.v
nextpnr-ice40 --hx1k --json switches_to_leds.json --pcf ../common/goboard.pcf --package vq100 --asc switches_to_leds.asc
icepack switches_to_leds.asc switches_to_leds.bin
