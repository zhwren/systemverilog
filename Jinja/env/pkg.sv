/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_pkg.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} package
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_PKG_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_PKG_SV__

`include "{{cfg.proj_name}}_{{cfg.module_name}}_dec.sv"

package {{cfg.proj_name}}_{{cfg.module_name}}_pkg;
    import uvm_pkg::*;
{% for agt in cfg.env.keys() %}
    import {{agt}}_pkg::*;
{% endfor %}
    `include "{{cfg.proj_name}}_{{cfg.module_name}}_model.sv"
    `include "{{cfg.proj_name}}_{{cfg.module_name}}_e2e.sv"
    `include "{{cfg.proj_name}}_{{cfg.module_name}}_env.sv"
endpackage
import {{cfg.proj_name}}_{{cfg.module_name}}_pkg::*;

`endif
