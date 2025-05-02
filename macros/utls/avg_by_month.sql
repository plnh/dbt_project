{% macro avg_by_month(table, date_column,group_column, value_column, interval = 'month') %}
  SELECT
    group_column,
    DATE_TRUNC(interval, {{ date_column }}) AS week,
    AVG({{ value_column }}) AS average_price
  FROM {{ table }}
  GROUP BY 2
  ORDER BY 2
{% endmacro  %}
