select customerName, customerAddress
from {{ ref('stg_logical_bronze__customer_merge') }}