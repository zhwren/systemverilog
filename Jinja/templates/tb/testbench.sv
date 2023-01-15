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
** Filename     : {{"%-60s"|format("testbench.sv")}}**
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_SV__

`include "uvm_macros.svh"
import uvm_pkg::*;

module testbench;
    logic clk;
    logic rst_n;

    virtual {{cfg.proj}}_{{cfg.module}}_top_if top_vif;
    {{cfg.proj}}_{{cfg.module}}_top_if         top_if(clk, rst_n);

    initial begin
        top_vif = top_if;
        uvm_config_db #(virtual {{cfg.proj}}_{{cfg.module}}_top_if)::set(null, "*", "top_vif", top_vif);

{% for agent in cfg.agent.keys() %}
        foreach (top_vif.{{agent}}_vif[i]) begin
            uvm_config_db#(virtual {{agent}}_intf)::set(null, "*", $sformatf("{{agent}}_intf_%0d", i), top_vif.{{agent}}_vif[i]);
        end

{% endfor %}
    end

    initial begin
        clk   = 1'b0;
        rst_n = 1'b0;
        #1000;
        rst_n = 1'b1;
        #5000;
        $finish;
    end

    always #1 clk = ~clk;

    initial begin
        $fsdbDumpfile("t.fsdb");
        $fsdbDumpvars(0);
        run_test();
    end

endmodule

`endif
