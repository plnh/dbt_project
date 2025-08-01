with 
source as 
(
    select  
        update_date
        ,{{- cast_to_number("price") }} as price
        ,ticker
    from {{ref("stg_stock_price")}}
)
, normalize as
(
    SELECT
        DATE_TRUNC(update_date, MONTH) AS update_date,
        ticker, 
        Round(AVG(price),2) AS average_price
    FROM source
    GROUP BY 1,2
    ORDER BY 1, 2
)

select * 
from normalize

