{{cfg.header}}

`ifndef __{{agent.name|upper}}_SEQUENCE_SV__
`define __{{agent.name|upper}}_SEQUENCE_SV__

class {{agent.name}}_sequence extends uvm_sequence #({{agent.name}}_xaction);
    `uvm_object_utils({{agent.name}}_sequence)

    extern function new(string name="{{agent.name}}_sequence");
    extern virtual task body();
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_sequence::new(string name="{{agent.name}}_sequence");
    super.new(name);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_sequence::body();
endtask

`endif
