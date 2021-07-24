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
Orders tablosunda herbir sipari�in yan�na s�ras�yla �u de�erleri yazd�r�n�z:
1. Herbir personelin bir �nceki sat���n�n sipari� tarihini yazd�r�n�z (LAG fonksiyonunu kullan�n�z)
2. Herbir personelin bir sonraki sat���n�n sipari� tarihini yazd�r�n�z (LEAD fonksiyonunu kullan�n�z)
Not: OVER blo�u i�inde sat�rlar aras�ndaki s�ralamay� iyi belirtmek laz�m.
	E�er order_date e g�re s�ralama yap�lm�� olsayd� ayn� g�ne ait sipari�ler aras�ndaki s�ralama kontrol�m�zde olmayacakt�.
	Bundan dolay� order_id ye g�re s�ralama yap�lm��t�r.
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
Products tablosunda herbir �r�n�n yan�na s�ras�yla �u de�erleri yazd�r�n�z:
1. T�m bisikletler aras�nda en ucuz bisikletin ad� (FIRST_VALUE fonksiyonunu kullan�n�z)
2. Herbir kategorideki en ucuz bisikletin ad� (FIRST_VALUE fonksiyonunu kullan�n�z)
3. 1. maddeyi LAST_VALUE fonksiyonu kullanarak yap�n�z
4. 2. maddeyi LAST_VALUE fonksiyonu kullanarak yap�n�z
	Not: 2. ve 4. maddenin sonu�lar�n� kar��la�t�r�n�z. Farkl�l�k varsa nedenini bulmaya �al���n�z?
	�stedi�iniz sat�r berlirledi�iniz kurala g�re FIRST_VALUE da ilk s�rada, LAST_VALUE da sonra s�rada gelmelidir.
	E�er veri i�inde ayn� fiyatl� bisikletler varsa ORDER BY s�ralamas�na ekstra dikkat etmek laz�m.
	OVER blo�unda belirledi�iniz ORDER BY kural�na g�re tabloyu ba�ka bir sorguda sorgulay�p istedi�iniz sat�r istedi�iniz yerder (FIRST veya LAST) gelmi� mi diye kontrol edebilirsiniz.
Not: OVER blo�u i�inde ORDER BY dan sonra Window Frame tan�mlarken ROWS ya da RANGE kullan�labilir.
	ROWS BETWEEN ile RANGE BETWEEN aras�nda �ok fark yok.
	RANGE ile sadece UNBOUNDEN PRECEDING, CURRENT ROW veya UNBOUNDED FOLLOWING de�erlerini kullanabiliyorsunuz.
	ROWS ile ek olarak n PRECEDING ya da m FOLLOWING de�erlerini de kullanabiliyoruz.
	Dolay�s�yla RANGE i bilin fakat ROWS kullanmaya al��man�z� tavsiye ederim.
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

-- 3. ANALYTIC NUMBERING FUNCTIONS --
	/*
ROW_NUMBER() - RANK() - DENSE_RANK() - CUME_DIST() - PERCENT_RANK() - NTILE()
Products tablosunda herbir �r�n�n yan�na s�ras�yla �u de�erleri yazd�r�n�z:
1. Herbir kategori i�inde bisikletlerin fiyat s�ralamas�n� yap�n�z (artan fiyata g�re 1'den ba�lay�p birer birer artacak)
2. Ayn� soruyu ayn� fiyatl� bisikletler ayn� s�ra numaras�n� alacak �ekilde yap�n�z (RANK fonksiyonunu kullan�n�z)
Not: RANK fonksiyonunda ayn� fiyatl� �r�nlerin numaras� o �r�nlerin ROW_NUMBER lar�ndan en k����� oluyor.
	Ayn� fiyatl� �r�nlerde RANK fonksiyonu o �r�nlerin ROW_NUMBER de�erinin en b�y���n� d�nd�rm�yor diye biliyorum.
	Bu ihtiya� i�in a�a��da yer alan ikinci sorguyu inceleyebilirsiniz.
	Bu sorguda en sa�daki alan (R2 yani RANK2 diyebilirsiniz) bu ihtiyac� kar��lamaktad�r.
3. Ayn� soruyu ayn� fiyatl� bisikletler ayn� s�ra numaras�n� alacak �ekilde yap�n�z (DENSE_RANK fonksiyonunu kullan�n�z)
	Not: 2. ve 3. maddenin sonu�lar�n� kar��la�t�r�n�z. Farkl�l�k varsa nedenini anlamaya �al���n�z?
	Fark� daha iyi g�rebilmek i�in ayn� kategori i�inde s�ralamalar�n nas�l de�i�ti�ine dikkat ediniz.
4. Herbir kategori i�inde bisikletierin fiyatlar�na g�re bulunduklar� y�zdelik dilimleri yazd�r�n�z. (CUME_DIST fonksiyonunu kullan�n�z)
	Not: Hesaplanan de�eri virg�lden sonra 2 hane olacak �ekilde yazd�r�n�z ve bu de�eri yorumlay�n�z?
5. Bir bisiklet di�er bisikletlerin y�zde ka��ndan daha pahal�d�r? Bu y�zdeyi hesaplay�n�z. (PERCENT_RANK fonksiyonunu kullan�n�z)
	Not: Hesaplanan de�eri virg�lden sonra 2 hane olacak �ekilde yazd�r�n�z ve bu de�eri yorumlay�n�z?
	4. ve 5. maddelerde hesaplanan de�erleri kar��la�t�r�n�z. Form�llerine g�z at�n�z.
Not: CUME_DIST fonksiyonu bir �r�n�n belirledi�imiz s�raya y�zde ka�l�k dilimde oldu�unu g�sterir (S�navlardaki y�zdelik dilimler gibi)
	PERCENT_RANK fonksiyou ise bir �r�n�n belirtti�imiz partition i�indeki di�er �r�nlerin y�zde ka��ndan daha pahal�/ucuz oldu�unu ifade eder.
6. Herbir kategorideki bisikletleri artan fiyata g�re 4 gruba ay�r�n. M�mk�nse her grupta ayn� say�da bisiklet olacak. (NTILE fonksiyonunu kullan�n�z)
	Not: En d���k fiyatl� bisikletler 1. grupta, di�er bisikletler i�inde en d���k fiyatl� bisikletler 2. grupta ... olacak �ekilde.
Not: NTILE ile k�meler olu�turulurken ayn� fiyatl� �r�nler farkl� gruplara denk gelebilir.
	NTLIE bu durumu kontrol etmemektedir. Buna herhangi bir ��z�m bulamad�m. Bulursam payla��r�m.
	*/

--Q1

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN
FROM [production].[products]
ORDER BY category_id, list_price

--Q2

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) R -- list_price g�re numaraland�r�yor fakat ayn� de�erlerde aradaki say�lar� atl�yor.
FROM [production].[products]
ORDER BY category_id, list_price

--Q3

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) R,
		DENSE_RANK() OVER(PARTITION BY category_id ORDER BY list_price) DR -- list_price g�re numaraland�r�yor ve ayn� de�erlerde aradaki say�lar� atlam�yor.
FROM [production].[products]
ORDER BY category_id, list_price

--Q4

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) R,
		DENSE_RANK() OVER(PARTITION BY category_id ORDER BY list_price) DR,
		ROUND(CUME_DIST() OVER(PARTITION BY category_id ORDER BY list_price),2) CD -- Herbir kategori i�inde bisikletierin fiyatlar�na g�re bulunduklar� y�zdelik dilimleri yazd�r�yor.
FROM [production].[products]
ORDER BY category_id, list_price

--Q5

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) R,
		DENSE_RANK() OVER(PARTITION BY category_id ORDER BY list_price) DR,
		ROUND(CUME_DIST() OVER(PARTITION BY category_id ORDER BY list_price),2) CD,
		ROUND(PERCENT_RANK() OVER(PARTITION BY category_id ORDER BY list_price),2) PR -- Bir bisiklet di�er bisikletlerin y�zde ka��ndan daha pahal�d�r? Bu y�zdeyi hesapl�yor.
FROM [production].[products]
ORDER BY category_id, list_price

--Q6

SELECT *,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) R,
		DENSE_RANK() OVER(PARTITION BY category_id ORDER BY list_price) DR,
		ROUND(CUME_DIST() OVER(PARTITION BY category_id ORDER BY list_price),2) CD,
		ROUND(PERCENT_RANK() OVER(PARTITION BY category_id ORDER BY list_price),2) PR,
		NTILE(4) OVER(PARTITION BY category_id ORDER BY list_price) NT
FROM [production].[products]
ORDER BY category_id, list_price

--RANK2

SELECT	A.*,
		MAX(RN) OVER(PARTITION BY A.category_id, A.R) R2
FROM	(
		SELECT	*,
				ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) RN,
				RANK() OVER(PARTITION BY category_id ORDER BY list_price) R,
				DENSE_RANK() OVER(PARTITION BY category_id ORDER BY list_price) DR,
				ROUND(CUME_DIST() OVER(PARTITION BY category_id ORDER BY list_price), 02) CD,
				ROUND(PERCENT_RANK() OVER(PARTITION BY category_id ORDER BY list_price), 2) PR,
				NTILE(4) OVER(PARTITION BY category_id ORDER BY list_price) NT
		FROM	production.products
		) A
ORDER BY A.category_id, A.list_price
;








