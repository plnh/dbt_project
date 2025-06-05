with
    gold as (
        select
            (cumulative_value - cumulative_cost) / cumulative_cost as margin, date_month
        from {{ ref("asset_metal_cost") }}
    ),
    m_margin as (select max(margin) as max_margin from gold),
    final as (
        select date_month
        from gold
        inner join m_margin on gold.margin = m_margin.max_margin
    )

select *
from final
