/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_model.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} generate model 
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_MODEL_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_MODEL_SV__

class {{cfg.proj_name}}_{{cfg.module_name}}_model extends uvm_component;
    uvm_phase phase;
{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
    {{"%-20s"|format(agt + "_sequence")}} {{agt}}_seq[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM];
    {{"%-20s"|format(agt + "_sequencer")}} {{agt}}_sqr[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM];
{% endif %}
{% endfor %}

    `uvm_component_utils_begin({{cfg.proj_name}}_{{cfg.module_name}}_model)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_model", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);

{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
    extern task {{agt}}_input_process(int inst_id);
{% endif %}
{% endfor %}
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{cfg.proj_name}}_{{cfg.module_name}}_model::new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_model", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{cfg.proj_name}}_{{cfg.module_name}}_model::build_phase(uvm_phase phase);
{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
    foreach ({{agt}}_seq[i]) begin
        {{agt}}_seq[i] = new($sformatf("{{agt}}_seq_%0d", i));
    end
{% endif %}
{% endfor %}
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{cfg.proj_name}}_{{cfg.module_name}}_model::main_phase(uvm_phase phase);
    this.phase = phase;
    fork
{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
        for (int i = 0; i < {{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM; i++) begin
            automatic int inst_id = i;
            fork
                {{agt}}_input_process(inst_id);
            join_none
        end
{% endif %}
{% endfor %}
    join
endtask

{% for agt in cfg.env.keys() %}
{% if cfg.env[agt].inst_type == "master" %}
/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{cfg.proj_name}}_{{cfg.module_name}}_model::{{agt}}_input_process(int inst_id);
    {{agt}}_xaction xaction;

    {{agt}}_seq[inst_id].start({{agt}}_sqr[inst_id]);
    this.phase.raise_objection(this);
    repeat (100) begin
        xaction = new();
        xaction.randomize();
        {{agt}}_seq[inst_id].start_item(xaction);
        {{agt}}_seq[inst_id].finish_item(xaction);
    end
    this.phase.drop_objection(this);
endtask

{% endif %}
{% endfor %}
`endif
