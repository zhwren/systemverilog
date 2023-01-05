/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_env.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} env    
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_EVN_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_EVN_SV__

class {{cfg.proj_name}}_{{cfg.module_name}}_env extends uvm_env;

{% for agt in cfg.env.keys() %}
    {{"%-20s"|format(agt + "_agent")}} {{agt}}_agt[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM];
{% endfor %}
    {{cfg.proj_name}}_{{cfg.module_name}}_model model;

    `uvm_component_utils_begin({{cfg.proj_name}}_{{cfg.module_name}}_env)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_env", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{cfg.proj_name}}_{{cfg.module_name}}_env::new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_env", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{cfg.proj_name}}_{{cfg.module_name}}_env::build_phase(uvm_phase phase);
    model = {{cfg.proj_name}}_{{cfg.module_name}}_model::type_id::create("model", this);
{% for agt in cfg.env.keys() %}
    foreach ({{agt}}_agt[i]) begin
        {{agt}}_agt[i] = {{agt}}_agent::type_id::create($sformatf("{{agt}}_%0d", i), this);
        {{agt}}_agt[i].inst_id = i;
{% if cfg.env[agt].inst_type == "master" %}
        {{agt}}_agt[i].is_active = UVM_ACTIVE;
{% else %}
        {{agt}}_agt[i].is_active = UVM_PASSIVE;
{% endif %}
    end
{% endfor %}
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{cfg.proj_name}}_{{cfg.module_name}}_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
    foreach (model.{{agt}}_sqr[i]) begin
        model.{{agt}}_sqr[i] = {{agt}}_agt[i].sqr;
    end
{% endif %}
{% endfor %}
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{cfg.proj_name}}_{{cfg.module_name}}_env::main_phase(uvm_phase phase);
endtask

`endif
