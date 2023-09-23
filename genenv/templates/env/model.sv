{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODEL_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODEL_SV__

class {{cfg.proj}}_{{cfg.module}}_model extends uvm_component;

{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}
    {{"%-20s"|format(agent.name+"_sequence")}} {{agent.name}}_seq[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
    {{"%-20s"|format(agent.name+"_sequencer")}} {{agent.name}}_sqr[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endif %}
{% endfor %}

    `uvm_component_utils({{cfg.proj}}_{{cfg.module}}_model)

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_model", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);

{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}
    extern task {{agent.name}}_input_process(int intf_id);
{% endif %}
{% endfor %}
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_model::new(string name="{{cfg.proj}}_{{cfg.module}}_model", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}

    foreach ({{agent.name}}_seq[i]) begin
        {{agent.name}}_seq[i] = new($sformatf("{{agent.name}}_seq_%0d", i));
    end
{% endif %}
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_model::main_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}
        for (int i = 0; i < {{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM; i++) begin
            automatic int intf_id = i;
            fork
                {{agent.name}}_input_process(intf_id);
            join_none
        end

{% endif %}
{% endfor %}
    join
    phase.drop_objection(this);
endtask

{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}
/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_model::{{agent.name}}_input_process(int intf_id);
    {{agent.name}}_xaction tr = new();
    tr.set_sequencer({{agent.name}}_sqr[intf_id]);

    repeat (100) begin
        tr.randomize();
        {{agent.name}}_seq[intf_id].start_item(tr);
        {{agent.name}}_seq[intf_id].finish_item(tr);
    end
endtask

{% endif %}
{% endfor %}
`endif
