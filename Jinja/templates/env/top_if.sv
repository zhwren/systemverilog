{{fhead}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_IF_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_TOP_IF_SV__

interface {{cfg.proj}}_{{cfg.module}}_top_if(input clk, input rst_n);
{% for agent in cfg.agent.keys() %}
    virtual {{agent}}_intf {{agent}}_vif[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM];
    {{agent}}_intf         {{agent}}_if[{{cfg.proj}}_{{cfg.module}}_dec::{{agent|upper}}_NUM](clk, rst_n);

{% endfor %}
{% for agent in cfg.agent.keys() %}
    initial begin {{agent}}_vif = {{agent}}_if; end

{% endfor %}
endinterface

`endif
