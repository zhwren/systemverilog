+incdir+../th

{% for flist in cfg.filelists %}
-F {{flist}}
{% endfor %}

{% for f in cfg.files %}
{{f}}
{% endfor %}

{% for agent in cfg.agents %}
-F ../agent/{{agent.name}}/{{agent.name}}_flist.f
{% endfor %}

-F ../env/{{cfg.proj}}_{{cfg.module}}_flist.f
../th/harness.sv
-F ../tc/tc.list
