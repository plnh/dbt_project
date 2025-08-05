
with 
max_date as (
    select
    --asset_type,
    type, 
    --"EUR" as local_currency,
    DATE_TRUNC(update_date, MONTH) as month,
    max(update_date)  as max_date_of_month
    from {{ ref("stg_bank_acc") }}
    group by 1,2
    ) ,

result as (
    select
    a.asset_type,
    a.type, 
    a.update_date,
    "EUR" as local_currency,
    a.value 
    from {{ ref("stg_bank_acc") }} a
    inner join max_date b on a.type = b.type and a.update_date = b.max_date_of_month
)

select * from result
