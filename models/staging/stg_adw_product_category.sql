with
    source_product_category as (
        select *
        from {{ source('sap_adw', 'productcategory') }}
    )

    , formatted_product_category as (
        select
            productcategoryid as product_category_id
            , name as product_category_name
        from source_product_category
    )

select *
from formatted_product_category
