with
    source as (
        select *
        from {{ source("MyDoc", "Physical Asset") }}
        where string_field_0 is not null and string_field_0 not like 'Asset Name'
    ),

    renamed as (
        {%- set column_name = [
            "asset_name",
            "unit_type",
            "weight_gram",
            "unit_owned",
            "purchase_date",
            "purchase_price",
            "net_value",
            "fee",
            "total_cost",
        ] -%}

        select
            "metal_assets" as asset_type,
            SPLIT(string_field_1, ' ')[OFFSET(0)] as type, 
            {%- for i in range(9) %}
                string_field_{{ i }} as {{ column_name[i] }}
                {%- if not loop.last -%}, {%- endif -%}
            {%- endfor %}
        from source
    )

select 
    *
from renamed
