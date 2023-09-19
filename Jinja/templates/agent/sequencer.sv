{{cfg.header}}

`ifndef __{{agent.name|upper}}_SEQUENCER_SV__
`define __{{agent.name|upper}}_SEQUENCER_SV__

class {{agent.name}}_sequencer extends uvm_sequencer #({{agent.name}}_xaction);
    `uvm_component_utils({{agent.name}}_sequencer)

    extern function new(string name="{{agent.name}}_sequencer", uvm_component parent=null);
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_sequencer::new(string name="{{agent.name}}_sequencer", uvm_component parent=null);
    super.new(name, parent);
endfunction

`endif
