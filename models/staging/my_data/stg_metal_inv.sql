with 
source as 
(
    select *
    from {{ source('MyDoc', 'Physical Asset') }}
    where string_field_0 is not null
),

renamed as 
(

    select 
        *
    from source

)

select *
from renamed
