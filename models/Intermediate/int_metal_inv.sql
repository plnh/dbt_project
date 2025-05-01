with
staging as (

    select * from {{ ref('stg_metal_inv') }}

),
    transformed as (
       select 
    asset_type ,
    type, 
    asset_name,
    unit_type,
    cast(weight_gram as FLOAT64)  as weight_gram,
    cast(unit_owned as INT64 )as unit_owned,
    purchase_date,
    cast(purchase_price as FLOAT64) as purchase_price,
    cast(net_value as FLOAT64) as net_value,
    cast(fee as FLOAT64) as fee,
    cast(total_cost as FLOAT64) as total_cost

from staging

select * from transformed
