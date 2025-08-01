{% set number_columns = [
    "weight_gram",
    "purchase_price",
    "net_value",
    "fee",
    "total_cost"
] %}

with
    transformed as (
        select
            asset_type,
            (trim(type)) as type,
            asset_name,
            lower(trim(SPLIT(unit_type, ' ')[OFFSET(1)])) as type_ticker,
            {{- cast_to_date("purchase_date") -}} as purchase_date,
            {{- cast_to_number("unit_owned", "INT64") -}} as unit_owned,
            case when lower(unit_type) like '%coin%' then 0.9 else 1 end as purity,
            {%- for col in number_columns -%}
                {{ cast_to_number(col) }} as {{ col -}},
            {%- endfor %}

        from {{ ref("stg_metal_inv") }}
    ),
    computed as (
        select *, (weight_gram * purity) * unit_owned as total_weight_gram
        from transformed
    )

select *
from computed
