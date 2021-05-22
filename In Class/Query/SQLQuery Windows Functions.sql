-- Window Functions (WF) vs. GROUP BY
-- Window functions ile Group By aras�ndaki fark� g�rmek i�in a�a��daki iki sorguyu inceleyiniz.

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

-- Markalara g�re ortalama bisiklet fiyatlar�n� hem Group By hem de Window Functions ile hesaplay�n�z.

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
Products tablosunda herbir �r�n�n yan�na s�ras�yla �u de�erleri yazd�r�n�z:
1. T�m bisikletler aras�nda en ucuz bisikletin fiyat�
2. Herbir kategorideki en ucuz bisikletin fiyat�
3. Toplam ka� fakl� bisikletin bulundu�u
4. Herbir kategoride toplam ka� farkl� bisikletin bulundu�u
	Soru: WF ile bu sorgu i�inde herbir kategoride ka� farkl� marka oldu�unu hesaplayabilir miyiz?
5. Herbir kategorideki herbir markada ka� farkl� bisikletin bulundu�u
	*/

SELECT *,
		MIN(list_price) OVER() less_price_bike
FROM [production].[products]
ORDER BY category_id