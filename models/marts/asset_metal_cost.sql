with 
asset as 
( 
    select asset_type
        , type
        , asset_name
        , type_ticker
        , DATE_TRUNC(purchase_date, MONTH) AS purchase_month
        , total_cost
        , total_weight_gram
    from {{ ref("int_metal_inv") }}
),

total_cost as 
(
    select 
        asset_type
        , type
        , purchase_month
        , sum(total_cost) as total_cost
        , sum(total_weight_gram) as total_weight_gram
    from asset
    group by 
        1,2,3
),

price as 
(
    select *
    from {{ref("int_metal_price")}}
)

select *
from total_cost A
left join price B ON A.type = B.type

