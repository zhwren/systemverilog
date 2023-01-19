{{fhead}}

`ifndef __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__
`define __{{cfg.proj|upper}}_{{cfg.module|upper}}_PKG_SV__

`include "{{cfg.proj}}_{{cfg.module}}_dec.sv"
`include "{{cfg.proj}}_{{cfg.module}}_top_if.sv"

package {{cfg.proj}}_{{cfg.module}}_pkg;
    import uvm_pkg::*;
{% for agent in cfg.agent.keys() %}
    import {{agent}}_pkg::*;
{% endfor %}
    `include "{{cfg.proj}}_{{cfg.module}}_model.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_e2e.sv"
    `include "{{cfg.proj}}_{{cfg.module}}_env.sv"
endpackage
import {{cfg.proj}}_{{cfg.module}}_pkg::*;

`endif
