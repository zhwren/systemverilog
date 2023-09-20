{{cfg.header}}

`ifndef __{{agent.name|upper}}_DRIVER_SV__
`define __{{agent.name|upper}}_DRIVER_SV__

class {{agent.name}}_driver extends uvm_driver#({{agent.name}}_xaction);
    int inst_id;
    virtual {{agent.name}}_intf bus;

    `uvm_component_utils({{agent.name}}_driver)

    extern function new(string name="{{agent.name}}_driver", uvm_component parent=null);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task send_one_package();
    extern task send_random_data();
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_driver::new(string name="{{agent.name}}_driver", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function void {{agent.name}}_driver::connect_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual {{agent.name}}_intf)::get(this, "", "{{agent.name}}_intf", bus)) begin
        `uvm_fatal(get_name(), $sformatf("{{agent.name}}_intf_%0d is null!", inst_id))
    end
endfunction

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_driver::run_phase(uvm_phase phase);
    forever begin
        @(bus.drv_cb);
        seq_item_port.try_next_item(req);
        if (req == null) begin
            send_random_data();
        end else begin
            send_one_package();
            seq_item_port.item_done();
        end
    end
endtask

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_driver::send_one_package();
    {{agent.name}}_xaction tr = new();
    tr.copy(req);

    fork begin
{% for vld in agent.valids %}
        bus.drv_cb.{{"%-15s"|format(vld)}} <= tr.{{vld}};
{% endfor %}
        repeat ({{agent.name}}_dec::VLD2DATA_DELAY) @(bus.drv_cb);

{% for field in agent.fields %}
{% if not field.name in agent.valids %}
        bus.drv_cb.{{"%-15s"|format(field.name)}} <= tr.{{field.name}};
{% endif %}
{% endfor %}
    end join_none
endtask

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
task {{agent.name}}_driver::send_random_data();
    req = new();

{% if agent.valids|length > 0%}
    req.randomize() with {
{% for vld in agent.valids %}
        {{"%-15s"|format(vld)}} == 0;
{% endfor %}
    };
{% else %}
    req.randomize();
{% endif %}

    send_one_package();
endtask

`endif
