/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_e2e.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} e2e checker    
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_E2E_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_E2E_SV__

class {{cfg.proj_name}}_{{cfg.module_name}}_e2e extends uvm_component;
{% for agt in cfg.env.keys() %}
    uvm_blocking_get_port#(uvm_sequence_item) {{agt}}_agt2chk_port[{{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM];
{% endfor %}

    `uvm_component_utils_begin({{cfg.proj_name}}_{{cfg.module_name}}_e2e)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_e2e", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

{% for agt in cfg.env.keys() %}
    extern task {{agt}}_agt2chk_process(int inst_id);
{% endfor %}
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{cfg.proj_name}}_{{cfg.module_name}}_e2e::new(string name="{{cfg.proj_name}}_{{cfg.module_name}}_e2e", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{cfg.proj_name}}_{{cfg.module_name}}_e2e::build_phase(uvm_phase phase);
{% for agt in cfg.env.keys() %}
    foreach ({{agt}}_agt2chk_port[i]) begin
        {{agt}}_agt2chk_port[i] = new($sformatf("{{agt}}_agt2chk_port_%0d", i), this);
    end
{% endfor %}
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{cfg.proj_name}}_{{cfg.module_name}}_e2e::run_phase(uvm_phase phase);
    fork
{% for agt in cfg.env.keys() %}
        for (int i = 0; i < {{cfg.proj_name}}_{{cfg.module_name}}_dec::{{agt|upper}}_NUM; i++) begin
            automatic int inst_id = i;
            fork
                {{agt}}_agt2chk_process(inst_id);
            join_none
        end
{% endfor %}
    join
endtask

{% for agt in cfg.env.keys() %}
/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{cfg.proj_name}}_{{cfg.module_name}}_e2e::{{agt}}_agt2chk_process(int inst_id);
    {{agt}}_xaction xaction;
    uvm_sequence_item item;

    forever begin
        {{agt}}_agt2chk_port[inst_id].get(item);
        if (!$cast(xaction, item.clone())) begin
            `uvm_fatal(get_name(), $sformatf("{{agt}}_agt2chk_process[%0d], data type error!", inst_id));
        end
    end
endtask

{% endfor %}
`endif
