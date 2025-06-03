With 
dates_raw as (
    /* generating dates using the macro from the dbt-utils package */
    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2024-06-01' as date)",
        end_date="current_date()"
        )
    }}
)


select 
    cast(date_month as date) as date_month,
    extract(year from date_month) as year,
    extract(month from date_month) as month,
    extract(quarter from date_month) as quarter,
    format_date('%B', date_month) as month_name,
    format_date('%Y-%m', date_month) as year_month
from dates_raw