`ifdef FCOV_VARIABLE
    class {{cg.name}}_transaction extends uvm_object;
{% for field in cg.fields %}
        bit [{{field.width-1}}:0] {{field.name}};
{% endfor %}

        function new(string name="{{cg.name}}_transaction");
            super.new(name);
        endfunction
    endclass
`elsif FCOV_DECLARE
    {{cg.name}}_transaction {{cg.name}}_tr;

    covergroup {{cg.name}}_cg;
{% for field in cg.fields %}
        {{field.name}}_cp : coverpoint {{cg.name}}_tr.{{field.name}} {
            bins {{field.name}}_min = { {{field.dmin}} };
{% if field.dmax - field.dmin > 1 %}
            bins {{field.name}}_mid = {[{{field.dmax-1}}:{{field.dmin+1}}]};
{% endif %}
            bins {{field.name}}_max = { {{field.dmax}} };

{% for i in range(field.width) %}
            wildcard bins {{field.name}}_{{i}}_0 = { {{field.width}}'b{{"?"*(field.width-i-1)}}0{{"?"*i}} };
            wildcard bins {{field.name}}_{{i}}_1 = { {{field.width}}'b{{"?"*(field.width-i-1)}}1{{"?"*i}} };
{% endfor %}
        }

{% endfor %}
{% if cg.fields|length > 1 %}
        cross
{%- for field in cg.fields %}
 {{field.name}}_cp{% if not loop.last %},{% endif %}
{% endfor %} {
{% for cig in cg.cignores %}
            ignore_bins igr_{{loop.index0}} =
{%- for key in cig.keys() %}
 binsof({{key}}_cp) intersect { {{cig[key]}} } {% if not loop.last %}&&{%endif%}
{%- endfor %};
{% endfor %}
        }
{% endif %}

        option.per_instance = 1;
    endgroup

    function {{cg.name}}_sample(
{%- for field in cg.fields %}
bit [{{field.width-1}}:0] {{field.name}}{% if not loop.last %}, {% endif %}
{%- endfor -%});
{% for field in cg.fields %}
        {{cg.name}}_tr.{{field.name}} = {{field.name}};
{% endfor %}
        {{cg.name}}_cg.sample();
    endfunction
`elsif FCOV_INST
    {{cg.name}}_cg = new();
    {{cg.name}}_tr = new();
`endif

