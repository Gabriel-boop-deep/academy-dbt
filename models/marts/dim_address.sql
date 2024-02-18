WITH 
    address AS (
        SELECT *
        FROM {{ ref('stg_adw_address') }}
    )

    , country_region AS (
        SELECT *
        FROM {{ ref('stg_adw_country_region') }}  
    )

    , state_province AS (
        SELECT *
        FROM {{ ref('stg_adw_state_province') }}
    )

    , dim_address AS (
        SELECT
            address.address_id,
            state_province.territory_id,
            address.address_line,
            address.city_address,
            state_province.province_name,
            country_region.country_name
        FROM address
        
        LEFT JOIN state_province 
            ON address.state_province_id = state_province.state_province_id
        LEFT JOIN country_region 
            ON state_province.country_region_code = country_region.country_region_code
    ),

    dim_address_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_sk
            , *
        from dim_address
    )  

SELECT *
FROM dim_address_sk
