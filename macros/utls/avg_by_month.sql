{% macro avg_by_month(table, date_column, value_column, interval = 'month') %}
  SELECT
    DATE_TRUNC({{interval}}, {{ date_column }}) AS update_date,
    AVG({{ value_column }}) AS average_price
  FROM {{ table }}
  GROUP BY 1
  ORDER BY 1
{% endmacro  %}
