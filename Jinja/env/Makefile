target := simv
.PHONY : all clean run

all : ${target}

UTILS :=
{% for agt in cfg.env.keys() %}
UTILS += -F ../utils/{{agt}}/{{agt}}_filelist.f
{% endfor %}

TOP := {{cfg.proj_name}}_{{cfg.module_name}}_top.sv
RTL := -F ../rtl/design.f
ENV := -f {{cfg.proj_name}}_{{cfg.module_name}}_filelist.f

${target} : ${TOP}
	vcs -full64 -sverilog -cm line+cond+fsm -${UVM_HOME}/src/dpi/uvm_dpi.cc \
	    -CFLAGS -DVCS -ntb_opts uvm -fsdb +incdir+${UVM_HOME}/src \
	    ${UVM_HOME}/src/uvm_pkg.sv ${UTILS} ${ENV} ${RTL} ${TOP}

clean :
	/bin/rm -rf simv* csrc vc_hdrs.h ucli.key

run :
	./simv +UVM_TESTNAME={{cfg.proj_name}}_{{cfg.module_name}}_env
