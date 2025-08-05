with 
source as 
(
    select *
    from {{ source("MyDoc", "Bank Account") }}

),

renamed as 
(

    select 
        cast( Date as date) as update_date,
        Asset_Name as asset_name,
        bank as type,
        Amount as value
    from source

)

select *
from renamed
