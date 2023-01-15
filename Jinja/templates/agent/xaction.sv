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
** Filename     : {{"%-60s"|format([intf,"_xaction.sv"]|join)}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{intf|upper}}_XACTION_SV__
`define __{{intf|upper}}_XACTION_SV__

class {{intf}}_xaction extends uvm_sequence_item;

{% for field in cfg.agent[intf]["field"] %}
    rand bit [{{intf}}_dec::{{"%-20s"|format([field,"_WIDTH"]|join|upper)}}-1:0] {{field}};
{% endfor %}

    `uvm_object_utils_begin({{intf}}_xaction)
{% for field in cfg.agent[intf]["field"] %}
        `uvm_field_int({{field}}, UVM_ALL_ON | UVM_NOPACK)
{% endfor %}
    `uvm_object_utils_end

    extern function new(string name="{{intf}}_xaction");
endclass

/*******************************************************************************
** Time        : {{time}}                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function {{intf}}_xaction::new(string name="{{intf}}_xaction");
    super.new(name);
endfunction

`endif
