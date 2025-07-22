select nationkey, count(1) as cntcustomer
from {{ ref("customerIntermediate") }}
group by 1
