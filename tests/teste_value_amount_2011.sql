with gross_value_2011 as (
    select
        round(sum(unit_price*order_qty), 3) as gross_value
        
    from {{ ref('fct_sale_details') }}
    where extract(year from metric_date) = 2011
)

select * 
from gross_value_2011
