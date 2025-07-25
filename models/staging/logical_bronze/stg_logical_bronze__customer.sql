with 

source as (

    select * from {{ source('logical_bronze', 'customer') }}

),

renamed as (

    select
        --c_custkey,
        c_name as customerName,
        c_address as customerAddress,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment

    from source

)

select * from renamed
