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
** Filename     : {{"%-60s"|format([intf,"_pkg.sv"]|join)}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{intf|upper}}_PKG_SV__
`define __{{intf|upper}}_PKG_SV__

`include "{{intf}}_dec.sv"
`include "{{intf}}_interface.sv"

package {{intf}}_pkg;
    import uvm_pkg::*;
    `include "{{intf}}_plus.sv"
    `include "{{intf}}_xaction.sv"
    `include "{{intf}}_sequence.sv"
    `include "{{intf}}_sequencer.sv"
    `include "{{intf}}_monitor.sv"
    `include "{{intf}}_driver.sv"
    `include "{{intf}}_cov.sv"
    `include "{{intf}}_agent.sv"
endpackage
import {{intf}}_pkg::*;

`endif
