with
    source_customer as (
        select *
        from {{source('sap_adw', 'customer')}}
    )

    , formatted_customer as (
        select
            customerid as customer_id
            , territoryid as territory_id
            , personid as person_id
            , storeid as store_id
            , modifieddate as modified_date
        from source_customer
    )

select *
from formatted_customer
