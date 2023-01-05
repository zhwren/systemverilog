/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_agent.sv
** Discription  : {{ifname}} agent declare    
***************************************************************/
`ifndef __{{ifname|upper}}_AGENT_SV__
`define __{{ifname|upper}}_AGENT_SV__

class {{ifname}}_agent extends uvm_agent;
    int inst_id;
    {{ifname}}_driver    drv;
    {{ifname}}_monitor   mon;
    {{ifname}}_sequencer sqr;

    `uvm_component_utils_begin({{ifname}}_agent)
    `uvm_component_utils_end

    extern function new(string name="{{ifname}}_agent", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{ifname}}_agent::new(string name="{{ifname}}_agent", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{ifname}}_agent::build_phase(uvm_phase phase);
    if (is_active == UVM_ACTIVE) begin
        drv = {{ifname}}_driver::type_id::create("{{ifname}}_driver", this);
        sqr = {{ifname}}_sequencer::type_id::create("{{ifname}}_sequencer", this);
        drv.inst_id = this.inst_id;
    end

    mon = {{ifname}}_monitor::type_id::create("{{ifname}}_monitor", this);
    mon.inst_id = this.inst_id;
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{ifname}}_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
    end
endfunction

`endif
