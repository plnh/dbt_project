with
    fact_table as (
        select
            asset_type,
            type,
            date_trunc(purchase_date, month) as purchase_month,
            sum(total_cost) as total_cost,
            sum(total_weight_gram) as total_weight_gram
        from {{ ref("int_metal_inv") }}
        group by 1, 2, 3
    ),
    dim_date as (select date_month, year_month from {{ ref("dim_date") }}),

    final_fact as (
        select
            d.date_month,
            d.year_month,
            -- SUM(f.total_cost) as monthly_total,
            sum(f.total_cost) over (order by d.date_month) as cumulative_cost,
            sum(f.total_weight_gram) over (order by d.date_month) as cumulative_weight

        from dim_date d
        left join fact_table f on f.purchase_month = d.date_month
        order by d.date_month
    ),
    price as (select * from {{ ref("int_metal_price") }})

select
    f.*, "metal_assets" as asset_type, "gold" as asset_desc,
    round((f.cumulative_weight * p.avg_price_per_gram), 2) as cumulative_value,
    round(
        (f.cumulative_weight * p.avg_price_per_gram) - cumulative_cost, 2
    ) as gain_loss

from final_fact f
LEFT JOIN price p on f.date_month = p.update_date
order by f.date_month desc
