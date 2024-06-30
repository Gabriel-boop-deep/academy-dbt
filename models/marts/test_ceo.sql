select round(sum(gross_value), 2) as valor_total_negociado
from
    {{ ref('fct_sale_details') }}
where
    extract(year from order_date) = 2011
