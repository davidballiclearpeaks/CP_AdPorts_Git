select nationname, nationcomment, regionname, regioncomment
from {{ ref("stg_bronze__nation") }} n
left join {{ ref("stg_bronze__region") }} r on r.r_regionkey = n.n_regionkey
