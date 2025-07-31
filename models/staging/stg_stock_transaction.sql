with 
source as 
(
    select *
    from {{ source('MyDoc', 'Stock Inventory') }}

),

renamed as (
        select
            "financial_assets" as asset_type,
            Date as purchase_date	,
            Description	as asset_name ,
            Transaction_Type as transaction_type,
            Symbol	as ticker,
            Quantity as unit_owned,
            CAST( SPLIT(Price_currency, ' ')[OFFSET(0)] AS NUMERIC) as purchase_price_lc,
            SPLIT(Price_currency, ' ')[SAFE_OFFSET(2)] AS local_currency,
            Commission_in_EUR *(-1) as fee,
            Exchange_Rate as FX
        from source
    ),
transformed as (
select
    *,
    CASE WHEN local_currency LIKE 'EUR' THEN purchase_price_lc
        ELSE purchase_price_lc END AS purchase_price,
    CASE WHEN local_currency not LIKE 'EUR' THEN fee/FX
        ELSE fee END AS fee_lc

from renamed)

select * ,
purchase_price_lc*unit_owned + fee_lc as total_cost_lc,
purchase_price*unit_owned + fee as total_cost
from transformed