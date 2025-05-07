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
        spreadProfile as price_profile,
        'gold' as asset_type
    from source

)

select *
from renamed
