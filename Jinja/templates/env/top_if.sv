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
** Filename     : {{"%-60s"|format([cfg.proj,cfg.module,"top_if.sv"]|join("_"))}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_IF_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_IF_SV__

interface {{cfg.proj}}_{{cfg.module}}_top_if(input clk, input rst_n);
{% for agent in cfg.agent.keys() %}
    virtual {{agent}}_intf {{agent}}_vif[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
    {{agent}}_intf         {{agent}}_if[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM](clk, rst_n);

{% endfor %}
{% for agent in cfg.agent.keys() %}
    initial begin {{agent}}_vif = {{agent}}_if; end

{% endfor %}
endinterface

`endif
