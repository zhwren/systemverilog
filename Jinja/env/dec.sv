/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{cfg.proj_name}}_{{cfg.module_name}}_dec.sv
** Discription  : {{cfg.proj_name}}_{{cfg.module_name}} env parameter declare    
***************************************************************/
`ifndef __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_DEC_SV__
`define __{{cfg.proj_name|upper}}_{{cfg.module_name|upper}}_DEC_SV__

package {{cfg.proj_name}}_{{cfg.module_name}}_dec;
    
{% for agent in cfg.env.keys() %}
    parameter {{"%-20s"|format(agent.upper() + "_NUM")}} = {{cfg.env[agent].inst_num}};
{% endfor %}

endpackage

`endif
