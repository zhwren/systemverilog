/*******************************************************************************
**                                 _ooOoo_                                    **
**                                o8888888o                                   **
**                                88" . "88                                   **
**                                (| -_- |)                                   **
**                                 O\ = /O                                    **
**                             ____/`---'\____                                **
**                           .   ' \\| |// `.                                 **
**                            / \\||| : |||// \                               **
**                          / _||||| -:- |||||- \                             **
**                            | | \\\ - /// | |                               **
**                          | \_| ''\---/'' | |                               **
**                           \ .-\__ `-` ___/-. /                             **
**                        ___`. .' /--.--\ `. . __                            **
**                     ."" '< `.____<|>_/___.' >'"".                          **
**                    | | : `- \`.;` _ /`;.`/ - ` : | |                       **
**                      \ \ `-. \_ __\ /__ _/ .-` / /                         **
**              ======`-.____`-.___\_____/___.-`____.-'======                 **
**                                 `=---='                                    **
**                                                                            **
**              .............................................                 **
**                     Buddha bless me, No bug forever                        **
**                                                                            **
********************************************************************************
** Author       : generator                                                   **
** Email        : zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn                      **
** Last modified: {{time}}                                         **
** Filename     : monitor.sv
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{intf|upper}}_MONITOR_SV__
`define __{{intf|upper}}_MONITOR_SV__

class {{intf}}_monitor extends uvm_monitor;
    int intf_id;
    virtual {{intf}}_intf bus;
    uvm_analysis_port#({{intf}}_xaction) ap;

    `uvm_component_utils_begin({{intf}}_monitor)
    `uvm_component_utils_end

    extern function new(string name="{{intf}}_monitor", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_monitor::new(string name="{{intf}}_monitor", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_monitor::build_phase(uvm_phase phase);
    ap = new("ap", this);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (!uvm_config_db#(virtual {{intf}}_intf)::get(this, "", $sformatf("{{intf}}_intf_%0d", intf_id), bus)) begin
        `uvm_fatal(get_name(), $sformatf("{{intf}}_intf_%0d is null", intf_id));
    end
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{intf}}_monitor::run_phase(uvm_phase phase);
    {{intf}}_xaction tr;

    forever begin
        @bus.mon_cb;
        tr = new();

{% for field in cfg.agent[intf]["field"] %}
{% if field in cfg.agent[intf]["vld"] %}
        tr.{{"%-15s"|format(field)}} = bus.mon_cb.{{field}};
{% endif %}
{% endfor %}

        fork begin
            repeat ({{intf}}_dec::VLD2DATA_DLY) @bus.mon_cb;
{% for field in cfg.agent[intf]["field"] %}
{% if not (field in cfg.agent[intf]["vld"]) %}
            tr.{{"%-15s"|format(field)}} = bus.mon_cb.{{field}};
{% endif %}
{% endfor %}
            ap.write(tr);
        end join_none
    end
endtask

`endif
