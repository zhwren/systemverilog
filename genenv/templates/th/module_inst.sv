{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODULE_INST_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_MODULE_INST_SV__

{% if cfg.parameter.keys()|length == 0 %}
{{cfg.module}} u_{{cfg.module}} (
{% else %}
{{cfg.module}} #(
{% for param in cfg.parameter.keys() %}
    .{{"%-15s"|format(param)}}({{cfg.parameter[param]}}){% if not loop.last %},{% endif %}

{% endfor %}
) u_{{cfg.module}} (
{% endif %}
{% for agent in cfg.agents %}
{% if agent.inst_num == 1 %}
{% for field in agent.fields %}
    .{{"%-15s"|format(field.name)}}(top_if.{{agent.name}}_if[0].{{field.name}}),
{% endfor %}

{% else %}
{% for i in range(agent.inst_num) %}
{% for field in agent.fields %}
    .{{"%-15s"|format([field.name, i]|join("_"))}}(top_if.{{agent.name}}_if[{{i}}].{{field.name}}),
{% endfor %}

{% endfor %}
{% endif %}
{% endfor %}
    .clk            (clk),
    .rst_n          (rst_n)
);
`endif
