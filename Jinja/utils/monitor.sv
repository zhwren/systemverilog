/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_monitor.sv
** Discription  : {{ifname}} monitor declare    
***************************************************************/
`ifndef __{{ifname|upper}}_MONITOR_SV__
`define __{{ifname|upper}}_MONITOR_SV__

class {{ifname}}_monitor extends uvm_monitor;
    int inst_id;
    virtual {{ifname}}_intf vif;
    uvm_analysis_port#(uvm_sequence_item) ap;

    `uvm_component_utils_begin({{ifname}}_monitor)
    `uvm_component_utils_end

    extern function new(string name="{{ifname}}_monitor", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{ifname}}_monitor::new(string name="{{ifname}}_monitor", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{ifname}}_monitor::build_phase(uvm_phase phase);
    ap = new("ap", this);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{ifname}}_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (!uvm_config_db#(virtual {{ifname}}_intf)::get(this, "", $sformatf("{{ifname}}_intf_%0d", inst_id), vif)) begin
        `uvm_fatal(get_name(), $sformatf("{{ifname}}_intf_%0d is null", inst_id));
    end
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{ifname}}_monitor::run_phase(uvm_phase phase);
    bit data_vld;
    {{ifname}}_xaction tr;

    forever begin
        @vif.mon_cb;
        tr = new();
        data_vld = 1'b0;

{% for fieldname in fields.keys() %}
{% if fieldname[-4:] == "_vld" %}
        tr.{{fieldname}} = vif.mon_cb.{{fieldname}};
        data_vld |= vif.mon_cb.{{fieldname}};
{% endif %}
{% endfor %}

        fork begin
            bit sample_en = data_vld;
            repeat ({{ifname}}_dec::VLD2DATA_DLY) @vif.mon_cb;
{% for fieldname in fields.keys() %}
{% if fieldname[-4:] != "_vld" %}
            tr.{{fieldname}} = vif.mon_cb.{{fieldname}};
{% endif %}
{% endfor %}

            if (sample_en) begin
                ap.write(tr);
            end
        end join_none
    end
endtask

`endif
