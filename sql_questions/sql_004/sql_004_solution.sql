/*
### ❓ Question 04: Customer Purchase Gaps

**Context:**

The company wants to better understand the repurchase behavior of its customers over time. The goal is to calculate the number of days between each purchase and the previous one per customer, and then classify the repurchase pattern as follows:

* **Frequent Buyer**: If the average gap between purchases is ≤ 30 days
* **Occasional Buyer**: If the average gap is between 31 and 90 days
* **Rare Buyer**: If the average gap is > 90 days

**Your Task:**

Write a query that returns, for each `customer_id`, the total number of orders, the average gap in days between purchases (`average_gap_days`), and the buyer type classification according to the criteria above.

**Rules:**

* Use only the tables available in the `sql_study` schema.
* Assume the `orders` table contains the following columns: `order_id`, `customer_id`, `order_date`.
* You can use any technique (e.g., window functions, subqueries, etc.).
* The final output must include: `customer_id`, `total_orders`, `average_gap_days`, `buyer_type`.

*/



-- my answer
WITH _NEXT_ORDER AS(
    SELECT [order_id]
        ,[customer_id]
        ,[order_date]
        ,LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_date
        ,[total_amount]
    FROM [sql_study].[orders]
), _INTERVAL_DAYS AS (
    SELECT
        ORDER_ID, CUSTOMER_ID, ORDER_DATE, NEXT_ORDER_DATE
        ,CASE
            WHEN DATEDIFF(DAY, ORDER_DATE, NEXT_ORDER_DATE) IS NULL THEN 0 
            ELSE DATEDIFF(DAY, ORDER_DATE, NEXT_ORDER_DATE)
            END AS INTERVAL_DAYS
        ,TOTAL_AMOUNT
    FROM _NEXT_ORDER
)
SELECT
    CUSTOMER_ID
    , COUNT( DISTINCT order_id ) AS TOTAL_ORDERS
    , AVG( INTERVAL_DAYS ) AS AVG_GAP_DAYS
    , SUM( total_amount ) AS TOTAL_AMOUNT        
    , CASE
        WHEN AVG( INTERVAL_DAYS ) <= 30 THEN 'Frequent Buyer'
        WHEN AVG( INTERVAL_DAYS ) >= 31 AND AVG( INTERVAL_DAYS ) <= 90 THEN 'Occasional Buyer'
        WHEN AVG( INTERVAL_DAYS ) > 90 THEN 'Rare Buyer'
        ELSE 'Single Order'
    END AS BUYER_TYPE
FROM _INTERVAL_DAYS
GROUP BY CUSTOMER_ID
;








-- chat gpt answer

-- Classify customers based on average days between orders
WITH next_order_dates AS (
    SELECT 
        order_id,
        customer_id,
        order_date,
        LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_date,
        total_amount
    FROM sql_study.orders
),
intervals AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        next_order_date,
        DATEDIFF(DAY, order_date, next_order_date) AS interval_days,
        total_amount
    FROM next_order_dates
)
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    AVG(interval_days) AS avg_gap_days,
    SUM(total_amount) AS total_amount,
    CASE 
        WHEN COUNT(order_id) = 1 THEN 'Single Order'
        WHEN AVG(interval_days) <= 30 THEN 'Frequent Buyer'
        WHEN AVG(interval_days) BETWEEN 31 AND 90 THEN 'Occasional Buyer'
        WHEN AVG(interval_days) > 90 THEN 'Rare Buyer'
    END AS buyer_type
FROM intervals
GROUP BY customer_id;
