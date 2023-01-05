/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_xaction.sv
** Discription  : {{ifname}} transaction declare    
***************************************************************/
`ifndef __{{ifname|upper}}_XACTION_SV__
`define __{{ifname|upper}}_XACTION_SV__

class {{ifname}}_xaction extends uvm_sequence_item;

{% for fieldname in fields.keys() %}
    rand bit [{{ifname}}_dec::{{"%-20s"|format(fieldname.upper() + "_WIDTH")}}-1:0] {{fieldname}};
{% endfor %}

    `uvm_object_utils_begin({{ifname}}_xaction)
{% for fieldname in fields.keys() %}
        `uvm_field_int({{fieldname}}, UVM_ALL_ON | UVM_NOPACK)
{% endfor %}
    `uvm_object_utils_end

    extern function new(string name="{{ifname}}_xaction");
endclass

/**************************************************************
** Time        : {{time}}
** Author      : generator                                     
** Description : Create                                        
**************************************************************/
function {{ifname}}_xaction::new(string name="{{ifname}}_xaction");
    super.new(name);
endfunction

`endif
