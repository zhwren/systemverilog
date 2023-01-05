/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_sequencer.sv
** Discription  : {{ifname}} sequencer declare    
***************************************************************/
`ifndef __{{ifname|upper}}_SEQUENCER_SV__
`define __{{ifname|upper}}_SEQUENCER_SV__

class {{ifname}}_sequencer extends uvm_sequencer #({{ifname}}_xaction);
    `uvm_component_utils_begin({{ifname}}_sequencer)
    `uvm_component_utils_end

    extern function new(string name="{{ifname}}_sequencer", uvm_component parent=null);
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{ifname}}_sequencer::new(string name="{{ifname}}_sequencer", uvm_component parent=null);
    super.new(name, parent);
endfunction

`endif
