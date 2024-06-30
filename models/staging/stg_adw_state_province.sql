with
    source_state_province as (
        select *
        from {{ source('sap_adw', 'stateprovince') }}
    )

    , formatted_state_province as (
        select
            stateprovinceid as state_province_id
            , territoryid as territory_id
            , name as province_name
            , stateprovincecode as state_province_code
            , countryregioncode as country_region_code
        from source_state_province
    )

select *
from formatted_state_province
