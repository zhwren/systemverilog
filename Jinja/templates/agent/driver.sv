{{fhead}}

`ifndef __{{intf|upper}}_DRIVER_SV__
`define __{{intf|upper}}_DRIVER_SV__

class {{intf}}_driver extends uvm_driver #({{intf}}_xaction);
    int intf_id;
    virtual {{intf}}_intf bus;

    `uvm_component_utils_begin({{intf}}_driver)
    `uvm_component_utils_end

    extern function new(string name="{{intf}}_driver", uvm_component parent=null);
    extern function void connect_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task drive_one_package({{intf}}_xaction tr, bit invalid);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_driver::new(string name="{{intf}}_driver", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual {{intf}}_intf)::get(this, "", $sformatf("{{intf}}_intf_%0d", intf_id), bus)) begin
        `uvm_fatal(get_name(), $sformatf("{{intf}}_intf_%0d is null!", intf_id));
    end
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{intf}}_driver::main_phase(uvm_phase phase);
    forever begin
        @bus.drv_cb;
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

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{intf}}_driver::drive_one_package({{intf}}_xaction tr, bit invalid);
{% if cfg.agent[intf]["vld"]|length > 0 %}
    if (invalid) begin
{% for field in cfg.agent[intf]["vld"] %}
        bus.drv_cb.{{"%-20s"|format(field)}} <= '0;
{% endfor %}
    end else begin
{% for field in cfg.agent[intf]["vld"] %}
        bus.drv_cb.{{"%-20s"|format(field)}} <= tr.{{field}};
{% endfor %}
    end
{% endif %}

    fork begin
        repeat ({{intf}}_dec::VLD2DATA_DLY) @bus.drv_cb;
{% for field in cfg.agent[intf]["field"] %}
{% if not (field in cfg.agent[intf]["vld"]) %}
        bus.drv_cb.{{"%-20s"|format(field)}} <= tr.{{field}};
{% endif %}
{% endfor %}
    end join_none

endtask

`endif
