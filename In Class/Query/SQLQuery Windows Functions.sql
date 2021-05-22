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

/*
FIRST_VALUE() - LAST_VALUE()
Products tablosunda herbir ürünün yanýna sýrasýyla þu deðerleri yazdýrýnýz:
1. Tüm bisikletler arasýnda en ucuz bisikletin adý (FIRST_VALUE fonksiyonunu kullanýnýz)
2. Herbir kategorideki en ucuz bisikletin adý (FIRST_VALUE fonksiyonunu kullanýnýz)
3. 1. maddeyi LAST_VALUE fonksiyonu kullanarak yapýnýz
4. 2. maddeyi LAST_VALUE fonksiyonu kullanarak yapýnýz
	Not: 2. ve 4. maddenin sonuçlarýný karþýlaþtýrýnýz. Farklýlýk varsa nedenini bulmaya çalýþýnýz?
	Ýstediðiniz satýr berlirlediðiniz kurala göre FIRST_VALUE da ilk sýrada, LAST_VALUE da sonra sýrada gelmelidir.
	Eðer veri içinde ayný fiyatlý bisikletler varsa ORDER BY sýralamasýna ekstra dikkat etmek lazým.
	OVER bloðunda belirlediðiniz ORDER BY kuralýna göre tabloyu baþka bir sorguda sorgulayýp istediðiniz satýr istediðiniz yerder (FIRST veya LAST) gelmiþ mi diye kontrol edebilirsiniz.
Not: OVER bloðu içinde ORDER BY dan sonra Window Frame tanýmlarken ROWS ya da RANGE kullanýlabilir.
	ROWS BETWEEN ile RANGE BETWEEN arasýnda çok fark yok.
	RANGE ile sadece UNBOUNDEN PRECEDING, CURRENT ROW veya UNBOUNDED FOLLOWING deðerlerini kullanabiliyorsunuz.
	ROWS ile ek olarak n PRECEDING ya da m FOLLOWING deðerlerini de kullanabiliyoruz.
	Dolayýsýyla RANGE i bilin fakat ROWS kullanmaya alýþmanýzý tavsiye ederim.
	*/
--Q1

SELECT *,
		FIRST_VALUE(product_name) OVER(ORDER BY list_price) less_price_bike
FROM [production].[products]
ORDER BY list_price

--Q2

SELECT *,
		FIRST_VALUE(product_name) OVER(ORDER BY list_price) less_price_bike,
		FIRST_VALUE(product_name) OVER(PARTITION BY category_id ORDER BY list_price) less_price_bike_ctgry
FROM [production].[products]
ORDER BY category_id, list_price

--Q3-Q4

SELECT	*,
		FIRST_VALUE(product_name) OVER(ORDER BY list_price) en_ucuz_bisiklet,
		FIRST_VALUE(product_name) OVER(PARTITION BY category_id ORDER BY list_price, product_id) en_ucuz_bisiklet_cat,
		LAST_VALUE(product_name) OVER(ORDER BY list_price DESC, product_id DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) en_ucuz_bisiklet2,
		LAST_VALUE(product_name) OVER(PARTITION BY category_id ORDER BY list_price DESC, product_id DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) en_ucuz_bisiklet_cat2
FROM	production.products
ORDER BY category_id, list_price







