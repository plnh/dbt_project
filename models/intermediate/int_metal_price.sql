with 
filter_transform as 
(
    select  
        update_date
        ,{{- cast_to_number("price") }} as price
        ,price_profile
        ,type
    from {{ref("stg_gold_price")}}
    where price_profile like "prime"
)
, normalize as
(
    SELECT
        DATE_TRUNC(update_date, MONTH) AS update_date,
        type, 
        AVG(price) AS average_price,
        AVG(price/31.1) AS avg_price_per_gram
    FROM filter_transform
    GROUP BY 1,2
    ORDER BY 1
)

select * 
from normalize

