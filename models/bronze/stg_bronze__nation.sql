with 

source as (

    select * from {{ source('logical_bronze', 'nation') }}

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
