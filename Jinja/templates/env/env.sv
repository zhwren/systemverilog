{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__

class {{cfg.proj}}_{{cfg.module}}_env extends uvm_env;
    virtual {{cfg.proj}}_{{cfg.module}}_intf top_vif;
{% for agent in cfg.agents %}
    {{"%-20s"|format([agent.name,"_agent"]|join)}} {{agent.name}}_agt[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}
{% for agent in cfg.internal_agents %}
    {{"%-20s"|format([cfg.proj, agent.name,"env"]|join("_"))}} sub_{{agent.name}}_env[{{cfg.proj}}_{{cfg.module}}_dec::SUB_{{agent.name|upper}}_NUM];
{% endfor %}
    {{"%-20s"|format([cfg.proj,cfg.module,"model"]|join("_"))}} model;

    `uvm_component_utils({{cfg.proj}}_{{cfg.module}}_env)

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_env", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_env::new(string name="{{cfg.proj}}_{{cfg.module}}_env", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env::build_phase(uvm_phase phase);
    model = {{cfg.proj}}_{{cfg.module}}_model::type_id::create("model", this);
    if (!uvm_config_db#(virtual {{cfg.proj}}_{{cfg.module}}_intf)::get(this, "", "top_vif", top_vif)) begin
        `uvm_fatal(get_name(), $sformatf("{{cfg.proj}}_{{cfg.module}}_top_vif is null!"));
    end
{% for agent in cfg.agents %}

    foreach ({{agent.name}}_agt[i]) begin
        {{agent.name}}_agt[i] = {{agent.name}}_agent::type_id::create($sformatf("{{agent.name}}_%0d", i), this);
        {{agent.name}}_agt[i].intf_id = i;
{% if agent.inst_type == "master" %}
        {{agent.name}}_agt[i].is_active = UVM_ACTIVE;
{% else %}
        {{agent.name}}_agt[i].is_active = UVM_PASSIVE;
{% endif %}
        uvm_config_db#(virtual {{agent.name}}_intf)::set(this, $sormatf("{{agent.name}}_%0d.*", i), "{{agent.name}}_intf", top_vif.{{agent.name}}_vif[i]);
    end
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
{% for agent in cfg.agents %}
{% if agent.inst_type == "master" %}

    foreach (model.{{agent.name}}_sqr[i]) begin
        model.{{agent.name}}_sqr[i] = {{agent.name}}_agt[i].sqr;
    end
{% endif %}
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_env::main_phase(uvm_phase phase);
endtask

`endif
