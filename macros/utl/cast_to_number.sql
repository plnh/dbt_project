{% macro cast_to_number(column_name, default_type='FLOAT64') %}
    SAFE_CAST({{ column_name }} AS {{ default_type }})
{% endmacro %}