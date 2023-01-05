/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_pkg.sv
** Discription  : {{ifname}} agent package declare    
***************************************************************/
`ifndef __{{ifname|upper}}_PKG_SV__
`define __{{ifname|upper}}_PKG_SV__

`include "{{ifname}}_dec.sv"
`include "{{ifname}}_interface.sv"

package {{ifname}}_pkg;
    import uvm_pkg::*;
    `include "{{ifname}}_xaction.sv"
    `include "{{ifname}}_sequence.sv"
    `include "{{ifname}}_sequencer.sv"
    `include "{{ifname}}_monitor.sv"
    `include "{{ifname}}_driver.sv"
    `include "{{ifname}}_agent.sv"
endpackage
import {{ifname}}_pkg::*;

`endif
