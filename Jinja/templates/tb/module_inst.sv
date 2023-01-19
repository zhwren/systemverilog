{{fhead}}

`ifndef __MODULE_INST_SV__
`define __MODULE_INST_SV__

{{cfg.module|upper}} u_{{cfg.module}} (
{% for agent in cfg.agent.keys() %}
{% if cfg.agent[agent].inst_num == 1 %}
{% for field in cfg.agent[agent]["field"] %}
    .{{"%-15s"|format(field)}}(top_if.{{agent}}_if[0].{{field}}),
{% endfor %}

{% else %}
{% for i in range(cfg.agent[agent].inst_num) %}
{% for field in cfg.agent[agent]["field"] %}
    .{{"%-15s"|format([field, i]|join("_"))}}(top_if.{{agent}}_if[{{i}}].{{field}}),
{% endfor %}

{% endfor %}
{% endif %}
{% endfor %}
    .clk            (clk),
    .rst_n          (rst_n)
);
`endif
