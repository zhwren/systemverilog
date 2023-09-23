+incdir+.

{% for agent in cfg.agents %}
-F ../agent/{{agent.name}}/{{agent.name}}_flist.f
{% endfor %}

{{cfg.proj}}_{{cfg.module}}_pkg.sv
