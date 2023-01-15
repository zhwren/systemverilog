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
** Filename     : {{"%-60s"|format([cfg.proj,cfg.module,"model.sv"]|join("_"))}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODEL_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODEL_SV__

class {{cfg.proj}}_{{cfg.module}}_model extends uvm_component;
    uvm_phase phase;
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
    {{"%-20s"|format(agent + "_sequence")}} {{agent}}_seq[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
    {{"%-20s"|format(agent + "_sequencer")}} {{agent}}_sqr[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
{% endif %}
{% endfor %}

    `uvm_component_utils_begin({{cfg.proj}}_{{cfg.module}}_model)
    `uvm_component_utils_end

    extern function new(string name="{{cfg.proj}}_{{cfg.module}}_model", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);

{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
    extern task {{agent}}_input_process(int intf_id);
{% endif %}
{% endfor %}
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{cfg.proj}}_{{cfg.module}}_model::new(string name="{{cfg.proj}}_{{cfg.module}}_model", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{cfg.proj}}_{{cfg.module}}_model::build_phase(uvm_phase phase);
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
    foreach ({{agent}}_seq[i]) begin
        {{agent}}_seq[i] = new($sformatf("{{agent}}_seq_%0d", i));
    end
{% endif %}
{% endfor %}
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_model::main_phase(uvm_phase phase);
    this.phase = phase;
    fork
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
        for (int i = 0; i < {{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM; i++) begin
            automatic int intf_id = i;
            fork
                {{agent}}_input_process(intf_id);
            join_none
        end
{% endif %}
{% endfor %}
    join
endtask

{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_type == "master" %}
/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
task {{cfg.proj}}_{{cfg.module}}_model::{{agent}}_input_process(int intf_id);
    {{agent}}_xaction item;

    {{agent}}_seq[intf_id].start({{agent}}_sqr[intf_id]);
    this.phase.raise_objection(this);
    repeat (100) begin
        item = new();
        item.randomize();
        {{agent}}_seq[intf_id].start_item(item);
        {{agent}}_seq[intf_id].finish_item(item);
    end
    this.phase.drop_objection(this);
endtask

{% endif %}
{% endfor %}
`endif
