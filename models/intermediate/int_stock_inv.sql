{% set columns = [
    "purchase_price",
    "purchase_price_lc",
    "fee",
    "fee_lc",
    "total_cost",
    "total_lc"
] %}

select
asset_type, 
ticker, 
unit_owned,
{%- for col in columns -%}
    {{ convert_to_zero(col) }} ,
{%- endfor %}
date_trunc(purchase_date, month) as purchase_month
        from {{ ref("stg_stock_transaction") }}
from {{ ref("stg_stock_transaction") }}