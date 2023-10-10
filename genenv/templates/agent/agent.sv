{{cfg.header}}

`ifndef __{{agent.name|upper}}_AGENT_SV__
`define __{{agent.name|upper}}_AGENT_SV__

class {{agent.name}}_agent extends uvm_agent;
    {{agent.name}}_driver    drv;
    {{agent.name}}_monitor   mon;
    {{agent.name}}_sequencer sqr;
    {{agent.name}}_agent_cfg cfg;

    `uvm_component_utils({{agent.name}}_agent)

    extern function new(string name="{{agent.name}}_agent", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_agent::new(string name="{{agent.name}}_agent", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{agent.name}}_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (cfg == null) begin
        `uvm_fatal(get_name(), $sformatf("agent cfg is null!"));
    end

    if (cfg.is_active == UVM_ACTIVE) begin
        drv = {{agent.name}}_driver::type_id::create("{{agent.name}}_drv", this);
        sqr = {{agent.name}}_sequencer::type_id::create("{{agent.name}}_sqr", this);
        drv.bus = cfg.vif;
        drv.inst_id = cfg.inst_id;
    end

    mon = {{agent.name}}_monitor::type_id::create("{{agent.name}}_mon", this);
    mon.bus = cfg.vif;
    mon.inst_id = cfg.inst_id;
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{agent.name}}_agent::connect_phase(uvm_phase phase);
    if (cfg.is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
    end
endfunction

`endif
