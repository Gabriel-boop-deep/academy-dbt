with
    source_address as (
        select *
        from {{ source('sap_adw', 'address') }}
    )

    , formatted_address as (
        select
            addressid as address_id
            , stateprovinceid as state_province_id
            , addressline1 as address_line
            , city as city_address
        from source_address
    )

select *
from formatted_address
