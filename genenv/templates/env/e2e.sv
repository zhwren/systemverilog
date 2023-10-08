{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_E2E_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_E2E_SV__

class {{cfg.proj}}_{{cfg.module}}_e2e extends uvm_component;
    int inst_id;
{% for agent in cfg.agents %}
    uvm_blocking_get_export #({{agent.name}}_xaction) {{agent.name}}_agt2chk_port[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}

    `uvm_component_utils({{cfg.proj}}_{{cfg.module}}_e2e)

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_e2e", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

{% for agent in cfg.agents %}
    extern task {{agent.name}}_agt2chk_process(int intf_id);
{% endfor %}
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_e2e::new(string name="{{cfg.proj}}_{{cfg.module}}_e2e", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_e2e::build_phase(uvm_phase phase);
    int id;
{% for agent in cfg.agents %}
    foreach ({{agent.name}}_agt2chk_port[i]) begin
        id = inst_id * {{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM + i;
        connector#({{agent.name}}_xaction)::regist_input_port($sformatf("{{agent.name}}_intf_%0d", id), {{agent.name}}_agt2chk_port[i]);
    end

{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_e2e::run_phase(uvm_phase phase);
    fork
{% for agent in cfg.agents %}
        for (int i = 0; i < {{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM; i++) begin
            automatic int intf_id = i;
            fork
                {{agent.name}}_agt2chk_process(intf_id);
            join_none
        end
{% endfor %}
    join
endtask

{% for agent in cfg.agents %}
/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_e2e::{{agent.name}}_agt2chk_process(int intf_id);
    {{agent.name}}_xaction tr;

    forever begin
        {{agent.name}}_agt2chk_port[intf_id].get(tr);
        `uvm_info(get_name(), $sformatf("\n%s", tr.sprint()), UVM_LOW);
    end
endtask

{% endfor %}
`endif
