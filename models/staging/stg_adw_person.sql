with
    source_person as (
        select *
        from {{ source('sap_adw', 'person') }}
    )

    , formatted_person as (
        select
            businessentityid as person_id
            , persontype as person_type
            , firstname || ' ' || coalesce(middlename || ' ', '') || lastname as person_name
            , case persontype
                when 'SC' then 'Store Contact'
                when 'VC' then 'Vendor Contact'
                when 'SP' then 'Sales Person'
                when 'EM' then 'Employee'
                when 'GC' then 'General Contact'
                when 'IN' then 'Individual Customer'
                else 'unknown'
            end as person_type_description
        from source_person
    )

select *
from formatted_person
