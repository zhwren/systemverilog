{{fhead}}

`ifndef __{{intf|upper}}_INTF_SV__
`define __{{intf|upper}}_INTF_SV__

interface {{intf}}_intf(input clk, input rst_n);

{% for field in cfg.agent[intf]["field"] %}
    logic [{{intf}}_dec::{{"%-20s"|format([field,"_WIDTH"]|join|upper)}}-1:0] {{field}};
{% endfor %}

    clocking drv_cb @(posedge clk);
{% for field in cfg.agent[intf]["field"] %}
        inout {{field}};
{% endfor %}
    endclocking

    clocking mon_cb @(posedge clk);
{% for field in cfg.agent[intf]["field"] %}
        input {{field}};
{% endfor %}
    endclocking

endinterface

`endif
