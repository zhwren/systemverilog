{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TC_BASE_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TC_BASE_SV__

class {{cfg.proj}}_{{cfg.module}}_tc_base extends uvm_test;
    uvm_report_server svr;
    {{cfg.proj}}_{{cfg.module}}_env env;

    `uvm_component_utils_begin({{cfg.proj}}_{{cfg.module}}_tc_base)
    `uvm_component_utils_end

    extern function new(string name="tc_base", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task reset_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
    extern virtual function void pre_abort();

    extern task gen_clk();
    extern task gen_reset();
endclass

function {{cfg.proj}}_{{cfg.module}}_tc_base::new(string name="tc_base", uvm_component parent=null);
    super.new(name, parent);
endfunction

function void {{cfg.proj}}_{{cfg.module}}_tc_base::build_phase(uvm_phase phase);
    super.build_phase(phase);

    svr = uvm_report_server::get_server();
    svr.set_max_quit_count(plus_{{cfg.proj}}_{{cfg.module}}::stop_error_cnt);
    env = {{cfg.proj}}_{{cfg.module}}_env::type_id::create("env", this);
endfunction

task {{cfg.proj}}_{{cfg.module}}_tc_base::run_phase(uvm_phase phase);
    fork
        gen_clk();
        gen_reset();
        super.run_phase(phase);
    join
endtask

task {{cfg.proj}}_{{cfg.module}}_tc_base::gen_clk();
    harness.clk = $urandom();

    while (1) begin
        #({{cfg.half_clk}});
        harness.clk = ~harness.clk;
    end
endtask

task {{cfg.proj}}_{{cfg.module}}_tc_base::gen_reset();
    harness.before_reset = 1'b1;
    harness.rst_n = $urandom();

    #({{cfg.half_clk}} * $urandom_range(10, 100));
    harness.rst_n = 1'b0;
    #({{cfg.half_clk}} * $urandom_range(10, 100));
    harness.rst_n = 1'b1;
    harness.before_reset = 1'b0;
endtask

task {{cfg.proj}}_{{cfg.module}}_tc_base::reset_phase(uvm_phase phase);
    fork
        super.reset_phase(phase);
    join_none

    phase.raise_objection(this);
    wait (harness.before_reset = 1'b0);
    phase.drop_objection(this);
endtask

task {{cfg.proj}}_{{cfg.module}}_tc_base::main_phase(uvm_phase phase);
    fork
        super.main_phase(phase);
    join_none

    phase.phase_done.set_drain_time(this, 100);
endtask

function void {{cfg.proj}}_{{cfg.module}}_tc_base::report_phase(uvm_phase phase);
    pre_abort();
endfunction

function void {{cfg.proj}}_{{cfg.module}}_tc_base::pre_abort();
    if (svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR)) begin
        `uvm_info(get_name(), "\nTestCase: Failed!", UVM_NONE);
    end else begin
        `uvm_info(get_name(), "\nTestCase: Passed!", UVM_NONE);
    end
endfunction

`endif
