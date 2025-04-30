with 
source as 
(
    select *
    from {{ source('Live_price', 'gold_price') }}

),

renamed as 
(

    select 
        cast( timestamp as date) as date,
        ask as price,
        spreadProfile as price_profile,
        'GLD' as asset_type
    from source

)

select *
from renamed
