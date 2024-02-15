WITH 
    source_person AS (
        SELECT *
        FROM {{ source('sap_adw', 'person') }}
    )

    , formatted_person AS (
        SELECT
            businessentityid AS person_id
            , persontype AS person_type
            , firstname || ' ' || COALESCE(middlename || ' ', '') || lastname AS person_name
            ,  CASE persontype
                WHEN 'SC' THEN 'Store Contact'
                WHEN 'VC' THEN 'Vendor Contact'
                WHEN 'SP' THEN 'Sales Person'
                WHEN 'EM' THEN 'Employee'
                WHEN 'GC' THEN 'General Contact'
                WHEN 'IN' THEN 'Individual Customer'
                ELSE 'unknown'
            END AS person_type_description
        FROM source_person
    )

SELECT *
FROM formatted_person
