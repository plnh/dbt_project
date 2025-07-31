with
    owned_stock as (
        select
            ticker,
            sum(unit_owned) as unit_owned
            
        from {{ ref("stg_stock_transaction") }}
        group by 1
    ),
    avg_price as
    (
        select
            ticker,
            sum(total_cost) / sum(unit_owned) as avg_cost,
            sum(total_cost_lc ) / sum(unit_owned) as avg_cost_lc
            
        from {{ ref("stg_stock_transaction") }}
        where transaction_type like 'Buy'

        group by 1
    )

select a.ticker , avg_cost, avg_cost_lc
from avg_price a
inner join owned_stock b on a.ticker = b.ticker

    
