# Chapter 3 - Boolean Algebra and the Lookup Table
Here we will mostly be following along with the book.

We will mix things up just slightly by combining some individual logic modules with a top module and see how the toolchain handles it.

Files can be found in src/ch3

## Our And Gate
### Code
```
module and_gate (
	input i_Switch_1,
	input i_Switch_2,
	output o_LED_1);

assign o_LED_1 = i_Switch_1 & i_Switch_2;

endmodule
```
### Build
```
yosys -p "synth_ice40 -json and_gate.json" and_gate.v
nextpnr-ice40 --hx1k --json and_gate.json --pcf ../common/goboard.pcf --package vq100 --asc and_gate.asc
icepack and_gate.asc and_gate.bin
```
### Program
```
sudo iceprog and_gate.bin
```
### Test
Now D1 should only light when both SW1 and SW2 are pressed.

## Our Not Gate
### Code
```
module not_gate (
	input i_Switch_1,
	output o_LED_1);

assign o_LED_1 = ~i_Switch_1;

endmodule
```
### Build
```
yosys -p "synth_ice40 -json not_gate.json" not_gate.v
nextpnr-ice40 --hx1k --json not_gate.json --pcf ../common/goboard.pcf --package vq100 --asc not_gate.asc
icepack not_gate.asc not_gate.bin
```
### Program
```
sudo iceprog and_gate.bin
```
### Test
Now D1 should always be lit unless SW1 is pressed.

## Our Or Gate
### Code
```
module or_gate (
	input i_Switch_1,
	input i_Switch_2,
	output o_LED_1);

assign o_LED_1 = i_Switch_1 | i_Switch_2;

endmodule
```
### Build
```
yosys -p "synth_ice40 -json or_gate.json" or_gate.v
nextpnr-ice40 --hx1k --json or_gate.json --pcf ../common/goboard.pcf --package vq100 --asc or_gate.asc
icepack or_gate.asc or_gate.bin
```
### Program
```
sudo iceprog and_gate.bin
```
### Test
Now D1 should light when SW1 or SW2 are pressed (or if both are).

## Combining Logic
Now we will create the circuit shown in figure 3-7 with the truth table shown in table 3-8. Doing this in separate modules as we are is not optimal by any means, but we are doing it like this to see how we make our first multi module model. We create a "top" module that instantiates our 3 other modules. We then have two internal only connections for which we create wires. Then we specify all the inputs and output.
### Code
```
module ch3_top (
	input i_Switch_1,
	input i_Switch_2,
	input i_Switch_3,
	output o_LED_1);

wire w_not_out;
wire w_and_out;

or_gate or_gate(
	.i_Switch_1(i_Switch_1),
	.i_Switch_2(w_and_out),
	.o_LED_1(o_LED_1));

not_gate not_gate(
	.i_Switch_1(i_Switch_2),
	.o_LED_1(w_not_out));

and_gate and_gate(
	.i_Switch_1(w_not_out),
	.i_Switch_2(i_Switch_3),
	.o_LED_1(w_and_out));

endmodule
```
### Build
Now we need to specify all the verilog files that are part of our design. Go ahead and leave one out to see the error message. Now that we are also linking modules, we will start specifying the "top" for yosys. Still not necessarily needed here but going to start building the habit.
```
yosys -p "synth_ice40 -top ch3_top -json ch3_top.json" ch3_top.v and_gate.v or_gate.v not_gate.v
nextpnr-ice40 --hx1k --json ch3_top.json --pcf ../common/goboard.pcf --package vq100 --asc ch3_top.asc
icepack ch3_top.asc ch3_top.bin
```
### Program
```
sudo iceprog ch3_top.bin
```
### Test
Now run through that truth table in table 3-8 and you should observe the following results.
|SW1|SW2|SW3|D1 |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |
did you match? good job.
