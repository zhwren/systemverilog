{{fhead}}

`ifndef __{{intf|upper}}_PKG_SV__
`define __{{intf|upper}}_PKG_SV__

`include "{{intf}}_dec.sv"
`include "{{intf}}_interface.sv"

package {{intf}}_pkg;
    import uvm_pkg::*;
    `include "{{intf}}_plus.sv"
    `include "{{intf}}_xaction.sv"
    `include "{{intf}}_sequence.sv"
    `include "{{intf}}_sequencer.sv"
    `include "{{intf}}_monitor.sv"
    `include "{{intf}}_driver.sv"
    `include "{{intf}}_cov.sv"
    `include "{{intf}}_agent.sv"
endpackage
import {{intf}}_pkg::*;

`endif
