+incdir+.

{% for agent in cfg.agents %}
-F ../agent/{{agent.name}}/{{agent.name}}_flist.f
{% endfor %}
{% for agent in cfg.internal_agents %}
-F {{cfg.subenv_path}}/{{agent.name}}/env/{{cfg.proj}}_{{agent.name}}_flist.f
{% endfor %}

{{cfg.proj}}_{{cfg.module}}_pkg.sv
