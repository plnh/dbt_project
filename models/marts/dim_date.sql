WITH dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2024-06-01' as date)",
        end_date="date_add(current_date(), interval 1 month)"
    ) }}
)


select 
    cast(date_month as date) as date_month,
    extract(year from date_month) as year,
    extract(month from date_month) as month,
    extract(quarter from date_month) as quarter,
    format_date('%B', date_month) as month_name,
    format_date('%Y-%m', date_month) as year_month
from dates_raw