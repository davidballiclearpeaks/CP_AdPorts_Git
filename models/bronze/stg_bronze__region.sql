with 

source as (

    select * from {{ source('bronze', 'region') }}

),

renamed as (

    select
        r_regionkey,
        r_name as regionName,
        r_comment as regionComment

    from source

)

select * from renamed
