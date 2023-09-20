+incdir+../th

{% for flist in cfg.filelists %}
-F {{flist}}
{% endfor %}

{% for f in cfg.files %}
{{f}}
{% endfor %}

-F ../env/{{cfg.proj}}_{{cfg.module}}_flist.f
../th/harness.sv
-F ../tc/tc.list
