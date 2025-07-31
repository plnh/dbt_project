{% set margin_cal = "(cumulative_value - cumulative_cost) / cumulative_cost" %}

select date_month , round(margin*100,2) as margin_percentage
from (
    select 
        date_month,
        {{ margin_cal }} as margin,
        max( {{ margin_cal }} ) over () as max_margin
    from {{ ref("asset_metal_cost") }}
) ranked
where margin = max_margin