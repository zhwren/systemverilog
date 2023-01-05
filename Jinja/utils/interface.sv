/***************************************************************
**            Coryright @                               
****************************************************************
** Author       : generator                             
** Last modified: {{time}}
** Filename     : {{ifname}}_interface.sv
** Discription  : {{ifname}} interface declare    
***************************************************************/

`ifndef __{{ifname|upper}}_INTF_SV__
`define __{{ifname|upper}}_INTF_SV__

interface {{ifname}}_intf(input clk, input rst_n);

{% for key in fields.keys() %}
    logic [{{ifname}}_dec::{{"%-20s"|format(key.upper() + "_WIDTH")}}-1:0] {{key}};
{% endfor %}

    clocking drv_cb @(posedge clk);
{% for key in fields.keys() %}
        inout {{key}};
{% endfor %}
    endclocking

    clocking mon_cb @(posedge clk);
{% for key in fields.keys() %}
        input {{key}};
{% endfor %}
    endclocking

endinterface

`endif
