# Chapter 5 - Simulation
Instead of using EDA Playground like the book, we will be using the open source tool Verilator <https://www.veripool.org/verilator/>.

## Verilator Getting Started
### Setup
Check out <https://verilator.org/guide/latest/install.html> for install instructions.
I prefer building from source. The provided instructions are good and I won't go through them here.

### Run Examples
Before we start our own let's just get comfortable running Verilator. We'll be primarily using the binary build mode <https://verilator.org/guide/latest/example_binary.html>

## Our First Testbench
Just like the book we will be going back to ch3 to write a testbench for our and gate. I've added this back in src/ch3.

### Build
```
verilator --binary -j 0 and_gate.v and_gate_tb.sv
```
At the bottom of your terminal you should see some lines like the following indicating the simulation is built
```
- V e r i l a t i o n   R e p o r t: Verilator 5.044 2026-01-01 rev v5.044-52-g7e7b6d7fb
- Verilator: Built from 0.042 MB sources in 3 modules, into 0.020 MB in 6 C++ files needing 0.000 MB
- Verilator: Walltime 0.529 s (elab=0.000, cvt=0.003, bld=0.521); cpu 0.009 s on 4 threads; alloced 38.324 MB
```
### Run
We can now run the simulation with
```
./obj_dir/Vand_gate 
```
which gives the output of 
```
-Info: and_gate_tb.sv:13: $dumpvar ignored, as Verilated without --trace
- and_gate_tb.sv:26: Verilog $finish
- S i m u l a t i o n   R e p o r t: Verilator 5.044 2026-01-01
- Verilator: $finish at 40ps; walltime 0.000 s; speed 455.986 ns/s
- Verilator: cpu 0.000 s on 1 threads; alloced 6 MB
```

## Our First Testbench... again
So that wasn't very spectacular and doesn't look like any useful output for us really. We'll we have a hint that maybe we missed something with '--trace' so let's try again.
### Build
```
verilator --binary -j 0 --trace and_gate.v and_gate_tb.sv
```
### Run
```
./obj_dir/Vand_gate --trace
```
Alright, now we got a dump.vcd created but what do we do with it?
### View results
install gtkwave

```
gtkwave dump.vcd 
```

You should see a screen like below.
(img/gtkwave_blank.png)

Using $dumpvars in our testbench saved off all our signals for us which we can see in 
(img/gtkwave_signal_list.png)

Now we want to add the signals we care about.
(img/gtkwave_graph.png)

## Now to Debouncing
...
