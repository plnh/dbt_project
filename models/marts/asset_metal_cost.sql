with 
fact_table as 
(
    select 
        asset_type
        , type
        , DATE_TRUNC(purchase_date, MONTH) AS purchase_month
        , sum(total_cost) as total_cost
        , sum(total_weight_gram) as total_weight_gram
    from {{ ref("int_metal_inv") }}
    group by 
        1,2,3
)
, 
dim_date as 
( 
    select date_month,
        year_month
    from {{ ref("dim_date") }}
),

final_fact as
(
SELECT 
    d.date_month,
    d.year_month,
    --SUM(f.total_cost) as monthly_total,
    SUM(f.total_cost) OVER (ORDER BY d.date_month) as cumulative_cost,
    SUM(f.total_weight_gram) OVER (ORDER BY d.date_month) as cumulative_weight

FROM dim_date d
LEFT JOIN fact_table f ON f.purchase_month = d.date_month
ORDER BY d.date_month
)
,
price as
(
select * from {{ ref("int_metal_price") }}
)

select f.*,
    f.cumulative_weight * p.avg_price_per_gram as cumulative_value

from final_fact f
left join price p on f.date_month = p.update_date 
