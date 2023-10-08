{{cfg.header}}

`ifndef __{{agent.name|upper}}_INTF_SV__
`define __{{agent.name|upper}}_INTF_SV__

interface {{agent.name}}_intf(input clk, input rst_n);

{% for field in agent.fields %}
    wire [{{agent.name}}_dec::{{"%-20s"|format(field.name|upper + "_WIDTH")}}-1:0] {{field.name}};
{% endfor %}

    clocking drv_cb @(posedge clk);
{% for field in agent.fields %}
        inout {{field.name}};
{% endfor %}
    endclocking

    clocking mon_cb @(posedge clk);
{% for field in agent.fields %}
        input {{field.name}};
{% endfor %}
    endclocking

endinterface

`endif
