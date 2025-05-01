{% set number_columns = [
    "unit_owned",
    "purchase_price",
    "net_value",
    "fee",
    "total_cost"
] %}

with
    transformed as (
        select
            asset_type,
            asset_name,
            ticker as type_ticker,
            case when type like "ETF" then "ETF" else lower(type) end as type,
            {{- cast_to_date("purchase_date") -}} as purchase_date,
            {%- for col in number_columns -%}
                {{ cast_to_number(col) }} as {{ col -}},
            {%- endfor %}
        from {{ ref("stg_stock_inv") }}
    )


select *
from transformed
