/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_dec.sv
** Discription  : {{ifname}} agent parameter declare    
***************************************************************/
`ifndef __{{ifname|upper}}_DEC_SV__
`define __{{ifname|upper}}_DEC_SV__

package {{ifname}}_dec;
    
    parameter {{"%-20s"|format("VLD2DATA_DLY")}} = 0;
{% for fieldname in fields.keys() %}
    parameter {{"%-20s"|format(fieldname.upper() + "_WIDTH")}} = {{fields[fieldname]}};
{% endfor %}

endpackage

`endif
