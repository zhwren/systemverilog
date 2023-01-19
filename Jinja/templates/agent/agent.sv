{{fhead}}

`ifndef __{{intf|upper}}_AGENT_SV__
`define __{{intf|upper}}_AGENT_SV__

class {{intf}}_agent extends uvm_agent;
    int intf_id;
    {{intf}}_driver    drv;
    {{intf}}_monitor   mon;
    {{intf}}_sequencer sqr;
    {{intf}}_cov       cov;

    `uvm_component_utils_begin({{intf}}_agent)
    `uvm_component_utils_end

    extern function new(string name="{{intf}}_agent", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_agent::new(string name="{{intf}}_agent", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_agent::build_phase(uvm_phase phase);
    if (is_active == UVM_ACTIVE) begin
        drv = {{intf}}_driver::type_id::create("{{intf}}_driver", this);
        sqr = {{intf}}_sequencer::type_id::create("{{intf}}_sequencer", this);
        drv.intf_id = this.intf_id;
    end

    mon = {{intf}}_monitor::type_id::create("{{intf}}_monitor", this);
    mon.intf_id = this.intf_id;
    
    cov = {{intf}}_cov::type_id::create("{{intf}}_cov", this);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
    end
    
    mon.ap.connect(cov.analysis_export);
endfunction

`endif
