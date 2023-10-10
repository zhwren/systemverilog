/*******************************************************************************
**                                  _ooOoo_                                   **
**                                 o8888888o                                  **
**                                 88" . "88                                  **
**                                 (| -_- |)                                  **
**                                  O\ = /O                                   **
**                              ____/`---'\____                               **
**                            .   ' \\| |// `.                                **
**                             / \\||| : |||// \                              **
**                           / _||||| -:- |||||- \                            **
**                             | | \\\ - /// | |                              **
**                           | \_| ''\---/'' | |                              **
**                            \ .-\__ `-` ___/-. /                            **
**                         ___`. .' /--.--\ `. . __                           **
**                      ."" '< `.____<|>_/___.' >'"".                         **
**                     | | : `- \`.;` _ /`;.`/ - ` : | |                      **
**                       \ \ `-. \_ __\ /__ _/ .-` / /                        **
**               ======`-.____`-.___\_____/___.-`____.-'======                **
**                                  `=---='                                   **
**                                                                            **
**               .............................................                **
**                      Buddha bless me, No bug forever                       **
**                                                                            **
********************************************************************************
** Author        : generator                                                  **
** Email         : zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn                     **
** Last modified : 2023-10-10 10:23:14                                        **
** Filename      : configuration.sv                                           **
** Phone Number  :                                                            **
** Discription   :                                                            **
*******************************************************************************/
`ifndef __CONFIGURATION_SV__
`define __CONFIGURATION_SV__

class configuration extends uvm_object;
    rand int inst_id;
    rand uvm_active_passive_enum is_active;

    `uvm_object_utils(configuration)

    constraint cfg_constraint;
    extern function new(string name="cfg");
endclass

/*******************************************************************************
** Time        : 2023-10-10 10:24:35                                           *
** Author      : zhwren                                                        *
** Description : Create                                                        *
*******************************************************************************/
function configuration::new(string name="cfg");
    super.new(name);
endfunction

/*******************************************************************************
** Time        : 2023-10-10 10:25:25                                           *
** Author      : zhwren                                                        *
** Description : Create                                                        *
*******************************************************************************/
constraint configuration::cfg_constraint {
    soft inst_id   == 0;
    soft is_active == UVM_ACTIVE;
}

`endif
