select
    regionname,
    count(*) as nationcount,
    min(nationname) as firstnation,
    max(nationname) as lastnation
from {{ ref("extendedNation") }}
group by regionname
