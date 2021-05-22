-- Window Functions (WF) vs. GROUP BY
-- Window functions ile Group By arasýndaki farký görmek için aþaðýdaki iki sorguyu inceleyiniz.

SELECT	*
FROM	production.stocks
ORDER BY product_id


SELECT	product_id, sum(quantity) toplam
FROM	production.stocks
GROUP BY product_id
ORDER BY product_id
;

SELECT	*, SUM(quantity) OVER(PARTITION BY product_id) toplam
FROM	production.stocks
ORDER BY product_id

-- Markalara göre ortalama bisiklet fiyatlarýný hem Group By hem de Window Functions ile hesaplayýnýz.

SELECT	brand_id, avg(list_price) ort_fiyat
FROM	production.products
GROUP BY brand_id
ORDER BY brand_id
;

SELECT	*, avg(list_price) over(partition by brand_id) ort_fiyat
FROM	production.products
ORDER BY brand_id
;

-- 1. ANALYTIC AGGREGATE FUNCTIONS --
	/*
MIN() - MAX() - AVG() - SUM() - COUNT()
Products tablosunda herbir ürünün yanýna sýrasýyla þu deðerleri yazdýrýnýz:
1. Tüm bisikletler arasýnda en ucuz bisikletin fiyatý
2. Herbir kategorideki en ucuz bisikletin fiyatý
3. Toplam kaç faklý bisikletin bulunduðu
4. Herbir kategoride toplam kaç farklý bisikletin bulunduðu
	Soru: WF ile bu sorgu içinde herbir kategoride kaç farklý marka olduðunu hesaplayabilir miyiz?
5. Herbir kategorideki herbir markada kaç farklý bisikletin bulunduðu
	*/
--Q1

SELECT *,
		MIN(list_price) OVER() less_price_bike
FROM [production].[products]
ORDER BY category_id, brand_id, list_price

--Q2

SELECT *,
		MIN(list_price) OVER() less_price_bike,
		MIN(list_price) OVER(PARTITION BY category_id) less_price_ctgry
FROM [production].[products]
ORDER BY category_id, brand_id, list_price

--Q3

SELECT *,
		MIN(list_price) OVER() less_price_bike,
		MIN(list_price) OVER(PARTITION BY category_id) less_price_ctgry,
		COUNT(product_id) OVER() diff_type_product
FROM [production].[products]
ORDER BY category_id, brand_id, list_price

--Q4

SELECT *,
		MIN(list_price) OVER() less_price_bike,
		MIN(list_price) OVER(PARTITION BY category_id) less_price_ctgry,
		COUNT(product_id) OVER() diff_type_product,
		COUNT(product_id) OVER(PARTITION BY category_id) diff_type_ctgry
FROM [production].[products]
ORDER BY category_id, brand_id, list_price

--Q5

SELECT *,
		MIN(list_price) OVER() less_price_bike,
		MIN(list_price) OVER(PARTITION BY category_id) less_price_ctgry,
		COUNT(product_id) OVER() diff_type_product,
		COUNT(product_id) OVER(PARTITION BY category_id ) diff_type_ctgry,
		COUNT(product_id) OVER(PARTITION BY category_id, brand_id) cnt_type_ctgry
FROM [production].[products]
ORDER BY category_id, brand_id, list_price

-- 2. ANALYTIC NAVIGATION FUNCTIONS --
	/*
LAG() - LEAD()
Orders tablosunda herbir sipariþin yanýna sýrasýyla þu deðerleri yazdýrýnýz:
1. Herbir personelin bir önceki satýþýnýn sipariþ tarihini yazdýrýnýz (LAG fonksiyonunu kullanýnýz)
2. Herbir personelin bir sonraki satýþýnýn sipariþ tarihini yazdýrýnýz (LEAD fonksiyonunu kullanýnýz)
Not: OVER bloðu içinde satýrlar arasýndaki sýralamayý iyi belirtmek lazým.
	Eðer order_date e göre sýralama yapýlmýþ olsaydý ayný güne ait sipariþler arasýndaki sýralama kontrolümüzde olmayacaktý.
	Bundan dolayý order_id ye göre sýralama yapýlmýþtýr.
	*/

--Q1

SELECT * ,
		LAG(order_date, 1) OVER(PARTITION BY staff_id ORDER BY order_id) before_order_date
FROM [sales].[orders]
ORDER BY customer_id, order_id

--Q2

SELECT * ,
		LAG(order_date, 1) OVER(PARTITION BY staff_id ORDER BY order_id) before_order_date,
		LEAD(order_date, 1) OVER(PARTITION BY staff_id ORDER BY order_id) after_order_date
FROM [sales].[orders]
ORDER BY customer_id, order_id







