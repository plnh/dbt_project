with 
source as 
(
    select *
    from {{ source('MyDoc', 'Stock Inventory') }}
    where string_field_0 is not null and string_field_0 not like 'Asset Name'

),

renamed as (
        {%- set column_name = [
            "asset_name",
            "ticker",
            "type",
            "sector",
            "purchase_date",
            "unit_owned",
            "purchase_price",
            "net_value",
            "fee",
            "total_cost",
        ] -%}

        select
            "financial_assets" as asset_type,
            {%- for i in range(10) %}
                string_field_{{ i }} as {{ column_name[i] }}
                {%- if not loop.last -%}, {%- endif -%}
            {%- endfor %}
        from source
    )

select *
from renamed