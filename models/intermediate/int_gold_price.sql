with 
filter_transform as (

    select update_date,
        {{cast_to_number("price")}} as price,
        price_profile,
        asset_type

    from {{ref("stg_gold_price")}}

    where DATE_DIFF(update_date, current_date, Day) < 8
        --and price_profile like 'prime'
 
),
averaged as
(
    select 
        current_date as update_date,
        price_profile,
        asset_type,
        price,
        AVG(price) over (partition by price_profile) as avg_price
    from filter_transform

)

select * from averaged