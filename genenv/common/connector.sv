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
** Last modified: 2021-01-14 12:57:14                                         **
** Filename     : connector.sv                                                **
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __CONNECTOR_SV__
`define __CONNECTOR_SV__

class connector#(type T=uvm_object) extends uvm_object;
    static uvm_tlm_analysis_fifo#(T) m_fifo[string];
    extern static function void regist_input_port(string id, ref uvm_blocking_get_export#(T) ip);
    extern static function void regist_output_port(string id, ref uvm_analysis_port#(T) op);
endclass

/*******************************************************************************
** Time        : 2021-01-14 12:59:53                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void connector::regist_input_port(string id, ref uvm_blocking_get_export#(T) ip);
    uvm_tlm_analysis_fifo #(T) t_fifo;

    if (!m_fifo.exists(id)) begin
        t_fifo = new($sformatf("%s_fifo", id), null);
        m_fifo[id] = t_fifo;
    end else begin
        t_fifo = m_fifo[id];
    end

    ip = new($sformatf("%s_export", id), null);
    ip.connect(t_fifo.blocking_get_export);
endfunction

/*******************************************************************************
** Time        : 2021-01-14 13:03:23                                          **
** Author      : generator                                                    **
** Description : Create                                                       **
*******************************************************************************/
function void connector::regist_output_port(string id, ref uvm_analysis_port#(T) op);
    uvm_tlm_analysis_fifo #(T) t_fifo;

    if (!m_fifo.exists(id)) begin
        t_fifo = new($sformatf("%s_fifo", id), null);
        m_fifo[id] = t_fifo;
    end else begin
        t_fifo = m_fifo[id];
    end

    op = new($sformatf("%s_port", id), null);
    op.connect(t_fifo.analysis_export);
endfunction

`endif
