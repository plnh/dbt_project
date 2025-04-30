{%- set inv_models = dbt_utils.get_relations_by_pattern(schema_pattern='dbt_hpham', table_pattern='%_inv') %}

{%- if inv_models | count == 0 %}
    select null as dummy
    {% else %}

        {% for t in inv_models %}
            select * from {{t}} 
            {% if not loop.last%}
                union all
            {% endif %}
        {% endfor %}

{% endif %}