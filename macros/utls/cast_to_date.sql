{% macro cast_to_date(column_name)%}
    coalesce(
        SAFE.PARSE_DATE('%Y-%m-%d', {{ column_name }}),
        SAFE.PARSE_DATE('%m/%d/%Y', {{ column_name }}),
        SAFE.PARSE_DATE('%d/%m/%Y', {{ column_name }}),
        SAFE.PARSE_DATE('%Y/%m/%d', {{ column_name }}),
        SAFE.PARSE_DATE('%d-%m-%Y', {{ column_name }}),
        SAFE.PARSE_DATE('%m-%d-%Y', {{ column_name }})
    )
{% endmacro %}