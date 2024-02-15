with 
    stg_order_header_sales_reason as (
        select distinct *
        from {{ ref('stg_adw_sales_order_header_sales_reason') }}
    )

    , stg_adw_sales_reason as (
        select  *
        from {{ ref('stg_adw_sales_reason') }}
    )

    , dim_sales_reason as (
        select distinct
            stg_order_header_sales_reason.sales_order_id
            , string_agg(stg_adw_sales_reason.sales_reason_name, ', ') as sales_reason_name
        from stg_order_header_sales_reason
        left join stg_adw_sales_reason on
             stg_order_header_sales_reason.sales_reason_id =stg_adw_sales_reason.sales_reason_id
        group by sales_order_id
    )

   , dim_order_status_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_order_id', 'sales_reason_name']) }} as sales_reason_sk
            , *
        from dim_sales_reason
    )
select *
from dim_order_status_sk