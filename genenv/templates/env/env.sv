{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__

class {{cfg.proj}}_{{cfg.module}}_env extends uvm_env;
    int inst_id;
    uvm_active_passive_enum is_active;
    virtual {{cfg.proj}}_{{cfg.module}}_intf top_vif;

{% for agent in cfg.agents %}
    {{"%-20s"|format([agent.name,"_agent"]|join)}} {{agent.name}}_agt[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}
{% for agent in cfg.internal_agents %}
    {{"%-20s"|format([cfg.proj, agent.name,"env"]|join("_"))}} {{cfg.proj}}_{{agent.name}}_sub_env[{{cfg.proj}}_{{cfg.module}}_dec::{{cfg.proj|upper}}_{{agent.name|upper}}_ENV_NUM];
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
    inst_id = 0;
    is_active = UVM_ACTIVE;
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env::build_phase(uvm_phase phase);
    int id;

    e2e = {{cfg.proj}}_{{cfg.module}}_e2e::type_id::create("e2e", this);
    e2e.inst_id = this.inst_id;

    if (is_active == UVM_ACTIVE) begin
        model = {{cfg.proj}}_{{cfg.module}}_model::type_id::create("model", this);
    end

    if (!uvm_config_db#(virtual {{cfg.proj}}_{{cfg.module}}_intf)::get(this, "", "top_vif", top_vif)) begin
        `uvm_fatal(get_name(), $sformatf("{{cfg.proj}}_{{cfg.module}}_top_vif is null!"));
    end
{% for agent in cfg.agents %}

    foreach ({{agent.name}}_agt[i]) begin
        id = inst_id * {{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM + i;
        {{agent.name}}_agt[i] = {{agent.name}}_agent::type_id::create($sformatf("{{agent.name}}_%0d", id), this);
        {{agent.name}}_agt[i].inst_id = id;
{% if agent.inst_type == "master" %}
        {{agent.name}}_agt[i].is_active = (is_active == UVM_ACTIVE) ? UVM_ACTIVE : UVM_PASSIVE;
{% else %}
        {{agent.name}}_agt[i].is_active = UVM_PASSIVE;
{% endif %}
        uvm_config_db#(virtual {{agent.name}}_intf)::set(this, $sformatf("{{agent.name}}_%0d.*", id), "{{agent.name}}_intf", top_vif.{{agent.name}}_vif[i]);
    end
{% endfor %}
{% for agent in cfg.internal_agents %}

    foreach ({{cfg.proj}}_{{agent.name}}_sub_env[i]) begin
        id = inst_id * {{cfg.proj}}_{{cfg.module}}_dec::{{cfg.proj|upper}}_{{agent.name|upper}}_ENV_NUM + i;
        {{cfg.proj}}_{{agent.name}}_sub_env[i] = {{cfg.proj}}_{{agent.name}}_env::type_id::create($sformatf("{{cfg.proj}}_{{agent.name}}_sub_env_%0d", id), this);
        {{cfg.proj}}_{{agent.name}}_sub_env[i].inst_id = id;
        {{cfg.proj}}_{{agent.name}}_sub_env[i].is_active = UVM_PASSIVE;
        uvm_config_db#(virtual {{cfg.proj}}_{{agent.name}}_intf)::set(this, $sformatf("{{cfg.proj}}_{{agent.name}}_sub_env_%0d", id), "top_vif", top_vif.{{cfg.proj}}_{{agent.name}}_env_vif[i]);
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
    if (is_active == UVM_PASSIVE) begin
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
