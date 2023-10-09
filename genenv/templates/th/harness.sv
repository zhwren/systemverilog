{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__

`timescale {{cfg.timescale}}

`include "uvm_macros.svh"
import uvm_pkg::*;

module harness;
    logic clk, rst_n, before_reset;

    virtual {{cfg.proj}}_{{cfg.module}}_intf top_vif;
    {{cfg.proj}}_{{cfg.module}}_intf         top_if(clk, rst_n);

    `include "../th/module_inst.sv"

{% for agent in cfg.subenvs %}
    `include "../../bt/{{agent.name}}/th/module_inst.sv"
{% for i in range(agent.inst_num) %}
    `{{cfg.proj|upper}}_{{agent.name|upper}}_TOP_CONNECT(top_if.{{cfg.proj}}_{{agent.name}}_env_if[{{i}}], u_{{cfg.module}}.u_{{agent.name}}_{{i}});
{% endfor %}

{% endfor %}
    initial begin
        top_vif = top_if;
        uvm_config_db#(virtual {{cfg.proj}}_{{cfg.module}}_intf)::set(null, "uvm_test_top.env", "top_vif", top_vif);
        `ifdef DUMP_FSDB
            $fsdbDumpfile("t.fsdb");
            $fsdbDumpvars(0);
        `endif
        run_test();
    end

endmodule

`endif
