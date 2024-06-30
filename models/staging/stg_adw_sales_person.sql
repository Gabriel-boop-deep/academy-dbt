with
    source_sales_person as (
        select *
        from {{ source('sap_adw', 'salesperson') }}
    )

    , formatted_sales_person as (
        select
            businessentityid as sales_person_id
            , territoryid as territory_id
            , salesquota as sales_quota
            , commissionpct as commission_pct
            , salesytd as sales_ytd
            , saleslastyear as sales_last_year
            , bonus
        from source_sales_person
    )

select *
from formatted_sales_person
order by territory_id
