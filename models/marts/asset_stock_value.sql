with
    fact_table as (
        select
            date_month,
            year_month,
            asset_type,
            ticker,
            local_currency,
            cumulative_units
        from {{ ref("int_stock_inv") }}
    ),

    
    price as (

        select update_date, ticker, average_price
        
        from {{ ref("int_stock_price") }}
        
    ),
     
    final as (
        select
            f.date_month,
            f.year_month,
            f.ticker,
            f.local_currency,
            f.cumulative_units,
            p.average_price
        from fact_table f
        inner join price p on f.ticker = p.ticker and f.date_month =p.update_date
        
    )


select * 
    , cumulative_units*average_price as total_value
from final