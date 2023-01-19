{{fhead}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_E2E_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_E2E_SV__

class {{cfg.proj}}_{{cfg.module}}_e2e extends uvm_component;
{% for agent in cfg.agent.keys() %}
    uvm_blocking_get_export #({{agent}}_xaction) {{agent}}_agt2chk_port[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
{% endfor %}

    `uvm_component_utils_begin({{cfg.proj}}_{{cfg.module}}_e2e)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_e2e", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

{% for agent in cfg.agent.keys() %}
    extern task {{agent}}_agt2chk_process(int intf_id);
{% endfor %}
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_e2e::new(string name="{{cfg.proj}}_{{cfg.module}}_e2e", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_e2e::build_phase(uvm_phase phase);
{% for agent in cfg.agent.keys() %}
    foreach ({{agent}}_agt2chk_port[i]) begin
        {{agent}}_agt2chk_port[i] = new($sformatf("{{agent}}_agt2chk_port_%0d", i), this);
    end
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_e2e::run_phase(uvm_phase phase);
    fork
{% for agent in cfg.agent.keys() %}
        for (int i = 0; i < {{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM; i++) begin
            automatic int intf_id = i;
            fork
                {{agent}}_agt2chk_process(intf_id);
            join_none
        end
{% endfor %}
    join
endtask

{% for agent in cfg.agent.keys() %}
/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_e2e::{{agent}}_agt2chk_process(int intf_id);
    {{agent}}_xaction item;

    forever begin
        {{agent}}_agt2chk_port[intf_id].get(item);
        item.print();
    end
endtask

{% endfor %}
`endif
