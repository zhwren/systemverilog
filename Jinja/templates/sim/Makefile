target := simv
.PHONY : all clean run

all : ${target}

OPTS := -timescale={{cfg.timescale}}
OPTS += +define+DUMP_FSDB -debug_access+all

${target} :
	vcs -full64 -sverilog -cm line+cond+fsm -${UVM_HOME}/src/dpi/uvm_dpi.cc \
		-CFLAGS -DVCS -ntb_opts uvm -fsdb +incdir+${UVM_HOME}/src \
		${UVM_HOME}/src/uvm_pkg.sv -f ../cfg/tb.f ${OPTS}

clean :
	rm -rf simv* csrc vc_hdrs.h ucli.key

run : ${target}
	./simv +UVM_TESTNAME={{cfg.proj}}_{{cfg.module}}_tc_base
