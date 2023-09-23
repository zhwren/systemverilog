{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_PLUS_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_PLUS_SV__

`PLUS_DECLARE_BEGIN({{cfg.proj}}_{{cfg.module}})

`PLUS_VARIABLE_DEFINE(int, stop_error_cnt)

`PLUS_PARSE_BEGIN
`PLUS_DIGITAL(stop_error_cnt, 100)
`PLUS_PARSE_END

`PLUS_DECLARE_END({{cfg.proj}}_{{cfg.module}})
`endif
