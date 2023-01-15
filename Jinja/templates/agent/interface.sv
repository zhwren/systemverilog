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
** Filename     : {{"%-60s"|format([intf, "_interface.sv"]|join)}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{intf|upper}}_INTF_SV__
`define __{{intf|upper}}_INTF_SV__

interface {{intf}}_intf(input clk, input rst_n);

{% for field in cfg.agent[intf]["field"] %}
    logic [{{intf}}_dec::{{"%-20s"|format([field,"_WIDTH"]|join|upper)}}-1:0] {{field}};
{% endfor %}

    clocking drv_cb @(posedge clk);
{% for field in cfg.agent[intf]["field"] %}
        inout {{field}};
{% endfor %}
    endclocking

    clocking mon_cb @(posedge clk);
{% for field in cfg.agent[intf]["field"] %}
        input {{field}};
{% endfor %}
    endclocking

endinterface

`endif
