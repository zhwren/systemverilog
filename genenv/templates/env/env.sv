{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__

class {{cfg.proj}}_{{cfg.module}}_env extends uvm_env;
    {{cfg.proj}}_{{cfg.module}}_env_cfg cfg;

{% for agent in cfg.agents %}
    {{"%-20s"|format([agent.name,"_agent"]|join)}} {{agent.name}}_agt[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}
{% for agent in cfg.subenvs %}
    {{"%-20s"|format([cfg.proj, agent.name,"env"]|join("_"))}} sub_{{cfg.proj}}_{{agent.name}}_env[{{cfg.proj}}_{{cfg.module}}_dec::{{cfg.proj|upper}}_{{agent.name|upper}}_ENV_NUM];
{% endfor %}
    {{"%-20s"|format([cfg.proj,cfg.module,"model"]|join("_"))}} model;
    {{"%-20s"|format([cfg.proj,cfg.module,"e2e"]|join("_"))}} e2e;

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
    if (cfg == null) begin
        `uvm_fatal(get_name(), $sformatf("{{cfg.proj}}_{{cfg.module}}_env_cfg is null!"));
    end

    e2e = {{cfg.proj}}_{{cfg.module}}_e2e::type_id::create("e2e", this);
    e2e.inst_id = cfg.inst_id;

    if (cfg.is_active == UVM_ACTIVE) begin
        model = {{cfg.proj}}_{{cfg.module}}_model::type_id::create("model", this);
    end
{% for agent in cfg.agents %}

    foreach ({{agent.name}}_agt[i]) begin
        {{agent.name}}_agt[i] = {{agent.name}}_agent::type_id::create($sformatf("{{agent.name}}_%0d", i), this);
        {{agent.name}}_agt[i].cfg = cfg.{{agent.name}}_agt_cfg[i];
    end
{% endfor %}
{% for agent in cfg.subenvs %}

    foreach (sub_{{cfg.proj}}_{{agent.name}}_env[i]) begin
        sub_{{cfg.proj}}_{{agent.name}}_env[i] = {{cfg.proj}}_{{agent.name}}_env::type_id::create($sformatf("{{cfg.proj}}_{{agent.name}}_sub_env_%0d", i), this);
        sub_{{cfg.proj}}_{{agent.name}}_env[i].cfg = cfg.sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i];
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
    if (cfg.is_active == UVM_PASSIVE) begin
        return;
    end
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
