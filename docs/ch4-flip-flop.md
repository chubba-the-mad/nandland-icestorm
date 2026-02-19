# Chapter 4 - Saving State
Again we are predominantly following the book, just now we'll need to add the clock with our IceStorm toolchain.

Files can be found in src/ch4

## Adding a clock
We will be using the same sdc file as the book's specification.
```
create_clock	-period 40.00	-name {i_Clk} [get_ports {i_Clk}]
```
which I've saved as clock.sdc in src/common.
Be sure to also add the clock pin in your pcf file.
```
set_io i_Clk 15
```

## Building with a clock
The only change we'll need is for nextpnr-ice40 for specifying the sdc file to use.
Our build script looks like
```
yosys -p "synth_ice40 -json led_toggle.json" led_toggle.v
nextpnr-ice40 --hx1k --json led_toggle.json --pcf ../common/goboard.pcf --sdc ../common/clock.sdc --package vq100 --asc led_toggle.asc
icepack led_toggle.asc led_toggle.bin
```

Now in performing the build you will see a new part of build output like below.

```
Info: Max frequency for clock 'i_Clk$SB_IO_IN_$glb_clk': 404.04 MHz (PASS at 25.00 MHz)

Info: Max delay <async>                         -> posedge i_Clk$SB_IO_IN_$glb_clk: 2.00 ns
Info: Max delay posedge i_Clk$SB_IO_IN_$glb_clk -> <async>                        : 1.13 ns
```

## Program
```
sudo iceprog led_toggle.bin
```

## Test
Now pressing SW1 when D1 is off will turn D1 on. Pressing SW1 when D1 is on will turn D1 off. (At least most of the time, continue in to chapter 5 to solve that.)
