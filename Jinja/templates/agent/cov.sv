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
** Filename     : {{"%-60s"|format([intf,"_cov.sv"]|join)}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{intf|upper}}_COV_SV__
`define __{{intf|upper}}_COV_SV__

class {{intf}}_cov extends uvm_subscriber #({{intf}}_xaction);
    {{intf}}_xaction tr;
    `uvm_component_utils_begin({{intf}}_cov)
    `uvm_component_utils_end
    
    covergroup {{intf}}_cg;
{% for i in range(cfg.agent[intf]["field"]|length) %}
{% set field = cfg.agent[intf]["field"][i] %}
{% set width = cfg.agent[intf]["width"][i] %}
        {{field}}_cp : coverpoint tr.{{field}} {
{% if width == 1 %}
            bins {{field}}_all[] = {[0:1]};
{% else %}
            bins {{field}}_min = {0};
            bins {{field}}_mid = {[1:2**{{intf}}_dec::{{field|upper}}_WIDTH-2]};
            bins {{field}}_max = {2**{{intf}}_dec::{{field|upper}}_WIDTH-1};
{% endif %}
        }
{% endfor %}
        option.pre_instance = 1;
    endgroup

    extern function new(string name="{{intf}}_cov", uvm_component parent=null);
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_cov::new(string name="{{intf}}_cov", uvm_component parent=null);
    super.new(name, parent);
    
    {{intf}}_cg = new();
endfunction

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void {{intf}}_cov::write({{intf}}_xaction t);
    tr = t;
    {{intf}}_cg.sample();
endfunction

`endif
