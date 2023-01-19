{{fhead}}

`ifndef __{{intf|upper}}_DEC_SV__
`define __{{intf|upper}}_DEC_SV__

package {{intf}}_dec;
    
    parameter {{"%-20s"|format("VLD2DATA_DLY")}} = 0;
{% for i in range(cfg.agent[intf]["field"]|length) %}
{% set field = cfg.agent[intf]["field"][i] %}
{% set width = cfg.agent[intf]["width"][i] %}
    parameter {{"%-20s"|format([field,"_WIDTH"]|join|upper)}} = {{width}};
{% endfor %}

endpackage

`endif
