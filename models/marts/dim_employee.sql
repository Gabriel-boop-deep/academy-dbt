WITH 
    customer AS (
        SELECT *
        FROM {{ ref('stg_adw_customers') }}   
    ),

    person AS (
        SELECT *
        FROM {{ ref('stg_adw_person') }}
    ),

    dim_customer AS (
        SELECT
            c.customer_id
            , p.person_name AS customer_name
        FROM customer c
        LEFT JOIN person p 
            ON c.person_id = p.person_id
    ),

    dim_customer_sk AS (
        SELECT
            {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_sk
            , customer_id
            , customer_name
        FROM dim_customer
    )

SELECT *
FROM dim_customer_sk
