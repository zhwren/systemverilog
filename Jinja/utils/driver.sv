/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_driver.sv
** Discription  : {{ifname}} driver declare    
***************************************************************/
`ifndef __{{ifname|upper}}_DRIVER_SV__
`define __{{ifname|upper}}_DRIVER_SV__

class {{ifname}}_driver extends uvm_driver #({{ifname}}_xaction);
    int inst_id;
    virtual {{ifname}}_intf vif;

    `uvm_component_utils_begin({{ifname}}_driver)
    `uvm_component_utils_end

    extern function new(string name="{{ifname}}_driver", uvm_component parent=null);
    extern function void connect_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task drive_one_package({{ifname}}_xaction tr, bit invalid);
endclass

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function {{ifname}}_driver::new(string name="{{ifname}}_driver", uvm_component parent=null);
    super.new(name, parent);
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
function void {{ifname}}_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual {{ifname}}_intf)::get(this, "", $sformatf("{{ifname}}_intf_%0d", inst_id), vif)) begin
        `uvm_fatal(get_name(), $sformatf("{{ifname}}_intf_%0d is null!", inst_id));
    end
endfunction

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{ifname}}_driver::main_phase(uvm_phase phase);
    forever begin
        @vif.drv_cb;
        seq_item_port.try_next_item(req);
        if (req == null) begin
            req = new();
            req.randomize();
            drive_one_package(req, 1'b1);
        end else begin
            drive_one_package(req, 1'b0);
            seq_item_port.item_done();
        end
    end
endtask

/***************************************************************
** Time        : {{time}}
** Author      : generator                                      
** Description : Create                                         
***************************************************************/
task {{ifname}}_driver::drive_one_package({{ifname}}_xaction tr, bit invalid);
    if (invalid) begin
{% for fieldname in fields.keys() %}
{% if (fieldname[-4:] == "_vld") %}
        vif.drv_cb.{{fieldname}} <= '0;
{% endif %}
{% endfor %}
    end else begin
{% for fieldname in fields.keys() %}
{% if (fieldname[-4:] == "_vld") %}
        vif.drv_cb.{{fieldname}} <= tr.{{fieldname}};
{% endif %}
{% endfor %}
    end

    fork begin
        repeat ({{ifname}}_dec::VLD2DATA_DLY) @vif.drv_cb;
{% for fieldname in fields.keys() %}
{% if (fieldname[-4:] != "_vld") %}
        vif.drv_cb.{{fieldname}} <= tr.{{fieldname}};
{% endif %}
{% endfor %}
    end join_none

endtask

`endif
