{{fhead}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_EVN_SV__

class {{cfg.proj}}_{{cfg.module}}_env extends uvm_env;

{% for agent in cfg.agent.keys() %}
    {{"%-20s"|format([agent,"_agent"]|join)}} {{agent}}_agt[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
{% endfor %}
    {{cfg.proj}}_{{cfg.module}}_model model;

    `uvm_component_utils_begin({{cfg.proj}}_{{cfg.module}}_env)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_env", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_env::new(string name="{{cfg.proj}}_{{cfg.module}}_env", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env::build_phase(uvm_phase phase);
    model = {{cfg.proj}}_{{cfg.module}}_model::type_id::create("model", this);
{% for agent in cfg.agent.keys() %}
    foreach ({{agent}}_agt[i]) begin
        {{agent}}_agt[i] = {{agent}}_agent::type_id::create($sformatf("{{agent}}_%0d", i), this);
        {{agent}}_agt[i].intf_id = i;
{% if cfg.agent[agent].inst_type == "master" %}
        {{agent}}_agt[i].is_active = UVM_ACTIVE;
{% else %}
        {{agent}}_agt[i].is_active = UVM_PASSIVE;
{% endif %}
    end
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
    foreach (model.{{agent}}_sqr[i]) begin
        model.{{agent}}_sqr[i] = {{agent}}_agt[i].sqr;
    end
{% endif %}
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_env::main_phase(uvm_phase phase);
endtask

`endif
