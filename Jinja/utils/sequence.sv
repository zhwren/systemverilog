/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_sequence.sv
** Discription  : {{ifname}} sequence declare    
***************************************************************/
`ifndef __{{ifname|upper}}_SEQUENCE_SV__
`define __{{ifname|upper}}_SEQUENCE_SV__

class {{ifname}}_sequence extends uvm_sequence #({{ifname}}_xaction);
    `uvm_object_utils_begin({{ifname}}_sequence)
    `uvm_object_utils_end

    extern function new(string name="{{ifname}}_sequence");
    extern virtual task body();
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{ifname}}_sequence::new(string name="{{ifname}}_sequence");
    super.new(name);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{ifname}}_sequence::body();
endtask

`endif
