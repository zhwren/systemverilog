{{cfg.header}}

`ifndef __{{agent.name|upper}}_PKG_SV__
`define __{{agent.name|upper}}_PKG_SV__

`include "{{agent.name}}_dec.sv"
`include "{{agent.name}}_interface.sv"

package {{agent.name}}_pkg;
    import uvm_pkg::*;
    import common_pkg::*;

    `include "{{agent.name}}_plus.sv"
    `include "{{agent.name}}_xaction.sv"
    `include "{{agent.name}}_sequence.sv"
    `include "{{agent.name}}_sequencer.sv"
    `include "{{agent.name}}_monitor.sv"
    `include "{{agent.name}}_driver.sv"
    //`include "{{agent.name}}_cov.sv"
    `include "{{agent.name}}_agent.sv"
endpackage
import {{agent.name}}_pkg::*;

`endif
