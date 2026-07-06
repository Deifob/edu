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
WITH all AS (
    SELECT 
        COALESCE(city, 'unknown') AS city,
        client_id
    FROM clients 
)
SELECT COUNT(city)
FROM all
GROUP BY city
-- Задача 7
SELECT
    price * qty - COALESCE(discount, 0) AS total_amount
FROM sales
-- Задача 8
SELECT
    ticket_id,
    status
FROM tickets
WHERE status is NULL OR status = 'error'
-- Задача 9
SELECT * 
FROM changes
WHERE old_value IS NOT new_value
-- Задача 10
SELECT 
    email,
    CASE 
        WHEN email IS NULL THEN 'Не заполнен'
        ELSE 'Заполнен'
    END AS status
FROM clients
--JOIN'ы - условия в ON 
-- Задача 1
SELECT *
FROM sales s
JOIN prices p
ON s.product_id = p.product_id
WHERE s.sale_dt <= p.valid_to AND s.sale_dt > p.valid_from
-- Задача 2
SELECT *
FROM payments p
JOIN commission_rules c
ON p.amount >= c.amount_from AND p.amount < c.amount_to
-- Задача 3
SELECT *, o.amount * r.rate
FROM operations o
JOIN rates r
ON o.operation_dt = r.rate_dt AND o.currency = r.currency
-- Задача 4
SELECT *
FROM orders o
JOIN client_segments c
ON o.client_id = c.client_id
WHERE o.sale_dt <= c.valid_to AND o.sale_dt > c.valid_from
-- Задача 5
SELECT *
FROM orders o
JOIN promos p
ON o.client_id = p.client_id
WHERE o.order_dt <= p.date_to AND o.order_dt > p.date_from
-- Задача 6
SELECT *
FROM bookings b
JOIN repairs r
ON b.room_id = r.room_id
WHERE (b.start_ts <= r.end_ts AND b.start_ts >= r.start_ts) OR (b.end_ts <= r.end_ts AND b.end_ts >= r.start_ts)
-- Задача 7
SELECT *
FROM site_users s
JOIN crm_users c
ON LOWER(s.email) = LOWER(c.email)
-- Задача 8
SELECT *
FROM orders o
JOIN discounts d
ON o.amount <= d.max_amount AND o.amount > min_amount
-- Задача 9
SELECT *
FROM operations o
JOIN employee_dept e
ON o.employee_id = e.employee_id
WHERE o.operation_dt <= e.valid_to AND o.operation_dt > e.valid_to
-- Задача 10
SELECT *
FROM clients c
LEFT JOIN orders o
ON date_part('month', o.order_dt) = 5
-- GROUP BY
-- Задача 1
SELECT 
    category,
    COUNT(category) AS count,
    SUM(amount) AS sum
FROM orders
GROUP BY category
-- Задача 2
SELECT user_id
FROM orders
WHERE order_dt >= DATE '2026-01-01' AND order_dt < DATE '2026-04-01'
GROUP BY user_id
HAVING COUNT(DISTINCT DATE_TRUNC('month', order_dt)) = 3
-- Задача 3
SELECT AVG(amount)
FROM payments
GROUP BY tariff
HAVING COUNT(payment_id) > 1
-- Задача 4
SELECT COUNT(DISTINCT sku_id)
FROM order_items
GROUP BY order_id
-- Задача 5
SELECT 
    client_id,
    COUNT(*) FILTER (WHERE status = 'success') AS success_cnt,
    COUNT(*) FILTER (WHERE status <> 'success') AS fail_cnt
FROM payments
GROUP BY client_id
-- Задача 6
SELECT
    client_id,
    MIN(order_dt),
    MAX(order_dt)
FROM orders
GROUP BY client_id
-- Задача 7
SELECT SUM(amount)
FROM orders
GROUP BY DATE_TRUNC('month', order_dt)
-- Задача 8
SELECT 
    client_id,
    SUM(amount)
FROM orders
GROUP BY client_id
HAVING SUM(amount) > 1000
-- Задача 9
WITH all_sum AS (
    SELECT
        SUM(amount) AS total_sum
    FROM orders
)
SELECT 
    category,
    SUM(amount),
    SUM(amount) / total_sum
FROM orders
GROUP BY category
-- Задача 10
WITH all AS(
    SELECT 
        client_id,
        CASE
            WHEN amount < 1000 THEN 'low'
            ELSE 'high'
        END AS level
    FROM orders
)
SELECT 
    COUNT(*) FILTER (WHERE level = 'low'),
    COUNT(*) FILTER (WHERE level = 'high')
FROM all
--ROW_NUMBER 
-- Задача 1
WITH all AS (
    SELECT 
        entity_id,
        ROW_NUMBER() OVER(PARTITION BY entity_id ORDER BY event_dt DESC) AS rank
    FROM history
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 2
WITH all AS (
    SELECT 
        client_id,
        ROW_NUMBER() OVER(PARTITION BY client_id ORDER BY order_dt) AS rank
    FROM orders
)
SELECT *
FROM all
WHERE rank < 4
-- Задача 3
WITH all AS (
    SELECT 
        event_id,
        ROW_NUMBER() OVER(PARTITION BY user_id, event_id ORDER BY loaded_at DESC) AS rank
    FROM events
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 4
WITH all AS (
    SELECT 
        payment_id,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY amount DESC) AS rank
    FROM payments
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 5
WITH all AS (
    SELECT
        order_id,
        ROW_NUMBER() OVER(PARTITION BY client_id ORDER BY order_dt ) AS rank
    FROM orders
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 6
WITH all AS (
    SELECT
        status,
        ticket_id,
        ROW_NUMBER() OVER (PARTITION BY ticket_id ORDER BY changed_at DESC) AS rank
    FROM ticket_status
)
SELECT 
    status,
    ticket_id
FROM all
WHERE rank = 1
-- Задача 7
WITH all AS (
    SELECT 
        user_id,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY created_at DESC) AS rank
    FROM users
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 8
WITH all AS (
    SELECT
        order_id,
        client_id,
        ROW_NUMBER() OVER (PARTITION BY client_id OVER BY order_dt) AS rank
    FROM orders
)
SELECT *
FROM all
WHERE rank = 2
-- Задача 9
WITH all AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY client_id ORDER BY valid_from DESC) AS rank
    FROM address_history
    WHERE valid_from < '2026-04-30'
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 10
WITH all AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY client_id ORDER BY amount DESC, transaction_id) AS rank
    FROM transactions
)
SELECT *
FROM all
WHERE rank = 1
--RANK / DENSE_RANK 10 задач
-- Задача 1
WITH all AS (
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY dep_id ORDER BY salary DESC) AS rank
    FROM employees
)
SELECT *
FROM all
WHERE rank = 2
-- Задача 2
SELECT 
    *,
    RANK() OVER(ORDER BY score) AS rank,
    DENSE_RANK() OVER(ORDER BY score DESC) AS dense_rank
FROM scores
-- Задача 3
WITH all AS (
    SELECT
        *,
        RANK() OVER(ORDER BY revenue DESC) AS rank
    FROM products
)
SELECT *
FROM all
WHERE rank < 4
-- Задача 4
WITH all AS (
    SELECT
        *,
        DENSE_RANK() OVER(ORDER BY points DESC) AS rank
    FROM teams
)
SELECT *
FROM all
-- Задача 5
WITH all AS (
    SELECT
        *,
        DENSE_RANK() OVER(ORDER BY total_amount) AS rank
    FROM client_totals
)
SELECT *
FROM all
WHERE rank = 3
-- Задача 6
SELECT 
    *,
    RANK() OVER(PARTITION BY DATE_TRUNC('month', month_dt), ORDER BY revenue DESC) AS rank
FROM sales
-- Задача 7
WITH all AS (
    SELECT 
        name,
        RANK() OVER(ORDER BY score) AS rank
    FROM results
)
SELECT *
FROM all
WHERE rank < 3
-- Задача 8
WITH group AS (
    SELECT 
        category,
        SUM(amount) AS summ
    FROM orders
    GROUP BY category
)
SELECT
    category,
    summ,
    RANK() OVER(ORDER BY summ DESC)
FROM group
-- Задача 9
WITH all AS (
    SELECT 
        name,
        score,
        RANK() OVER(ORDER BY score DESC) AS rank
    FROM scores
)
SELECT *
FROM all
WHERE rank = 1
-- Задача 10
WITH all AS (
    SELECT
        value,
        DENSE_RANK() OVER (ORDER BY value DESC) AS rank
    FROM numbers
)
SELECT *
FROM all
WHERE rank = 2
--SUM + OVER
-- Задача 1
SELECT 
    client_id,
    operation_dt,
    SUM(amount) OVER(PARTITION BY client_id ORDER BY operation_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM transactions
-- Задача 2
SELECT 
    category, 
    revenue,
    revenue * 1.0 / SUM(revenue) OVER () AS revenue_share
FROM category_sales
-- Задача 3
SELECT 
    category, 
    product_id,
    revenue * 1.0 / SUM(revenue) OVER (PARTITION BY category) AS revenue_share
FROM product_sales
-- Задача 4
SELECT 
    dt,
    SUM(revenue) OVER(ORDER BY dt ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM daily_sales
-- Задача 5
SELECT 
    account_id,
    operation_dt,
    SUM(amount) OVER(PARTITION BY account_id ORDER BY operation_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM operations
-- Задача 6
SELECT 
    client_id, 
    order_id,
    amount,
    SUM(amount) OVER ()
FROM orders
-- Задача 7
SELECT
    order_dt,
    amount,
    SUM(amount) OVER(PARTITION BY DATE_TRUNC('mounth', order_dt))
FROM orders
-- Задача 8
SELECT
    user_id,
    earned_at,
    points,
    SUM(points) OVER(PARTITION BY user_id ORDER BY earned_at) AS summ
FROM points
-- Задача 9
SELECT 
    sku_id, 
    movement_dt, 
    qty_delta,
    SUM(qty_delta) OVER (PARTITION BY sku_id ORDER BY movement_dt) AS summ
FROM stock_movements
-- Задача 10
WITH group AS (
    SELECT 
        order_dt,
        SUM(amount) AS summ
    FROM orders
    GROUP BY order_dt
)
SELECT
    order_dt,
    summ,
    SUM(summ) OVER(ORDER BY order_dt) AS c_summ
FROM group
--SELF JOIN
-- Задача 1
SELECT
    t1.employee_id
FROM employees t1
JOIN employees t2
ON t1.department_id = t2.department_id
    AND t1.birth_dt < t2.birth_dt
WHERE t2.is_manager = TRUE
-- Задача 2
SELECT
    t1.client_id,
    t2.client_id
FROM clients t1
JOIN clients t2
ON t1.city = t2.city
    AND t1.client_id > t2.client_id
-- Задача 3
SELECT
    t1.client_id,
    t2.client_id
FROM clients t1
JOIN clients t2
ON t1.phone = t2.phone
    AND t1.client_id > t2.client_id
-- Задача 4
SELECT 
    t1.team, 
    COUNT(DISTINCT t2.points) + 1 AS place
FROM teams t1
LEFT JOIN teams t2 
ON t2.points > t1.points
GROUP BY t1.team
-- Задача 5
SELECT 
    t1.product_id,
    t1.price
FROM products t1
JOIN products t2
ON t2.product_id = 1
    AND t1.price > t2.price
-- Задача 6
SELECT
    t1.session_id,
    t2.session_id
FROM sessions t1
JOIN sessions t2
ON t1.user_id = t2.user_id
    AND ((t1.end_ts < t2.end_ts AND t1.end_ts > t2.start_ts)
    OR (t1.start_ts < t2.end_ts AND t1.start_ts > t2.start_ts))
    AND t1.session_id < t2.session_id
-- Задача 7
SELECT
    t1.name,
    t2.name
FROM employees t1
JOIN employees t2
ON t1.manager_id = t2.employee_id



