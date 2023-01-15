target := simv
.PHONY : all clean run

all : ${target}

UTILS := -F /home/zhwren/Workfs/systemverilog/Jinja/common/common_flist.f
{% for agent in cfg.agent.keys() %}
UTILS += -F ../agent/{{agent}}/{{agent}}_flist.f
{% endfor %}

TOP := ../tb/testbench.sv
#RTL := -F ../rtl/design.f
ENV := -F ../env/{{cfg.proj}}_{{cfg.module}}_flist.f

${target} : ${TOP}
	vcs -full64 -sverilog -cm line+cond+fsm -${UVM_HOME}/src/dpi/uvm_dpi.cc \
	    -CFLAGS -DVCS -ntb_opts uvm -fsdb +incdir+${UVM_HOME}/src \
	    ${UVM_HOME}/src/uvm_pkg.sv ${UTILS} ${ENV} ${RTL} ${TOP}

clean :
	/bin/rm -rf simv* csrc vc_hdrs.h ucli.key

run :
	./simv +UVM_TESTNAME={{cfg.proj}}_{{cfg.module}}_env
