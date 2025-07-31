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
    )

select
    asset_type,
    purchase_date	,
    asset_name ,
    transaction_type,
    ticker,
    unit_owned,
    local_currency ,
    FX,
    CASE WHEN local_currency LIKE 'EUR' THEN purchase_price_lc
        ELSE purchase_price_lc END AS purchase_price,
    fee ,
    purchase_price_lc,
    CASE WHEN local_currency not LIKE 'EUR' THEN fee/FX
        ELSE fee END AS fee_lc

from renamed