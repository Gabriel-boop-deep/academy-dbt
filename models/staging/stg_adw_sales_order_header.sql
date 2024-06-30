{{
    config(
        materialized='table'
    )
}}

with
    source_sales_order_header as (
        select *
        from {{ source('sap_adw', 'salesorderheader') }}
    )

    , formatted_sales_order_header as (
        select
            salesorderid as sales_order_id
            , customerid as customer_id
            , salespersonid as sales_person_id
            , territoryid as territory_id
            , billtoaddressid as bill_to_address_id
            , creditcardid as credit_card_id
            , date(orderdate) as order_date
            , date(shipdate) as ship_date
            , date(duedate) as due_date
            , case status
                when 1 then 'in progress'
                when 2 then 'approved'
                when 3 then 'backordered'
                when 4 then 'rejected'
                when 5 then 'shipped'
                when 6 then 'canceled'
                else 'unknown'
            end as order_status
            , onlineorderflag as online_order_flag
            , subtotal as sub_total
            , taxamt as tax_amt
            , totaldue as total_due
            , freight
        from source_sales_order_header
    )

select *
from formatted_sales_order_header
