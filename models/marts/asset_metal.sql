with 
asset as 
( 
    select asset_type
        , type
        , asset_name
        , type_ticker
        , purchase_date
        , total_weight_gram
    from {{ ref("int_metal_inv") }}
),
price as 
(
    select *
    from {{ref("int_metal_price")}}
)

select *
from price
