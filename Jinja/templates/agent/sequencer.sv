{{fhead}}

`ifndef __{{intf|upper}}_SEQUENCER_SV__
`define __{{intf|upper}}_SEQUENCER_SV__

class {{intf}}_sequencer extends uvm_sequencer #({{intf}}_xaction);
    `uvm_component_utils_begin({{intf}}_sequencer)
    `uvm_component_utils_end

    extern function new(string name="{{intf}}_sequencer", uvm_component parent=null);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_sequencer::new(string name="{{intf}}_sequencer", uvm_component parent=null);
    super.new(name, parent);
endfunction

`endif
