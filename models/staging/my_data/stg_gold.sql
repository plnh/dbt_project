with 
source as 
(
    select *
    from {{ source('my_data', 'gold_price') }}

),

renamed as 
(

    select 
        timestamp as timestamp,
        ask as price,
        spreadProfile as price_profile,
        'GLD' as asset_type
    from source

)

select *
from renamed
