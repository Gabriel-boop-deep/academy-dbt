with
    source_product as (
        select *
        from {{ source('sap_adw', 'product') }}
    )

    , formatted_product as (
        select
            productid as product_id
            , name as product_name
            , productsubcategoryid as product_subcategory_id
            , safetystocklevel as safety_stock_level
            , color as color_source_product
        from source_product
    )

select *
from formatted_product
