{{cfg.header}}

`ifndef __{{agent.name|upper}}_DEC_SV__
`define __{{agent.name|upper}}_DEC_SV__

package {{agent.name}}_dec;

    parameter {{"%-20s"|format("VLD2DATA_DELAY")}} = {{agent.vld2data_dly}};
{% for field in agent.fields %}
    parameter {{"%-20s"|format(field.name|upper + "_WIDTH")}} = {{field.width}};
{% endfor %}

endpackage

`endif
