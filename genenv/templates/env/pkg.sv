{{cfg.header}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__

`include "{{cfg.proj}}_{{cfg.module}}_dec.sv"
`include "{{cfg.proj}}_{{cfg.module}}_interface.sv"

package {{cfg.proj}}_{{cfg.module}}_pkg;
    import uvm_pkg::*;
    import common_pkg::*;
{% for agent in cfg.agents %}
    import {{agent.name}}_pkg::*;
{% endfor %}

{% for agent in cfg.internal_agents %}
    import {{cfg.proj}}_{{agent.name}}_pkg::*;
{% endfor %}

    `include "{{cfg.proj}}_{{cfg.module}}_plus.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_model.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_e2e.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_env.sv"
endpackage
import {{cfg.proj}}_{{cfg.module}}_pkg::*;

`endif
