WITH dim_credit_card AS (
    SELECT *
    FROM {{ ref('stg_adw_credit_card') }}
)
, dim_credit_card_sk AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} AS credit_card_sk,
        c.* 
    FROM dim_credit_card c
)

SELECT *
FROM dim_credit_card_sk
