with 
source as 
(
    select *
    from {{ source('Live_price', 'stock_price') }}

),

renamed as 
(

    select 
        cast( date as date) as update_date,
        ticker , price
    from source

)

select *
from renamed
