--FOCUS GROUP

--En yüksek fiyatlý bisitletin markasý nedir?

WITH T1 AS (
SELECT TOP 1 *

)
SELECT * 
FROM T1 A, [production].[brands] B
WHERE A.brand_id = B.brand_id

-- En pahalý bisitletten satýn alan müþterileri bulunuz.

WITH T1 AS (
SELECT TOP 1 *
FROM [production].[products]
ORDER BY list_price DESC
), T2 AS (
SELECT B.order_id
FROM T1 A, [sales].[order_items] B
WHERE A.product_id = B.product_id
), T3 AS (
SELECT B.customer_id
FROM T2 A, sales.orders B
WHERE A.order_id = B.order_id
)
SELECT B.first_name, B.last_name
FROM T3 A, [sales].[customers] B
WHERE A.customer_id = B.customer_id

--


