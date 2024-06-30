with
    source_sales_order_detail as (
        select *
        from {{ source('sap_adw', 'salesorderdetail') }}
    )

    , formatted_sales_order_detail as (
        select
            salesorderdetailid as sales_order_detail_id
            , salesorderid as sales_order_id
            , productid as product_id
            , specialofferid as special_offer_id
            , orderqty as order_qty
            , unitpricediscount as unit_price_discount
            , unitprice as unit_price
        from source_sales_order_detail
    )

select *
from formatted_sales_order_detail
