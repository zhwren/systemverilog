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
** Last modified: 2021-01-14 13:08:57                                         **
** Filename     : plus_define.sv                                              **
** Phone Number :                                                             **
** Discription  :                                                             **
*******************************************************************************/
`ifndef __PLUS_DEFINE_SV__
`define __PLUS_DEFINE_SV__

`define PLUS_DECLARE_BEGIN(_name) \
    class plus_``_name extends uvm_object;\
        static string plus_name = `"_name";

`define PLUS_DECLARE_END(_name) \
    endclass:plus_``_name \
    bit rst_``name = plus_``_name::parse_variables();

`define PLUS_VARIABLE_DEFINE(_type, _variable) static _type _variable;
`define PLUS_PARSE_BEGIN \
    static function bit parse_variables();\
        string para, temp, plusargs[$]; \
        int vmin, vmax, idx;\
        uvm_cmdline_processor::get_inst().get_plusargs(plusargs);

`define PLUS_PARSE_END endfunction

`define PARSE_DIGITAL(_variable_s, _variable)\
    foreach (plusargs[j]) begin\
        if ($sscanf(plusargs[j], $sformatf("+%s=%s", _variable_s, "[%d:%d]"), vmin, vmax)) begin\
            _variable = $urandom_range(vmin, vmax);\
        end else if ($sscanf(plusargs[j], $sformatf("+%s=%s", _variable_s, "[%h:%h]"), vmin, vmax)) begin\
            _variable = $urandom_range(vmin, vmax);\
        end else if ($sscanf(plusargs[j], $sformatf("+%s=%s", _variable_s, "%d"), idx)) begin\
            _variable = idx;\
        end else if ($sscanf(plusargs[j], $sformatf("+%s=%s", _variable_s, "%h"), idx)) begin\
            _variable = idx;\
        end\
    end

`define PLUS_DIGITAL(_variable, _default) \
    _variable = _default;\
    `PARSE_DIGITAL("``_variable", _variable)\
    `uvm_info($sformatf("plus_%s", plus_name), $sformatf("``_variable=%0d", _variable), UVM_LOW);

`define PLUS_DIGITAL_1A(_variable, _default) \
    foreach (_variable[i]) begin\
        _variable[i] = _default;\
        `PARSE_DIGITAL("``_variable", _variable[i])\
    end\
    foreach (_variable[i]) begin\
        `PARSE_DIGITAL($sformatf("``_variable[%0d]", i), _variable[i])\
    end\
    foreach (_variable[i]) \
        `uvm_info($sformatf("plus_%s", plus_name), $sformatf("``_variable[%0d]=%0d", i, _variable[i]), UVM_LOW);


`endif
