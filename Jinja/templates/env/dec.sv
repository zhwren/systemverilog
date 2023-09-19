{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_DEC_SV__

package {{cfg.proj}}_{{cfg.module}}_dec;
    
{% for agent in cfg.agents %}
    parameter {{"%-20s"|format([agent.name,"_NUM"]|join|upper)}} = {{agent.inst_num}};
{% endfor %}

endpackage

`endif
