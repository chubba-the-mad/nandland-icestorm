# Chapter 2 - Getting Started
Here the fun begins. We will be pulling the repos and compiling all the tools ourselves. Then building and programming the first project to see our toolchain in action.

These notes will assume you have a handle on using linux and compiling code.

sources:
<https://clifford.at/icestorm>
<https://www.youtube.com/watch?v=P-9WCFi0p-0>


## Environment Setup
### Operating System
These instructions will all be performed on Ubuntu 24.04.
#### Dependencies
```
sudo apt install build-essential git clang bison flex libreadline-dev gawk tcl-dev libffi-dev git mercurial graphviz         xdot pkg-config python3 libftdi-dev python3-dev libboost-all-dev cmake libeigen3-dev lld libfl-dev libreadline-dev zlib1g-dev curl

curl -LsSf https://astral.sh/uv/install.sh | sh

source $HOME/.local/bin/env
```

### Tools
#### Yosys

```
git clone https://github.com/YosysHQ/yosys.git
cd yosys
git submodule update --init --recursive
make config-clang
make -j$(nproc)
sudo make install
```

#### Nextpnr

```
git clone https://github.com/YosysHQ/nextpnr.git
cd nextpnr
mkdir build
cmake . -B build -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local
cd build
make -j$(nproc)
sudo make install
```

#### IceStorm

```
git clone https://github.com/YosysHQ/icestorm.git
cd icestorm
make -j$(nproc)
sudo make install
```

## First Build
Now to try out this toolchain with the first project, switches_to_leds

### Verilog source
You can find my code for this in the src/ch2 directory

### Synthesis
#### Command
```
yosys -p "synth_ice40 -top switches_to_leds -json switches_to_leds.json" switches_to_leds.v
```
#### Output
<details>
<summary>see output</summary>
<code>
 /----------------------------------------------------------------------------\
 |  yosys -- Yosys Open SYnthesis Suite                                       |
 |  Copyright (C) 2012 - 2026  Claire Xenia Wolf <claire@yosyshq.com>         |
 |  Distributed under an ISC-like license, type "license" to see terms        |
 \----------------------------------------------------------------------------/
 Yosys 0.61+112 (git sha1 ac427a79b, clang++ 18.1.3 -fPIC -O3)

-- Parsing `switches_to_leds.v' using frontend ` -vlog2k' --

1. Executing Verilog-2005 frontend: switches_to_leds.v
Parsing Verilog input from `switches_to_leds.v' to AST representation.
Storing AST representation for module `$abstract\switches_to_leds'.
Successfully finished Verilog frontend.

-- Running command `synth_ice40 -top switches_to_leds -json switches_to_leds.json' --

2. Executing SYNTH_ICE40 pass.

2.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/cells_sim.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/cells_sim.v' to AST representation.
Generating RTLIL representation for module `\SB_IO'.
Generating RTLIL representation for module `\SB_GB_IO'.
Generating RTLIL representation for module `\SB_GB'.
Generating RTLIL representation for module `\SB_LUT4'.
Generating RTLIL representation for module `\SB_CARRY'.
Generating RTLIL representation for module `\SB_DFF'.
Generating RTLIL representation for module `\SB_DFFE'.
Generating RTLIL representation for module `\SB_DFFSR'.
Generating RTLIL representation for module `\SB_DFFR'.
Generating RTLIL representation for module `\SB_DFFSS'.
Generating RTLIL representation for module `\SB_DFFS'.
Generating RTLIL representation for module `\SB_DFFESR'.
Generating RTLIL representation for module `\SB_DFFER'.
Generating RTLIL representation for module `\SB_DFFESS'.
Generating RTLIL representation for module `\SB_DFFES'.
Generating RTLIL representation for module `\SB_DFFN'.
Generating RTLIL representation for module `\SB_DFFNE'.
Generating RTLIL representation for module `\SB_DFFNSR'.
Generating RTLIL representation for module `\SB_DFFNR'.
Generating RTLIL representation for module `\SB_DFFNSS'.
Generating RTLIL representation for module `\SB_DFFNS'.
Generating RTLIL representation for module `\SB_DFFNESR'.
Generating RTLIL representation for module `\SB_DFFNER'.
Generating RTLIL representation for module `\SB_DFFNESS'.
Generating RTLIL representation for module `\SB_DFFNES'.
Generating RTLIL representation for module `\SB_RAM40_4K'.
Generating RTLIL representation for module `\SB_RAM40_4KNR'.
Generating RTLIL representation for module `\SB_RAM40_4KNW'.
Generating RTLIL representation for module `\SB_RAM40_4KNRNW'.
Generating RTLIL representation for module `\ICESTORM_LC'.
Generating RTLIL representation for module `\SB_PLL40_CORE'.
Generating RTLIL representation for module `\SB_PLL40_PAD'.
Generating RTLIL representation for module `\SB_PLL40_2_PAD'.
Generating RTLIL representation for module `\SB_PLL40_2F_CORE'.
Generating RTLIL representation for module `\SB_PLL40_2F_PAD'.
Generating RTLIL representation for module `\SB_WARMBOOT'.
Generating RTLIL representation for module `\SB_SPRAM256KA'.
Generating RTLIL representation for module `\SB_HFOSC'.
Generating RTLIL representation for module `\SB_LFOSC'.
Generating RTLIL representation for module `\SB_RGBA_DRV'.
Generating RTLIL representation for module `\SB_LED_DRV_CUR'.
Generating RTLIL representation for module `\SB_RGB_DRV'.
Generating RTLIL representation for module `\SB_I2C'.
Generating RTLIL representation for module `\SB_SPI'.
Generating RTLIL representation for module `\SB_LEDDA_IP'.
Generating RTLIL representation for module `\SB_FILTER_50NS'.
Generating RTLIL representation for module `\SB_IO_I3C'.
Generating RTLIL representation for module `\SB_IO_OD'.
Generating RTLIL representation for module `\SB_MAC16'.
Generating RTLIL representation for module `\ICESTORM_RAM'.
Successfully finished Verilog frontend.

2.2. Executing HIERARCHY pass (managing design hierarchy).

2.3. Executing AST frontend in derive mode using pre-parsed AST for module `\switches_to_leds'.
Generating RTLIL representation for module `\switches_to_leds'.

2.3.1. Analyzing design hierarchy..
Top module:  \switches_to_leds

2.3.2. Analyzing design hierarchy..
Top module:  \switches_to_leds
Removing unused module `$abstract\switches_to_leds'.
Removed 1 unused modules.

2.4. Executing PROC pass (convert processes to netlists).

2.4.1. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Cleaned up 0 empty switches.

2.4.2. Executing PROC_RMDEAD pass (remove dead branches from decision trees).
Removed a total of 0 dead cases.

2.4.3. Executing PROC_PRUNE pass (remove redundant assignments in processes).
Removed 0 redundant assignments.
Promoted 0 assignments to connections.

2.4.4. Executing PROC_INIT pass (extract init attributes).

2.4.5. Executing PROC_ARST pass (detect async resets in processes).

2.4.6. Executing PROC_ROM pass (convert switches to ROMs).
Converted 0 switches.

2.4.7. Executing PROC_MUX pass (convert decision trees to multiplexers).

2.4.8. Executing PROC_DLATCH pass (convert process syncs to latches).

2.4.9. Executing PROC_DFF pass (convert process syncs to FFs).

2.4.10. Executing PROC_MEMWR pass (convert process memory writes to cells).

2.4.11. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Cleaned up 0 empty switches.

2.4.12. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.5. Executing FLATTEN pass (flatten design).

2.6. Executing TRIBUF pass.

2.7. Executing DEMINOUT pass (demote inout ports to input or output).

2.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.9. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.10. Executing CHECK pass (checking for obvious problems).
Checking module switches_to_leds...
Found and reported 0 problems.

2.11. Executing OPT pass (performing simple optimizations).

2.11.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.11.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.11.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \switches_to_leds..
  Creating internal representation of mux trees.
  No muxes found in this module.
Removed 0 multiplexer ports.

2.11.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \switches_to_leds.
Performed a total of 0 changes.

2.11.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.11.6. Executing OPT_DFF pass (perform DFF optimizations).

2.11.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.11.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.11.9. Finished fast OPT passes. (There is nothing left to do.)

2.12. Executing FSM pass (extract and optimize FSM).

2.12.1. Executing FSM_DETECT pass (finding FSMs in design).

2.12.2. Executing FSM_EXTRACT pass (extracting FSM from design).

2.12.3. Executing FSM_OPT pass (simple optimizations of FSMs).

2.12.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.12.5. Executing FSM_OPT pass (simple optimizations of FSMs).

2.12.6. Executing FSM_RECODE pass (re-assigning FSM state encoding).

2.12.7. Executing FSM_INFO pass (dumping all available information on FSM cells).

2.12.8. Executing FSM_MAP pass (mapping FSMs to basic logic).

2.13. Executing OPT pass (performing simple optimizations).

2.13.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.13.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.13.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \switches_to_leds..
  Creating internal representation of mux trees.
  No muxes found in this module.
Removed 0 multiplexer ports.

2.13.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \switches_to_leds.
Performed a total of 0 changes.

2.13.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.13.6. Executing OPT_DFF pass (perform DFF optimizations).

2.13.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.13.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.13.9. Finished fast OPT passes. (There is nothing left to do.)

2.14. Executing WREDUCE pass (reducing word size of cells).

2.15. Executing PEEPOPT pass (run peephole optimizers).

2.16. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.17. Executing SHARE pass (SAT-based resource sharing).

2.18. Executing TECHMAP pass (map to technology primitives).

2.18.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/cmp2lut.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/cmp2lut.v' to AST representation.
Generating RTLIL representation for module `\_90_lut_cmp_'.
Successfully finished Verilog frontend.

2.18.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~6 debug messages>

2.19. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.20. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.21. Executing ALUMACC pass (create $alu and $macc cells).
Extracting $alu and $macc cells in module switches_to_leds:
  created 0 $alu and 0 $macc cells.

2.22. Executing OPT pass (performing simple optimizations).

2.22.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.22.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.22.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \switches_to_leds..
  Creating internal representation of mux trees.
  No muxes found in this module.
Removed 0 multiplexer ports.

2.22.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \switches_to_leds.
Performed a total of 0 changes.

2.22.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.22.6. Executing OPT_DFF pass (perform DFF optimizations).

2.22.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.22.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.22.9. Finished fast OPT passes. (There is nothing left to do.)

2.23. Executing MEMORY pass.

2.23.1. Executing OPT_MEM pass (optimize memories).
Performed a total of 0 transformations.

2.23.2. Executing OPT_MEM_PRIORITY pass (removing unnecessary memory write priority relations).
Performed a total of 0 transformations.

2.23.3. Executing OPT_MEM_FEEDBACK pass (finding memory read-to-write feedback paths).

2.23.4. Executing MEMORY_BMUX2ROM pass (converting muxes to ROMs).

2.23.5. Executing MEMORY_DFF pass (merging $dff cells to $memrd).

2.23.6. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.23.7. Executing MEMORY_SHARE pass (consolidating $memrd/$memwr cells).

2.23.8. Executing OPT_MEM_WIDEN pass (optimize memories where all ports are wide).
Performed a total of 0 transformations.

2.23.9. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.23.10. Executing MEMORY_COLLECT pass (generating $mem cells).

2.24. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.25. Executing MEMORY_LIBMAP pass (mapping memories to cells).

2.26. Executing TECHMAP pass (map to technology primitives).

2.26.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/brams_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/brams_map.v' to AST representation.
Generating RTLIL representation for module `$__ICE40_RAM4K_'.
Successfully finished Verilog frontend.

2.26.2. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/spram_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/spram_map.v' to AST representation.
Generating RTLIL representation for module `$__ICE40_SPRAM_'.
Successfully finished Verilog frontend.

2.26.3. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~4 debug messages>

2.27. Executing ICE40_BRAMINIT pass.

2.28. Executing OPT pass (performing simple optimizations).

2.28.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.28.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.28.3. Executing OPT_DFF pass (perform DFF optimizations).

2.28.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.28.5. Finished fast OPT passes.

2.29. Executing MEMORY_MAP pass (converting memories to logic and flip-flops).

2.30. Executing OPT pass (performing simple optimizations).

2.30.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.30.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.30.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \switches_to_leds..
  Creating internal representation of mux trees.
  No muxes found in this module.
Removed 0 multiplexer ports.

2.30.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \switches_to_leds.
Performed a total of 0 changes.

2.30.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.30.6. Executing OPT_DFF pass (perform DFF optimizations).

2.30.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.30.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.30.9. Finished fast OPT passes. (There is nothing left to do.)

2.31. Executing ICE40_WRAPCARRY pass (wrap carries).

2.32. Executing TECHMAP pass (map to technology primitives).

2.32.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/techmap.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/techmap.v' to AST representation.
Generating RTLIL representation for module `\_90_simplemap_bool_ops'.
Generating RTLIL representation for module `\_90_simplemap_reduce_ops'.
Generating RTLIL representation for module `\_90_simplemap_logic_ops'.
Generating RTLIL representation for module `\_90_simplemap_compare_ops'.
Generating RTLIL representation for module `\_90_simplemap_various'.
Generating RTLIL representation for module `\_90_simplemap_registers'.
Generating RTLIL representation for module `\_90_shift_ops_shr_shl_sshl_sshr'.
Generating RTLIL representation for module `\_90_shift_shiftx'.
Generating RTLIL representation for module `\_90_fa'.
Generating RTLIL representation for module `\_90_lcu_brent_kung'.
Generating RTLIL representation for module `\_90_alu'.
Generating RTLIL representation for module `\_90_macc'.
Generating RTLIL representation for module `\_90_alumacc'.
Generating RTLIL representation for module `$__div_mod_u'.
Generating RTLIL representation for module `$__div_mod_trunc'.
Generating RTLIL representation for module `\_90_div'.
Generating RTLIL representation for module `\_90_mod'.
Generating RTLIL representation for module `$__div_mod_floor'.
Generating RTLIL representation for module `\_90_divfloor'.
Generating RTLIL representation for module `\_90_modfloor'.
Generating RTLIL representation for module `\_90_pow'.
Generating RTLIL representation for module `\_90_pmux'.
Generating RTLIL representation for module `\_90_demux'.
Generating RTLIL representation for module `\_90_lut'.
Generating RTLIL representation for module `$connect'.
Generating RTLIL representation for module `$input_port'.
Successfully finished Verilog frontend.

2.32.2. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/arith_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/arith_map.v' to AST representation.
Generating RTLIL representation for module `\_80_ice40_alu'.
Successfully finished Verilog frontend.

2.32.3. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~77 debug messages>

2.33. Executing OPT pass (performing simple optimizations).

2.33.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.33.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.33.3. Executing OPT_DFF pass (perform DFF optimizations).

2.33.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.33.5. Finished fast OPT passes.

2.34. Executing ICE40_OPT pass (performing simple optimizations).

2.34.1. Running ICE40 specific optimizations.

2.34.2. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.34.3. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.34.4. Executing OPT_DFF pass (perform DFF optimizations).

2.34.5. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.34.6. Finished OPT passes. (There is nothing left to do.)

2.35. Executing DFFLEGALIZE pass (convert FFs to types supported by the target).

2.36. Executing TECHMAP pass (map to technology primitives).

2.36.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/ff_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/ff_map.v' to AST representation.
Generating RTLIL representation for module `$_DFF_N_'.
Generating RTLIL representation for module `$_DFF_P_'.
Generating RTLIL representation for module `$_DFFE_NP_'.
Generating RTLIL representation for module `$_DFFE_PP_'.
Generating RTLIL representation for module `$_DFF_NP0_'.
Generating RTLIL representation for module `$_DFF_NP1_'.
Generating RTLIL representation for module `$_DFF_PP0_'.
Generating RTLIL representation for module `$_DFF_PP1_'.
Generating RTLIL representation for module `$_DFFE_NP0P_'.
Generating RTLIL representation for module `$_DFFE_NP1P_'.
Generating RTLIL representation for module `$_DFFE_PP0P_'.
Generating RTLIL representation for module `$_DFFE_PP1P_'.
Generating RTLIL representation for module `$_SDFF_NP0_'.
Generating RTLIL representation for module `$_SDFF_NP1_'.
Generating RTLIL representation for module `$_SDFF_PP0_'.
Generating RTLIL representation for module `$_SDFF_PP1_'.
Generating RTLIL representation for module `$_SDFFCE_NP0P_'.
Generating RTLIL representation for module `$_SDFFCE_NP1P_'.
Generating RTLIL representation for module `$_SDFFCE_PP0P_'.
Generating RTLIL representation for module `$_SDFFCE_PP1P_'.
Successfully finished Verilog frontend.

2.36.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~22 debug messages>

2.37. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.38. Executing SIMPLEMAP pass (map simple cells to gate primitives).

2.39. Executing ICE40_OPT pass (performing simple optimizations).

2.39.1. Running ICE40 specific optimizations.

2.39.2. Executing OPT_EXPR pass (perform const folding).
Optimizing module switches_to_leds.

2.39.3. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\switches_to_leds'.
Computing hashes of 0 cells of `\switches_to_leds'.
Finding duplicate cells in `\switches_to_leds'.
Removed a total of 0 cells.

2.39.4. Executing OPT_DFF pass (perform DFF optimizations).

2.39.5. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \switches_to_leds..

2.39.6. Finished OPT passes. (There is nothing left to do.)

2.40. Executing TECHMAP pass (map to technology primitives).

2.40.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/latches_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/latches_map.v' to AST representation.
Generating RTLIL representation for module `$_DLATCH_N_'.
Generating RTLIL representation for module `$_DLATCH_P_'.
Successfully finished Verilog frontend.

2.40.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~4 debug messages>

2.41. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/abc9_model.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/abc9_model.v' to AST representation.
Generating RTLIL representation for module `$__ICE40_CARRY_WRAPPER'.
Successfully finished Verilog frontend.

2.42. Executing ABC9 pass.

2.42.1. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.2. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.3. Executing SCC pass (detecting logic loops).
Found 0 SCCs in module switches_to_leds.
Found 0 SCCs.

2.42.4. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.5. Executing TECHMAP pass (map to technology primitives).

2.42.5.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/techmap.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/techmap.v' to AST representation.
Generating RTLIL representation for module `\_90_simplemap_bool_ops'.
Generating RTLIL representation for module `\_90_simplemap_reduce_ops'.
Generating RTLIL representation for module `\_90_simplemap_logic_ops'.
Generating RTLIL representation for module `\_90_simplemap_compare_ops'.
Generating RTLIL representation for module `\_90_simplemap_various'.
Generating RTLIL representation for module `\_90_simplemap_registers'.
Generating RTLIL representation for module `\_90_shift_ops_shr_shl_sshl_sshr'.
Generating RTLIL representation for module `\_90_shift_shiftx'.
Generating RTLIL representation for module `\_90_fa'.
Generating RTLIL representation for module `\_90_lcu_brent_kung'.
Generating RTLIL representation for module `\_90_alu'.
Generating RTLIL representation for module `\_90_macc'.
Generating RTLIL representation for module `\_90_alumacc'.
Generating RTLIL representation for module `$__div_mod_u'.
Generating RTLIL representation for module `$__div_mod_trunc'.
Generating RTLIL representation for module `\_90_div'.
Generating RTLIL representation for module `\_90_mod'.
Generating RTLIL representation for module `$__div_mod_floor'.
Generating RTLIL representation for module `\_90_divfloor'.
Generating RTLIL representation for module `\_90_modfloor'.
Generating RTLIL representation for module `\_90_pow'.
Generating RTLIL representation for module `\_90_pmux'.
Generating RTLIL representation for module `\_90_demux'.
Generating RTLIL representation for module `\_90_lut'.
Generating RTLIL representation for module `$connect'.
Generating RTLIL representation for module `$input_port'.
Successfully finished Verilog frontend.

2.42.5.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~129 debug messages>

2.42.6. Executing OPT pass (performing simple optimizations).

2.42.6.1. Executing OPT_EXPR pass (perform const folding).

2.42.6.2. Executing OPT_MERGE pass (detect identical cells).
Removed a total of 0 cells.

2.42.6.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Removed 0 multiplexer ports.

2.42.6.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
Performed a total of 0 changes.

2.42.6.5. Executing OPT_MERGE pass (detect identical cells).
Removed a total of 0 cells.

2.42.6.6. Executing OPT_DFF pass (perform DFF optimizations).

2.42.6.7. Executing OPT_CLEAN pass (remove unused cells and wires).

2.42.6.8. Executing OPT_EXPR pass (perform const folding).

2.42.6.9. Finished fast OPT passes. (There is nothing left to do.)

2.42.7. Executing TECHMAP pass (map to technology primitives).

2.42.7.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/abc9_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/abc9_map.v' to AST representation.
Successfully finished Verilog frontend.

2.42.7.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~2 debug messages>

2.42.8. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/abc9_model.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/abc9_model.v' to AST representation.
Generating RTLIL representation for module `$__ABC9_DELAY'.
Generating RTLIL representation for module `$__ABC9_SCC_BREAKER'.
Generating RTLIL representation for module `$__DFF_N__$abc9_flop'.
Generating RTLIL representation for module `$__DFF_P__$abc9_flop'.
Successfully finished Verilog frontend.

2.42.9. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.10. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.11. Executing ABC9_OPS pass (helper functions for ABC9).
<suppressed ~2 debug messages>

2.42.12. Executing AIGMAP pass (map logic to AIG).

2.42.12.1. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.12.2. Executing ABC9_OPS pass (helper functions for ABC9).

2.42.12.3. Executing XAIGER backend.
<suppressed ~5 debug messages>
Extracted 0 AND gates and 10 wires from module `switches_to_leds' to a netlist network with 4 inputs and 4 outputs.

2.42.12.4. Executing ABC9_EXE pass (technology mapping using ABC9).

2.42.12.5. Executing ABC9.
Running ABC command: "<yosys-exe-dir>/yosys-abc" -s -f <abc-temp-dir>/abc.script 2>&1
ABC: ======== ABC command line "source <abc-temp-dir>/abc.script"
ABC: + read_lut <abc-temp-dir>/input.lut 
ABC: + read_box <abc-temp-dir>/input.box 
ABC: + &read <abc-temp-dir>/input.xaig 
ABC: + &ps 
ABC: <abc-temp-dir>/input : i/o =      4/      4  and =       0  lev =    0 (0.00)  mem = 0.00 MB  box = 0  bb = 0
ABC: + &scorr 
ABC: Warning: The network is combinational.
ABC: + &sweep 
ABC: + &dc2 
ABC: + &dch -f -r 
ABC: + &ps 
ABC: <abc-temp-dir>/input : i/o =      4/      4  and =       0  lev =    0 (0.00)  mem = 0.00 MB  ch =    0  box = 0  bb = 0
ABC: cst =       0  cls =      0  lit =       0  unused =       4  proof =     0
ABC: + &if -W 250 -v 
ABC: K = 4. Memory (bytes): Truth =    0. Cut =   52. Obj =  136. Set =  564. CutMin = no
ABC: Node =       0.  Ch =     0.  Total mem =    0.00 MB. Peak cut mem =    0.00 MB.
ABC: P:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: P:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: P:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: F:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: A:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: A:  Del =    0.00.  Ar =       0.0.  Edge =        0.  Cut =        0.  T =     0.00 sec
ABC: Total time =     0.00 sec
ABC: + &write -n <abc-temp-dir>/output.aig 
ABC: + &mfs 
ABC: Timing manager is given but there is no GIA of boxes.
ABC: Error: Abc_FrameUpdateGia(): Transformation has failed.
ABC: + &ps -l 
ABC: <abc-temp-dir>/input : i/o =      4/      4  and =       0  lev =    0 (0.00)  mem = 0.00 MB  box = 0  bb = 0
ABC: Mapping (K=0)  :  lut =      0  edge =       0  lev =    0 (0.00)  mem = 0.00 MB
ABC: LUT = 0 : Ave = 0.00
ABC: + &write -n <abc-temp-dir>/output.aig 
ABC: + time 
ABC: elapse: 0.00 seconds, total: 0.00 seconds

2.42.12.6. Executing AIGER frontend.
<suppressed ~24 debug messages>
Removed 0 unused cells and 4 unused wires.

2.42.12.7. Executing ABC9_OPS pass (helper functions for ABC9).
ABC RESULTS:           input signals:        4
ABC RESULTS:          output signals:        4
Removing temp directory.

2.42.13. Executing TECHMAP pass (map to technology primitives).

2.42.13.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/abc9_unmap.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/abc9_unmap.v' to AST representation.
Generating RTLIL representation for module `$__DFF_x__$abc9_flop'.
Generating RTLIL representation for module `$__ABC9_SCC_BREAKER'.
Successfully finished Verilog frontend.

2.42.13.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~5 debug messages>

2.43. Executing ICE40_WRAPCARRY pass (wrap carries).

2.44. Executing TECHMAP pass (map to technology primitives).

2.44.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/ff_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/ff_map.v' to AST representation.
Generating RTLIL representation for module `$_DFF_N_'.
Generating RTLIL representation for module `$_DFF_P_'.
Generating RTLIL representation for module `$_DFFE_NP_'.
Generating RTLIL representation for module `$_DFFE_PP_'.
Generating RTLIL representation for module `$_DFF_NP0_'.
Generating RTLIL representation for module `$_DFF_NP1_'.
Generating RTLIL representation for module `$_DFF_PP0_'.
Generating RTLIL representation for module `$_DFF_PP1_'.
Generating RTLIL representation for module `$_DFFE_NP0P_'.
Generating RTLIL representation for module `$_DFFE_NP1P_'.
Generating RTLIL representation for module `$_DFFE_PP0P_'.
Generating RTLIL representation for module `$_DFFE_PP1P_'.
Generating RTLIL representation for module `$_SDFF_NP0_'.
Generating RTLIL representation for module `$_SDFF_NP1_'.
Generating RTLIL representation for module `$_SDFF_PP0_'.
Generating RTLIL representation for module `$_SDFF_PP1_'.
Generating RTLIL representation for module `$_SDFFCE_NP0P_'.
Generating RTLIL representation for module `$_SDFFCE_NP1P_'.
Generating RTLIL representation for module `$_SDFFCE_PP0P_'.
Generating RTLIL representation for module `$_SDFFCE_PP1P_'.
Successfully finished Verilog frontend.

2.44.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~22 debug messages>
Removed 0 unused cells and 8 unused wires.

2.45. Executing OPT_LUT pass (optimize LUTs).
Discovering LUTs.
Number of LUTs:        0
  with \SB_CARRY    (#0)    0
  with \SB_CARRY    (#1)    0

Eliminating LUTs.
Number of LUTs:        0
  with \SB_CARRY    (#0)    0
  with \SB_CARRY    (#1)    0

Combining LUTs.
Number of LUTs:        0
  with \SB_CARRY    (#0)    0
  with \SB_CARRY    (#1)    0

Eliminated 0 LUTs.
Combined 0 LUTs.

2.46. Executing TECHMAP pass (map to technology primitives).

2.46.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ice40/cells_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/cells_map.v' to AST representation.
Generating RTLIL representation for module `$lut'.
Successfully finished Verilog frontend.

2.46.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~3 debug messages>

2.47. Executing AUTONAME pass.

2.48. Executing HIERARCHY pass (managing design hierarchy).
Attribute `top' found on module `switches_to_leds'. Setting top module to switches_to_leds.

2.48.1. Analyzing design hierarchy..
Top module:  \switches_to_leds

2.48.2. Analyzing design hierarchy..
Top module:  \switches_to_leds
Removed 0 unused modules.

2.49. Printing statistics.

=== switches_to_leds ===

        +----------Local Count, excluding submodules.
        | 
        8 wires
        8 wire bits
        8 public wires
        8 public wire bits
        8 ports
        8 port bits

2.50. Executing CHECK pass (checking for obvious problems).
Checking module switches_to_leds...
Found and reported 0 problems.

2.51. Executing JSON backend.

End of script. Logfile hash: 2d5a0d73bf, CPU: user 0.55s system 0.02s, MEM: 25.08 MB peak
Yosys 0.61+112 (git sha1 ac427a79b, clang++ 18.1.3 -fPIC -O3)
Time spent: 80% 20x read_verilog (0 sec), 4% 1x abc9_exe (0 sec), ...
</code>
</details>
### Place and Route
#### Command
```
nextpnr-ice40 --hx1k --json switches_to_leds.json --pcf ../common/goboard.pcf --package vq100 --asc switches_to_leds.asc
```
#### Output
<details>
<summary>see output</summary>
Note: I have a warning from an extra constraint defined in my pcf that isn't used in this design.
<code>
Info: constrained 'o_LED_1' to bel 'X13/Y6/io1'
Info: constrained 'o_LED_2' to bel 'X13/Y7/io0'
Info: constrained 'o_LED_3' to bel 'X13/Y7/io1'
Info: constrained 'o_LED_4' to bel 'X13/Y8/io0'
Info: constrained 'i_Switch_1' to bel 'X13/Y4/io1'
Info: constrained 'i_Switch_2' to bel 'X13/Y3/io1'
Info: constrained 'i_Switch_3' to bel 'X13/Y6/io0'
Info: constrained 'i_Switch_4' to bel 'X13/Y4/io0'
Warning: unmatched constraint 'i_Clk' (on line 11)

Info: Packing constants..
Info: Packing IOs..
Info: Packing LUT-FFs..
Info:        0 LCs used as LUT4 only
Info:        0 LCs used as LUT4 and DFF
Info: Packing non-LUT FFs..
Info:        0 LCs used as DFF only
Info: Packing carries..
Info:        0 LCs used as CARRY only
Info: Packing indirect carry+LUT pairs...
Info:        0 LUTs merged into carry LCs
Info: Packing RAMs..
Info: Placing PLLs..
Info: Packing special functions..
Info: Packing PLLs..
Info: Promoting globals..
Info: Constraining chains...
Info:        0 LCs used to legalise carry chains.
Info: Checksum: 0x9545f763

Info: Device utilisation:
Info:            ICESTORM_LC:       1/   1280     0%
Info:           ICESTORM_RAM:       0/     16     0%
Info:                  SB_IO:       8/    112     7%
Info:                  SB_GB:       0/      8     0%
Info:           ICESTORM_PLL:       0/      1     0%
Info:            SB_WARMBOOT:       0/      1     0%

Info: Placed 8 cells based on constraints.
Info: Creating initial analytic placement for 0 cells, random placement wirelen = 11.
Info:     at initial placer iter 0, wirelen = 11
Info:     at initial placer iter 1, wirelen = 11
Info:     at initial placer iter 2, wirelen = 11
Info:     at initial placer iter 3, wirelen = 11
Info: Running main analytical placer, max placement attempts per cell = 10000.
Info: HeAP Placer Time: 0.00s
Info:   of which solving equations: 0.00s
Info:   of which spreading cells: 0.00s
Info:   of which strict legalisation: 0.00s

Info: Running simulated annealing placer for refinement.
Info:   at iteration #1: temp = 0.000000, timing cost = 0, wirelen = 11
Info:   at iteration #2: temp = 0.000000, timing cost = 0, wirelen = 11 
Info: SA placement time 0.00s

Info: No Fmax available; no interior timing paths found in design.
Info: Checksum: 0x723b106a

Info: Routing..
Info: Setting up routing queue.
Info: Routing 4 arcs.
Info:            |   (re-)routed arcs  |   delta    | remaining|       time spent     |
Info:    IterCnt |  w/ripup   wo/ripup |  w/r  wo/r |      arcs| batch(sec) total(sec)|
Info:          4 |        0          4 |    0     4 |         0|       0.02       0.02|
Info: Routing complete.
Info: Router1 time 0.02s
Info: Checksum: 0x49584b87

Info: Critical path report for cross-domain path '<async>' -> '<async>':
Info:       type curr  total name
Info:     source  0.00  0.00 Source i_Switch_2$sb_io.D_IN_0
Info:    routing  1.59  1.59 Net o_LED_2$SB_IO_OUT (13,3) -> (13,7)
Info:                          Sink o_LED_2$sb_io.D_OUT_0
Info: 0.00 ns logic, 1.59 ns routing

Info: No Fmax available; no interior timing paths found in design.
1 warning, 0 errors

Info: Program finished normally.
</code>
</details>
### Pack
#### Command
```
icepack switches_to_leds.asc switches_to_leds.bin
```
#### Output
No output from this command.

### Program
Make sure your Go Board is connected with a microusb cable that supports data before doing this.
#### Command
```
sudo iceprog switches_to_leds.bin
```
#### Output
<details>
<summary>see output</summary>
<code>
init..
cdone: high
reset..
cdone: low
flash ID: 0x20 0x20 0x11 0x00
file size: 32220
erase 64kB sector at 0x000000..
programming..
done.                 
reading..
VERIFY OK             
cdone: high
Bye.
</code>
</details>

## Try it out!
Should be working the same as it did when done using the proprietary toolchain.
