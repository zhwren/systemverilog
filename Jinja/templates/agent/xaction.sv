{{cfg.header}}

`ifndef __{{agent.name|upper}}_XACTION_SV__
`define __{{agent.name|upper}}_XACTION_SV__

class {{agent.name}}_xaction extends uvm_sequence_item;

{% for field in agent.fields %}
    rand bit [{{agent.name}}_dec::{{"%-20s"|format(field.name|upper + "_WIDTH")}}-1:0] {{field.name}};
{% endfor %}

    `uvm_object_utils_begin({{agent.name}}_xaction);
{% for field in agent.fields %}
        `uvm_field_int({{"%-15s"|format(field.name+",")}} UVM_ALL_ON|UVM_NOPACK)
{% endfor %}
    `uvm_object_utils_end

{% for field in agent.fields %}
    constraint {{field.name}}_constraint;
{% endfor %}

    extern function new(string name="{{agent.name}}_xaction");
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_xaction::new(string name="{{agent.name}}_xaction");
    super.new(name);
endfunction

{% for field in agent.fields %}
/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
constraint {{agent.name}}_xaction::{{field.name}}_constraint {
    {{field.name}} dist {
        0 := plus_{{agent.name}}::{{field.name}}_wt_min,
{% if field.width > 1 %}
        [1:2**{{agent.name}}_dec::{{field.name|upper}}_WIDTH-2] := plus_{{agent.name}}::{{field.name}}_wt_mid,
{% endif %}
        2**{{agent.name}}_dec::{{field.name|upper}}_WIDTH-1 := plus_{{agent.name}}::{{field.name}}_wt_max
    };
}

{% endfor %}

`endif
