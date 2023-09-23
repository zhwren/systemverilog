{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__

`timescale {{cfg.timescale}}

`include "uvm_macros.svh"
import uvm_pkg::*;

module harness;
    logic clk;
    logic rst_n;
    logic before_reset;

    virtual {{cfg.proj}}_{{cfg.module}}_intf top_vif;
    {{cfg.proj}}_{{cfg.module}}_intf         top_if(clk, rst_n);

    `include "../th/module_inst.sv"

    initial begin
        top_vif = top_if;
        uvm_config_db#(virtual {{cfg.proj}}_{{cfg.module}}_intf)::set(null, "*env", "top_vif", top_vif);
        `ifdef DUMP_FSDB
            $fsdbDumpfile("t.fsdb");
            $fsdbDumpvars(0);
        `endif
        run_test();
    end

endmodule

`endif
