SELECT 
    ROUND(SUM(gross_value), 2) AS valor_total_negociado
FROM 
    {{ ref('fct_sale_details') }}
WHERE 
    EXTRACT(YEAR FROM order_date) = 2011

