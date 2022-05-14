# simple-calculator-architecture-vhdl

### Make

```bash
$ make 			# to compile project
$ make {FLAGS}	# to compile and set custom properties
$ make clean	# to remove junk files
$ make ENV=true TIME=20ns VCD=test.vcd	# e.g
```
#### FLAGS
All flags have a default value, this can be seen in the `src/Makefile` file.

1. `ENV={true/false}`: 	Enable open and view waves file
2. `TIME={e.g. 100ns}`: Set custom time for simulation
3. `VCD={name.vcd}`:	Set custom file name for waves file

### Project structure
```
.
├── doc
|   └── Documentation and manual files
├── mem
|   └── Memory files
├── asm
|   └── Assembler files
├── src
|   └── VHDL files
├── ss
|   └── Screenshoots
├── vcd
|   └── Wave files
└── decoder
    └── Custom assmebler decoder
```
