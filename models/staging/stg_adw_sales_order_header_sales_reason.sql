with
    source_sales_reason as (
        select *
        from {{ source('sap_adw', 'salesorderheadersalesreason') }}
    )

    , formatted_sales_reason as (
        select
            salesorderid as sales_order_id
            , salesreasonid as sales_reason_id
        from source_sales_reason
    )

select *
from formatted_sales_reason
-- Melhorar esse código
