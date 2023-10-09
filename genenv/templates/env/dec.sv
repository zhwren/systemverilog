{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__

package {{cfg.proj}}_{{cfg.module}}_dec;
    
{% for agent in cfg.agents %}
    parameter {{"%-20s"|format([agent.name|upper,"NUM"]|join("_"))}} = {{agent.inst_num}};
{% endfor %}

{% for agent in cfg.subenvs %}
    parameter {{"%-20s"|format([cfg.proj|upper,agent.name|upper,"ENV_NUM"]|join("_"))}} = {{agent.inst_num}};
{% endfor %}

endpackage

`endif
