/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_top.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} top declare
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_TOP_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_TOP_SV__

`include "uvm_macros.svh"
import uvm_pkg::*;

module {{cfg.proj_name}}_{{cfg.module_name}}_top;
    logic clk;
    logic rst_n;

{% for agt in cfg.env.keys() %}
    virtual {{"%-20s"|format(agt + "_intf")}} {{agt}}_vif[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM];
{% endfor %}

{% for agt in cfg.env.keys() %}
    {{"%-28s"|format(agt + "_intf")}} {{agt}}_if[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM](clk, rst_n);
{% endfor %}

    initial begin
{% for agt in cfg.env.keys() %}
        {{agt}}_vif = {{agt}}_if;
        foreach ({{agt}}_vif[i]) begin
            uvm_config_db#(virtual {{agt}}_intf)::set(null, "*", $sformatf("{{agt}}_intf_%0d", i), {{agt}}_vif[i]);
        end
{% endfor %}
    end

    initial begin
        clk   = 1'b0;
        rst_n = 1'b0;
        #1000;
        rst_n = 1'b1;
        #5000;
        $finish;
    end

    always #1 clk = ~clk;

    initial begin
        $fsdbDumpfile("t.fsdb");
        $fsdbDumpvars(0);
        run_test();
    end

endmodule

`endif
