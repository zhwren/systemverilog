target := simv
.PHONY : all clean run

all : ${target}

OPTS := -timescale={{cfg.timescale}}
OPTS += +define+DUMP_FSDB -debug_access+all +define+{{cfg.proj|upper}}_{{cfg.module|upper}}_BT

${target} :
	vcs -full64 -sverilog -cm line+cond+fsm -${UVM_HOME}/src/dpi/uvm_dpi.cc \
		-CFLAGS -DVCS -ntb_opts uvm +incdir+${UVM_HOME}/src \
		${UVM_HOME}/src/uvm_pkg.sv -f ../cfg/tb.f ${OPTS} -l compile.log

clean :
	rm -rf simv* csrc vc_hdrs.h ucli.key

orun : ${target}
	./simv +UVM_TESTNAME={{cfg.proj}}_{{cfg.module}}_tc_base -l run.log

run :
	make clean
	make orun

verdi :
	verdi -nologo +v2k +libext+.v+.vh -sv -ntb_opts uvm-1.2 -f ../cfg/tb.f &
