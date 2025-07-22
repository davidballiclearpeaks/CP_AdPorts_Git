with 

source as (

    select * from {{ source('bronze', 'nation') }}

),

renamed as (

    select
        --n_nationkey,
        n_name as nationName,
        n_regionkey,
        n_comment as nationComment

    from source

)

select * from renamed
