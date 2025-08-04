
with 
transaction as (
    select
    asset_type,
    ticker, local_currency,
    DATE_TRUNC(purchase_date, MONTH) AS purchase_month,
    sum(unit_owned) as unit_owned

    from {{ ref("stg_stock_transaction") }}
    group by 1,2,3,4
    )


,dim_date as (
    select date_month, year_month from {{ ref("dim_date") }}
    )
, ticker_date as (
    select d.* , asset_type, ticker, local_currency
    from dim_date d
    cross join (select asset_type, ticker, local_currency, min(purchase_month) as min_date from transaction group by 1,2,3 ) x 
    where d.date_month >= min_date
    order by ticker, date_month
)
, fact_table as (
    select
        d.date_month, d.year_month, d.asset_type, d.ticker, d.local_currency,  unit_owned,
        sum(unit_owned) over (partition by d.asset_type, d.ticker order by  d.date_month) as cumulative_units
    from transaction t 
    right join ticker_date d on  t.ticker = d.ticker and t.purchase_month = d.date_month
    order by d.asset_type, d.ticker, d.date_month
    )

select * from   fact_table
 
 
