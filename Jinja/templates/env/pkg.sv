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
** Filename     : {{"%-60s"|format([cfg.proj,cfg.module,"pkg.sv"]|join("_"))}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__

`include "{{cfg.proj}}_{{cfg.module}}_dec.sv"
`include "{{cfg.proj}}_{{cfg.module}}_top_if.sv"

package {{cfg.proj}}_{{cfg.module}}_pkg;
    import uvm_pkg::*;
{% for agent in cfg.agent.keys() %}
    import {{agent}}_pkg::*;
{% endfor %}
    `include "{{cfg.proj}}_{{cfg.module}}_model.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_e2e.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_env.sv"
endpackage
import {{cfg.proj}}_{{cfg.module}}_pkg::*;

`endif
