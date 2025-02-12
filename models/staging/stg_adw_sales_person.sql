WITH 
    source_sales_person AS (
        SELECT *
        FROM {{ source('sap_adw', 'salesperson') }}
    )

    , formatted_sales_person AS (
        SELECT 
            businessentityid AS sales_person_id
            , territoryid AS territory_id
            , salesquota AS sales_quota
            , commissionpct AS commission_pct
            , salesytd AS sales_ytd
            , saleslastyear AS sales_last_year
            , bonus
        FROM source_sales_person
    )
    
SELECT *
FROM formatted_sales_person
ORDER BY territory_id
