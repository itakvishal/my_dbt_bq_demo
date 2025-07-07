{{ config(materialized='table') }}

WITH base AS (
  SELECT
    customer_id,
    COUNT(*)        AS order_count,
    SUM(amount_usd) AS total_spent
  FROM `dbt_to_bq.orders`  -- change to your raw table
  GROUP BY customer_id
)

SELECT
  c.id,
  c.first_name,
  c.last_name,
  b.order_count,
  b.total_spent
FROM base AS b
JOIN {{ ref('stg_customers') }} AS c
  ON b.customer_id = c.id
