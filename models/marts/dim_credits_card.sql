with
    dim_credit_card as (
        select *
        from {{ ref('stg_adw_credit_card') }}
    )
    
    , dim_credit_card_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} as credit_card_sk
            , *
        from dim_credit_card
    )

select *
from dim_credit_card_sk