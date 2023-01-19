{{fhead}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__

package {{cfg.proj}}_{{cfg.module}}_dec;
    
{% for agent in cfg.agent.keys() %}
    parameter {{"%-20s"|format([agent,"_NUM"]|join|upper)}} = {{cfg.agent[agent].inst_num}};
{% endfor %}

endpackage

`endif
