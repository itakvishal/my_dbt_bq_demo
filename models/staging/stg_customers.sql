{{ config(
    materialized='view'
) }}

SELECT
  id,
  first_name,
  last_name,
  LOWER(email) AS email_clean
FROM {{ ref('customers') }}
