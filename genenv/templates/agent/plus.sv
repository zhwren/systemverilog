{{cfg.header}}

`ifndef __{{agent.name|upper}}_PLUS_SV__
`define __{{agent.name|upper}}_PLUS_SV__

`PLUS_DECLARE_BEGIN({{agent.name}})

{% for field in agent.fields %}
`PLUS_VARIABLE_DEFINE(int, {{field.name}}_wt_min)
{% if field.width > 1 %}
`PLUS_VARIABLE_DEFINE(int, {{field.name}}_wt_mid)
{% endif %}
`PLUS_VARIABLE_DEFINE(int, {{field.name}}_wt_max)

{% endfor %}

`PLUS_PARSE_BEGIN

{% for field in agent.fields %}
`PLUS_DIGITAL({{"%-20s"|format(field.name + "_wt_min,")}} 1)
{% if field.width > 1 %}
`PLUS_DIGITAL({{"%-20s"|format(field.name + "_wt_mid,")}} 1)
{% endif %}
`PLUS_DIGITAL({{"%-20s"|format(field.name + "_wt_max,")}} 1)

{% endfor %}
`PLUS_PARSE_END

`PLUS_DECLARE_END({{agent.name}})
`endif
