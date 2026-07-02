--JOIN'ы - дубли
--задача 1
-- мин строк = 0, макс сторк = 12
/* задача 2
мин строк = 5, макс строк = 50
задача 3
мин строк = 9, макс строк = 14
задача 4
мин строк = макс строк = 48
задача 5 
мин строк = 0, макс строк = 24
задача 6
t1.id|t2.id|t1.a
  1  | 10  | A
  1  | 12  | A
  2  | 10  | A
  2  | 12  | A
  задача 7
t1.id|t2.id|t1.a
  1  |     | A
  2  | 10  | B
  2  | 12  | B
  3  | 10  | B
  3  | 12  | B
задача 8
t1.id|t2.id|t1.a|t2.a
  1  |     | A  |
  2  | 10  | B  |  B
  2  | 12  | B  |  B
  3  | 10  | B  |  B
  3  | 12  | B  |  B
     | 11  |    |  C
Задача 9
t1.id|t2.id|t1.a
  2  | 11  | A
  3  | 11  | A
Задача 10
t1.id|t2.id|t1.a|t1.b
  1  |  10 | A  | 1
  1  |  11 | A  | 1
  3  |  10 | A  | 1
  3  |  11 | A  | 1
*/
--UNION 
--Задача 1
SELECT client_id
FROM web_clients
UNION
SELECT client_id
FROM app_clients
-- задача 2
SELECT client_id, event_name
FROM web_clients
UNION
SELECT client_id, event_name
FROM mobile_events
--Задача 3
SELECT client_id, city
FROM crm_clients
UNION
SELECT client_id, city
FROM billing_clients
--Задача 4
SELECT user_id
FROM old_users
UNION
SELECT user_id
FROM new_users
-- Задача 5
SELECT user_id
FROM payments
WHERE DATE_PART('month', payment_dt) = 1
UNION
SELECT user_id
FROM refunds
WHERE DATE_PART('month', refund_dt) = 2
-- Задача 6
WITH all AS (
    SELECT num
    FROM a
    UNION
    SELECT num
    FROM b
)
SELECT *
FROM all
ORDER BY num
-- Задача 7
ALTER TABLE online_sales 
ADD COLUMN source VARCHAR(255) DEFAULT online_sales;
ALTER TABLE offline_sales 
ADD COLUMN source VARCHAR(255) DEFAULT offline_sales;
WITH all AS (
    SELECT sale_id, amount, source
    FROM online_sales
    UNION
    SELECT sale_id, amount, source
    FROM offline_sales
)
SELECT *
FROM all
-- Задача 8
SELECT e.client_id
FROM email_clients e
JOIN push_clients p
ON e.client_id = p.client_id
-- Задача 9
SELECT a.client_id
FROM all_clients a
JOIN blocked_clients b
ON a.client_id != b.client_id
-- Задача 10
WITH all AS(
    SELECT *
    FROM sales_2025
    UNION
    SELECT *
    FROM sales_2026
)
SELECT sale_dt, SUM(amount)
FROM all
GROUP BY 
--LAG / LEAD
-- Задача 1
SELECT 
    month_dt,
    revenue,
    revenue - LAG(revenue) OVER(ORDER BY month_dt)
FROM monthly_revenue
-- Задача 2
SELECT
    LEAD(order_dt) OVER(PARTITION BY client_id, ORDER BY order_id)
FROM orders
-- Задача 3
SELECT
    price - LAG(price) OVER(PARTITION BY product_id, ORDER BY changed_at)
FROM price_history
-- Задача 4
SELECT 
    (metric - LAG(metric) OVER(ORDER BY dt))/metric * 100
FROM daily_metrics
-- Задача 5
WITH events_with_lag AS (
    SELECT 
        event_dt,
        LAG(event_dt) OVER (ORDER BY event_dt) AS prev_event_dt
    FROM events
)
SELECT event_dt
FROM events_with_lag
WHERE event_dt - prev_event_dt >= 7
-- Задача 6
WITH all AS (
    SELECT
        ticket_id,
        changed_at,
        status,
        LAG(status) OVER (PARTITION BY ticket_id ORDER BY changed_at) AS prev_status
    FROM ticket_status
)
SELECT
    ticket_id,
    changed_at,
    status
FROM all
WHERE status != prev_status
-- Задача 7
SELECT
    LEAD(visit_id) OVER (PARTITION BY client_id) - visit_id
FROM visits
-- Задача 8
SELECT
    stock_cnt - LAG(stock_cnt) OVER(PARTITION BY sku_id ORDER BY stock_dt)
FROM stock
-- Задача 9
WITH all AS (
    SELECT
        dt,
        amount,
        LAG(amount) OVER(ORDER BY dt) AS lag_amount
    FROM revenue
)
SELECT
    dt
FROM all
WHERE lag_amount < amount
-- Задача 10
WITH all AS (
    SELECT
        event_dt,
        LEAD(event_dt) OVER(PARTITION BY event_dt ORDER BY event_dt) AS lead_event_dt
)
SELECT event_dt
WHERE lead_event_dt - event_dt > 1
--NULL'ы
-- Задача 1
SELECT
    account_id
FROM accounts
WHERE close_dt is NULL
-- Задача 2
SELECT
    COALESCE(balance, 0) AS balance
FROM accounts
-- Задача 3
SELECT
    COUNT(*) AS all_count
    COUNT(phone) AS phone_count
FROM clients
-- Задача 4
SELECT 
    c.client_id
FROM clients c
LEFT JOIN orders o
ON c.client_id = o.client_id
WHERE o.order_id is NULL
-- Задача 5
WITH blacklist_not_null AS (
    SELECT client_id
    FROM blacklist
    WHERE client_id IS NOT NULL
)
SELECT c.client_id
FROM clients c
LEFT JOIN blacklist_not_null b
ON c.client_id = b.client_id
WHERE b.client_id IS NULL
-- Задача 6



























