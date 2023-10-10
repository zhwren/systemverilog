{{cfg.header}}

`ifndef __{{agent.name|upper}}_AGENT_CFG_SV__
`define __{{agent.name|upper}}_AGENT_CFG_SV__

class {{agent.name}}_agent_cfg extends configuration;
    virtual {{agent.name}}_intf vif;

    extern function new(string name="{{agent.name}}_cfg");
endclass

/*******************************************************************************
** Time        : {{"%-62s*"|format(cfg.time)}}
** Author      : generator                                                     *
** Description : Create                                                        *
*******************************************************************************/
function {{agent.name}}_agent_cfg::new(string name="{{agent.name}}_cfg");
    super.new(name);
endfunction

`endif
