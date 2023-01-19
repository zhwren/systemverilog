{{fhead}}

`ifndef __{{intf|upper}}_SEQUENCE_SV__
`define __{{intf|upper}}_SEQUENCE_SV__

class {{intf}}_sequence extends uvm_sequence #({{intf}}_xaction);
    `uvm_object_utils_begin({{intf}}_sequence)
    `uvm_object_utils_end

    extern function new(string name="{{intf}}_sequence");
    extern virtual task body();
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_sequence::new(string name="{{intf}}_sequence");
    super.new(name);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{intf}}_sequence::body();
endtask

`endif
