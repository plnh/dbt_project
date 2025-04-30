{% test is_numeric(model, column_name)%}

select {{column_name}}
from {{model}}
where SAFE_CAST( {{ column_name }} AS NUMERIC) IS NULL AND {{ column_name }} IS NOT NULL


{% endtest %}