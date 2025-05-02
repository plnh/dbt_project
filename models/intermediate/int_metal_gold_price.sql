with 
filter_transform as 
(
    select 
    update_date,
        {{cast_to_number("price")}} as price,
        price_profile,
        asset_type
    from {{ref("stg_gold_price")}}
    where price_profile like "prime"
),
averaged as
(
    {{- avg_by_month("filter_transform", "update_date", "price") -}}
)

select * from averaged

