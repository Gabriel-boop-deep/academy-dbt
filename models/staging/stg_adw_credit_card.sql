with
    source_credit_card as (
        select *
        from {{ source('sap_adw', 'creditcard') }}
    )

    , formatted_credit_card as (
        select
            creditcardid as credit_card_id
            , cardtype as card_type
            , cardnumber as card_number
            , expmonth as expiration_month
            , expyear as expiration_year
        from source_credit_card
    )

select *
from formatted_credit_card
