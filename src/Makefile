########################
#		VARIABLES
########################
CC=ghdl
TIME=100ns
VCD=waves.vcd
M=./modules
BFF=buffers

########################
# 		IEEE FLAGS
########################
ENF=true
FLAGS=--ieee=synopsys
ifeq ( ${ENF}, false )
	FLAGS=
endif

########################
# 		GTKWAVE VIEW
########################
ENV=false
VIEW=
ifeq ( ${ENV}, true )
	VIEW=gtkwave ${VCD}
endif

########################
# 			MAIN
########################
all: main

main: modules.o test_bench.o
	${CC} -e ${FLAGS} test_bench 
	${CC} -r ${FLAGS} test_bench --stop-time=${TIME} --vcd=${VCD}
	gtkwave ${VCD}

test_bench.o: test_bench.vhdl
	${CC} -a ${FLAGS} test_bench.vhdl

modules.o: buffers.o ${M}/*.vhdl
	${CC} -a ${FLAGS} ${M}/*.vhdl

buffers.o: ${M}/${BFF}/*.vhdl
	${CC} -a ${M}/${BFF}/*.vhdl

# Clean command
clean:
	rm -r *.cf *.vcd