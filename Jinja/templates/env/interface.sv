{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_INTF_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_INTF_SV__

interface {{cfg.proj}}_{{cfg.module}}_intf(input clk, input rst_n);
{% for agent in cfg.agents %}
    virtual {{"%-15s"|format(agent.name+"_intf")}} {{agent.name}}_vif[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM];
{% endfor %}

{% for agent in cfg.agents %}
    {{"%-15s"|format(agent.name+"_intf")}}         {{agent.name}}_if[{{cfg.proj}}_{{cfg.module}}_dec::{{agent.name|upper}}_NUM](clk, rst_n);
{% endfor %}

    initial begin
{% for agent in cfg.agents %}
        {{"%-15s"|format(agent.name+"_vif")}} = {{agent.name}}_if;
{% endfor %}
    end

endinterface

`endif
