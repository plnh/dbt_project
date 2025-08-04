with
    metal_assets as (
        select
            date_month,
            year_month,
            asset_type,
            asset_desc,
            "EUR" as,
            sum(cumulative_value) as cumulative_value
        from {{ ref("asset_metal_cost") }}
        group by 1,2,3,4
    ),

    stock_assets as (
        select
            date_month,
            year_month,
            asset_type,
            asset_desc,
            local_currency,
            sum(cumulative_value) as cumulative_value
        from {{ ref("asset_stock_value") }}
        group by 1,2,3,4,5
    )

select * 
from stock_assets
union all
select *
from metal_assets