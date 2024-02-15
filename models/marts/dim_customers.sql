with 
    customer as (
        select *
        from {{ ref('stg_adw_customers') }}   
    )

    , person as (
        select *
        from {{ ref('stg_adw_person') }}
    ) 

    , dim_customer as (
        select
            customer.customer_id
            , person.person_name as customer_name
        from customer
        left join person 
            on customer.person_id = person.person_id
    )

    , dim_customer_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
            , *
        from dim_customer
    )

select *
from dim_customer_sk