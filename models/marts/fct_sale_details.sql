with 
    dim_address as (
        select *
        from {{ ref('dim_address') }}
    )

    , dim_credit_card as (
        select *
        from {{ ref('dim_credits_card') }}
    )

    , dim_customer as (
        select *
        from {{ ref('dim_customers') }}
    )

    , dim_dates as (
        select *
        from {{ ref('dim_dates') }}
    )

    , dim_employee as (
        select *
        from {{ ref('dim_employee') }}
    )

    , dim_sales_reason as (
        select *
        from {{ ref('dim_sales_reason') }}
    )

    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )

    , fact_table as (
        select *  
        from {{ ref('int_sales__order_itens') }}
    )

    , joined_table as (
        select 
            {{ dbt_utils.generate_surrogate_key(['fact_table.sales_order_detail_id', 'fact_table.sales_order_id', 'dim_sales_reason.sales_reason_sk']) }} as metrics_sk
            , fact_table.sales_order_id
            , dim_address.address_sk as address_fk
            , dim_credit_card.credit_card_sk as credit_card_fk
            , dim_customer.customer_sk as customer_fk
            , dim_employee.employee_sk as employee_fk
            , dim_sales_reason.sales_reason_sk as sales_reason_fk
            , dim_products.product_sk as product_fk
            , dim_dates.metric_date 
            , fact_table.ship_date
            , fact_table.due_date
            , fact_table.order_date
            , fact_table.order_status
            , fact_table.online_order_flag
            , fact_table.sub_total
            , fact_table.tax_amt
            , fact_table.freight
            , fact_table.total_due
            , fact_table.order_qty
            , fact_table.unit_price
            , fact_table.unit_price_discount
        from fact_table
        left join dim_address 
            on fact_table.bill_to_address_id = dim_address.address_id
        left join dim_credit_card
            on fact_table.credit_card_id = dim_credit_card.credit_card_id
        left join dim_customer
            on fact_table.customer_id = dim_customer.customer_id
        left join dim_dates
            on fact_table.order_date = dim_dates.metric_date
        left join dim_sales_reason
            on fact_table.sales_order_id = dim_sales_reason.sales_order_id
        left join dim_products
            on fact_table.product_id = dim_products.product_id
        left join dim_employee
            on fact_table.sales_person_id = dim_employee.sales_person_id
    )
    , fact_metrics as (
        select 
            metrics_sk
            , address_fk
            , credit_card_fk
            , customer_fk
            , sales_reason_fk
            , product_fk
            , employee_fk
            , sales_order_id
            , metric_date 
            , ship_date
            , due_date
            , order_date
            , order_status
            , online_order_flag
            , sub_total
            , tax_amt
            , freight
            , total_due
            , order_qty
            , unit_price
            , unit_price_discount
            , unit_price * order_qty as gross_value
            , unit_price * order_qty - (1 - unit_price_discount) as net_total
        from joined_table
    )

select *
from fact_metrics