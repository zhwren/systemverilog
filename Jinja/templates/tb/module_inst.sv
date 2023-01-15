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
** Last modified: 2021-01-15 10:36:35                                         **
** Filename     : module_inst.sv                                              **
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __MODULE_INST_SV__
`define __MODULE_INST_SV__

{{cfg.module|upper}} u_{{cfg.module}} (
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_num == 1 %}
{% for field in cfg.agent[agent]["field"] %}
    .{{"%-15s"|format(field)}}(top_if.{{agent}}_if[0].{{field}}),
{% endfor %}

{% else %}
{% for i in range(cfg.agent[agent].inst_num) %}
{% for field in cfg.agent[agent]["field"] %}
    .{{"%-15s"|format([field, i]|join("_"))}}(top_if.{{agent}}_if[{{i}}].{{field}}),
{% endfor %}

{% endfor %}
{% endif %}
{% endfor %}
    .clk            (clk),
    .rst_n          (rst_n)
);
`endif
