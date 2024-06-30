with
    source_store as (
        select *
        from {{ source('sap_adw', 'store') }}
    )

    , formatted_store as (
        select
            businessentityid as store_id
            , salespersonid as sales_person_id
            , name as store_name
        from source_store
    )

select *
from formatted_store
