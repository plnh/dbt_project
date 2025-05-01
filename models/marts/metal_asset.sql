{% set pure_weight_query = "case when unit_type like '%Coin' then weight_gram*0.9 else weight_gram end" %}

with
metal_inv as (

    select * from {{ ref('stg_metal_inv') }}

)

select * 
    , {{pure_weight_query}} as pure_weight
    --, {{pure_weight_query}} * unit_owned as total_weight

from metal_inv
