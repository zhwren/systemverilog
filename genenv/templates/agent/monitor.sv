{{cfg.header}}

`ifndef __{{agent.name|upper}}_MONITOR_SV__
`define __{{agent.name|upper}}_MONITOR_SV__

class {{agent.name}}_monitor extends uvm_monitor;
    int inst_id;
    virtual {{agent.name}}_intf bus;
    uvm_analysis_port #({{agent.name}}_xaction) ap;

    `uvm_component_utils({{agent.name}}_monitor)

    extern function new(string name="{{agent.name}}_monitor", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_one_package();
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_monitor::new(string name="{{agent.name}}_monitor", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{agent.name}}_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    connector#({{agent.name}}_xaction)::regist_output_port($sformatf("{{agent.name}}_intf_%0d", inst_id), ap);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{agent.name}}_monitor::connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual {{agent.name}}_intf)::get(this, "", "{{agent.name}}_intf", bus)) begin
        `uvm_fatal(get_name(), $sformatf("{{agent.name}}_intf_%0d is null!", inst_id))
    end
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_monitor::run_phase(uvm_phase phase);
    forever begin
        @(bus.mon_cb);
        collect_one_package();
    end
endtask

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_monitor::collect_one_package();
    bit sample_en = 1;
    {{agent.name}}_xaction tr = new();

{% for vld in agent.valids %}
    tr.{{"%-15s"|format(vld)}} = bus.mon_cb.{{vld}};
    sample_en         &= (tr.{{vld}} != 0);
{% endfor %}
    fork begin
        repeat ({{agent.name}}_dec::VLD2DATA_DELAY) @(bus.drv_cb);
{% for field in agent.fields %}
{% if not field.name in agent.valids %}
        tr.{{"%-15s"|format(field.name)}} = bus.mon_cb.{{field.name}};
{% endif %}
{% endfor %}
        if (sample_en) ap.write(tr);
    end join_none
endtask

`endif
