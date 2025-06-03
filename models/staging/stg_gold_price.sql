with 
source as 
(
    select *
    from {{ source('Live_price', 'gold_price') }}

),

renamed as 
(

    select 
        cast( timestamp as date) as update_date,
        ask as price,
        case when spreadProfile like 'manual_entry' then 'prime' else spreadProfile end as price_profile,
        'Gold' as type
    from source

)

select *
from renamed
