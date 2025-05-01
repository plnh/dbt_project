{% macro cast_to_date(column_name)%}
    coalesce(
        PARSE_DATE('%Y-%m-%d', {{ column_name }}),
        PARSE_DATE('%m/%d/%Y', {{ column_name }}),
        PARSE_DATE('%d/%m/%Y', {{ column_name }}),
        PARSE_DATE('%Y/%m/%d', {{ column_name }}),
        PARSE_DATE('%d-%m-%Y', {{ column_name }}),
        PARSE_DATE('%m-%d-%Y', {{ column_name }})
    )
{% endmacro %}