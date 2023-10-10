{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_ENV_CFG_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_ENV_CFG_SV__

class {{cfg.proj}}_{{cfg.module}}_env_cfg extends configuration;
    virtual {{cfg.proj}}_{{cfg.module}}_intf vif;
{% for agent in cfg.agents %}
    rand {{agent.name}}_agent_cfg {{agent.name}}_agt_cfg[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}
{% for agent in cfg.subenvs %}
    rand {{cfg.proj}}_{{agent.name}}_env_cfg sub_{{cfg.proj}}_{{agent.name}}_env_cfg[{{cfg.proj}}_{{cfg.module}}_dec::{{cfg.proj|upper}}_{{agent.name|upper}}_ENV_NUM];
{% endfor %}

    `uvm_object_utils({{cfg.proj}}_{{cfg.module}}_env_cfg)

    constraint {{cfg.proj}}_{{cfg.module}}_constraint;
    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_env_cfg");
    extern function void post_randomize();
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_env_cfg::new(string name="{{cfg.proj}}_{{cfg.module}}_env_cfg");
    super.new(name);
{% for agent in cfg.agents %}
    
    foreach ({{agent.name}}_agt_cfg[i]) begin
        {{agent.name}}_agt_cfg[i] = new($sformatf("{{agent.name}}_agt_cfg_%0d", i));
    end
{% endfor %}
{% for agent in cfg.subenvs %}

    foreach (sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i]) begin
        sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i] = new($sformatf("sub_{[cfg.proj}}_{{agent.name}}_env_cfg_%0d", i));
    end
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_env_cfg::post_randomize();
{% for agent in cfg.agents %}
    foreach ({{agent.name}}_agt_cfg[i]) begin
        {{agent.name}}_agt_cfg[i].vif = vif.{{agent.name}}_vif[i];
    end
{% endfor %}
{% for agent in cfg.subenvs %}
    foreach (sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i]) begin
        sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i].vif = vif.{{cfg.proj}}_{{agent.name}}_env_vif[i];
    end
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
constraint {{cfg.proj}}_{{cfg.module}}_env_cfg::{{cfg.proj}}_{{cfg.module}}_constraint {
{% for agent in cfg.agents %}

    foreach ({{agent.name}}_agt_cfg[i]) {
        {{agent.name}}_agt_cfg[i].inst_id == this.inst_id * {{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM + i;
{% if agent.inst_type == "master" %}
        {{agent.name}}_agt_cfg[i].is_active == this.is_active;
{% else %}
        {{agent.name}}_agt_cfg[i].is_active == UVM_PASSIVE;
{% endif %}
    }
{% endfor %}
{% for agent in cfg.subenvs %}

    foreach (sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i]) {
        sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i].inst_id == this.inst_id *  {{cfg.proj}}_{{cfg.module}}_dec::{{cfg.proj|upper}}_{{agent.name|upper}}_ENV_NUM + i;
        sub_{{cfg.proj}}_{{agent.name}}_env_cfg[i].is_active == UVM_PASSIVE;
    }
{% endfor %}
}

`endif
