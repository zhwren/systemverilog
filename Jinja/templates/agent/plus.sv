{{fhead}}

`ifndef __{{intf|upper}}_PLUS_SV__
`define __{{intf|upper}}_PLUS_SV__

`PLUS_DECLARE_BEGIN({{intf}})

{% for field in cfg.agent[intf]["field"] %}
`PLUS_VARIABLE_DEFINE(int, {{field}}_wt_min)
`PLUS_VARIABLE_DEFINE(int, {{field}}_wt_mid)
`PLUS_VARIABLE_DEFINE(int, {{field}}_wt_max)

{% endfor %}

`PLUS_PARSE_BEGIN
{% for field in cfg.agent[intf]["field"] %}
`PLUS_DIGITAL({{field}}_wt_min, 1)
`PLUS_DIGITAL({{field}}_wt_mid, 1)
`PLUS_DIGITAL({{field}}_wt_max, 1)

{% endfor %}
`PLUS_PARSE_END

`PLUS_DECLATE_END({{intf}})

`endif
