{{ config(
    materialized='incremental',      
    incremental_strategy='insert_overwrite'  
) }}

with 

source as (

    select * from {{ source('logical_bronze', 'customer') }}
        {% if is_incremental() %}
        where c_custkey > (select max(c_custkey) from {{ this }})
        {% endif %}
),

renamed as (

    select
        c_custkey,
        {{ dbt_utils.generate_surrogate_key(['c_custkey', 'c_name']) }} as du_surrogate_key,
        {{ cp_generate_surrogate_key(['c_custkey', 'c_name']) }} as cp_surrogate_key,
        c_name as customerName,
        c_address as customerAddress,
        c_nationkey as nationKey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment

    from source

)

select * from renamed
