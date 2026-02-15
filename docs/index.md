# Introducing Project IceStorm!

This project is learning verilog with the book "Getting Started With FPGAs" by Russell Merrick <https://nandland.com> but using an open source tool chain on Linux instead of the proprietary tools on Windows.

Key to this entire endeavour is the work done by Clifford Wolf on Project IceStorm <https://clifford.at/icestorm> and EDA tools created by Yosys <https://yosyshq.net/>. The CHIPS Alliance <https://www.chipsalliance.org> has streamlined the various tools used in their F4PGA project <https://f4pga.org> but here we will be getting our hands dirty using the tools individually. We will also simulate our verilog designs using Verilator <https://github.com/verilator/verilator>.

## General Toolchain
1. Yosys - performs synthesis
2. Nextpnr - performs place and route
3. Verilator - turn verilog into runnable code for simulation
4. icepack - converts to iCE40 binary format
5. iceprog - load binary on the hardware

## My Process
I'll be working through the book chapter by chapter using the Nandland Go Board and providing details on accomplishing the same projects with our alternative toolchain. My focus is on verilog and VHDL will be ignored. This is a project I'm doing to satisfy my own desire to learn but keeping public notes in case they provide some help to future stumblers. I've certainly learned much from random blogs and forums so I hope my own notes provide some modicum of help to at least one other person.

## Contents
- Chapter 1 - nothing to add
- [Chapter 2 - Environment Setup](ch2-environment-setup.md)
- [Chapter 3 - Boolean Algebra](ch3-boolean-algebra.md)
