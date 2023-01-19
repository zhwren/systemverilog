{{fhead}}

`ifndef __{{intf|upper}}_XACTION_SV__
`define __{{intf|upper}}_XACTION_SV__

class {{intf}}_xaction extends uvm_sequence_item;

{% for field in cfg.agent[intf]["field"] %}
    rand bit [{{intf}}_dec::{{"%-20s"|format([field,"_WIDTH"]|join|upper)}}-1:0] {{field}};
{% endfor %}

    `uvm_object_utils_begin({{intf}}_xaction)
{% for field in cfg.agent[intf]["field"] %}
        `uvm_field_int({{field}}, UVM_ALL_ON | UVM_NOPACK)
{% endfor %}
    `uvm_object_utils_end

{% for field in cfg.agent[intf]["field"] %}
    constraint {{field}}_constrant;
{% endfor %}

    extern function new(string name="{{intf}}_xaction");
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_xaction::new(string name="{{intf}}_xaction");
    super.new(name);
endfunction

{% for field in cfg.agent[intf]["field"] %}
/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
constraint {{intf}}_xaction::{{field}}_constrant {
    {{field}} dist {
        0 := plus_{{intf}}::{{field}}_wt_min,
        [1:2**{{intf}}_dec::{{field|upper}}_WIDTH-2] := plus_{{intf}}::{{field}}_wt_mid,
        2**{{intf}}_dec::{{field|upper}}_WIDTH-1 := plus_{{intf}}::{{field}}_wt_max
    };
}

{% endfor %}

`endif
