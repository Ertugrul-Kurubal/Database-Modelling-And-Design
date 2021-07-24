
------ SINGLE ROW SUBQUERIES ------ 
--Bu durumda subquery bize sadece bir durum (row) de�eri 
--verir onun i�in bu durumlarda WHERE vb. k�yaslamalarda <,>,>=,<= gibi
--operat�rler kullan�l�r.

-- Kali	Vargas'�n �al��t��� ma�azadaki t�m personelleri listeleyin.

SELECT store_id FROM [sales].[staffs] 
WHERE first_name = 'Kali' AND last_name = 'Vargas'

SELECT * FROM sales.staffs
WHERE store_id = (SELECT store_id FROM [sales].[staffs] 
				 WHERE first_name = 'Kali' AND last_name = 'Vargas')
				 ;

-- Venita Daniel'�n y�neticisi oldu�u personelleri listeleyin.

SELECT * FROM [sales].[staffs]
WHERE manager_id = (SELECT manager_id FROM  [sales].[staffs] 
					WHERE first_name = 'Venita' AND last_name = 'Daniel')

-- 'Rowlett Bikes' isimli ma�azan�n bulundu�u �ehirdeki m��terileri listeleyin.

SELECT * FROM [sales].[stores] 

SELECT first_name, last_name FROM [sales].[customers]
WHERE city = (SELECT city FROM [sales].[stores] 
	 		  WHERE store_name = 'Rowlett Bikes');

-- 'Trek CrossRip+ - 2018' isimli bisikletten pahal� olan bisikletleri listeleyin.
-- Product id, product name, model_year, fiyat, marka ad� ve kategori ad� alanlar�na ihtiya� duyulmaktad�r.

SELECT * FROM [production].[products]
WHERE product_name = 'Trek CrossRip+ - 2018'

SELECT a.product_id, a.product_name, a.model_year,
	   b.brand_name, c.category_name
FROM [production].[products] a, [production].[brands] b, [production].[categories] c
WHERE a.list_price > (SELECT list_price FROM [production].[products]
                    WHERE product_name = 'Trek CrossRip+ - 2018')
					AND a.brand_id = b.brand_id AND
					a.category_id = c.category_id

SELECT * 
FROM production.products
WHERE brand_id = 9 AND (
						category_id = 6 OR 
						model_year = 2016
						);

-- Arla Ellis isimli m��teriden daha �nceki tarihlerde sipari� veren m��terileri listeleyin.
-- M��teri ad�, soyad� ve sipari� tarihi bilgilerini listeleyin.

SELECT a.first_name, a.last_name, b.order_date 
FROM [sales].[customers] a, [sales].[orders] b
WHERE  a.customer_id = b.customer_id AND 
		b.order_date < (SELECT b.order_date 
						FROM [sales].[customers] a,  [sales].[orders] b
						WHERE a.customer_id = b.customer_id AND 
						a.first_name = 'Arla' AND a.last_name = 'Ellis');
 
SELECT b.order_date FROM [sales].[customers] a,  [sales].[orders] b
WHERE a.customer_id = b.customer_id AND a.first_name = 'Arla' AND a.last_name = 'Ellis'

------ MULTIPLE ROW SUBQUERIES ------
--Bu durumda subquery bize sadece birden fazla durum (row) de�eri 
--verir onun i�in bu durumlarda WHERE vb. k�yaslamalarda IN,NOT IN,>ALL,<ALL,<ANY, ANY, ALL gibi
--operat�rler kullan�l�r.
-- Holbrook �ehrinde oturan m��terilerin sipari� tarihlerini listeleyin.

SELECT order_date
FROM [sales].[orders]
WHERE customer_id IN (SELECT customer_id FROM [sales].[customers]
					  WHERE city = 'Holbrook')

SELECT customer_id FROM [sales].[customers]
WHERE city = 'Holbrook'

-- Kasha Todd isimli m��terinin al��veri� yapt��� tarihte al��veri� yapan t�m m��terileri listeleyin.
-- M��teri ad�, soyad� ve sipari� tarihi bilgilerini listeleyin.

SELECT A.first_name, A.last_name, B.order_date
FROM sales.customers A, sales.orders B
WHERE A.customer_id = B.customer_id AND B.order_date IN
	(SELECT B.order_date
	FROM sales.customers A, sales.orders B
	WHERE A.first_name = 'Kasha' AND A.last_name = 'Todd' 
	AND A.customer_id = B.customer_id)

-- Cruisers Bicycles, Mountain Bikes veya Road Bikes haricindeki kategorilere ait �r�nleri listeleyin.
-- Sadece 2016 model y�l�na ait bisikletlerin ad� ve fiyat bilgilerini listeleyin.

SELECT * FROM [production].[products]
WHERE category_id IN (
					  SELECT category_id
					  FROM production.categories
					  WHERE category_name 
					  NOT IN ('Cruisers Bicycles', 'Mountain Bikes','Road Bikes'))
					  AND model_year = 2016;


SELECT a.product_name, a.list_price 
FROM [production].[products] a, [production].[categories] b
WHERE a.category_id = b.category_id 
AND a.model_year = 2016 
AND b.category_name 
NOT IN ('Cruisers Bicycles', 'Mountain Bikes','Road Bikes')

-- B�t�n elektrikli bisikletlerden pahal� olan bisikletleri listelyin.
-- �r�n ad�, model_y�l� ve fiyat bilgilerini y�ksek fiyattan d���k fiyata do�ru s�ralay�n�z.

SELECT product_name, model_year, list_price 
FROM [production].[products]
WHERE list_price > ALL (SELECT a.list_price
					FROM [production].[products] a, [production].[categories] b
					WHERE a.category_id = b.category_id AND
					b.category_name = 'Electric Bikes')
					ORDER BY list_price DESC;

--ALL b�t�n 'Electric Bikes' lerden daha pahal� olan bisikletler
				
SELECT a.list_price
FROM [production].[products] a, [production].[categories] b
WHERE a.category_id = b.category_id AND
b.category_name = 'Electric Bikes'

SELECT product_name, model_year, list_price 
FROM [production].[products]
WHERE list_price > (SELECT MAX(a.list_price)
					FROM [production].[products] a, [production].[categories] b
					WHERE a.category_id = b.category_id AND
					b.category_name = 'Electric Bikes')
					ORDER BY list_price DESC;

-- Herhangi bir elektrikli bisikletten pahal� olan bisikletleri listeleyin.
-- �r�n ad�, model_y�l� ve fiyat bilgilerini y�ksek fiyattan d���k fiyata do�ru s�ralay�n�z.

SELECT product_name, model_year, list_price 
FROM [production].[products]
WHERE list_price > ANY (SELECT a.list_price
					FROM [production].[products] a, [production].[categories] b
					WHERE a.category_id = b.category_id AND
					b.category_name = 'Electric Bikes')
					ORDER BY list_price DESC;

--ANY herhangi bir 'Electric Bikes' dan daha pahal� olan bisikletler

------ VIEWS ------
-- Sadece stokta bulunan �r�nleri g�steren bir view olu�turun ve birka� sorgu i�inde kullan�n.
-- �r�n ad�, markas�, kategorisi, model_y�l�, liste fiyat�

CREATE VIEW production.product_available AS
SELECT a.product_name, b.brand_name, c.category_name, a.model_year, a.list_price
FROM [production].[products] a, [production].[brands] b, [production].[categories] c
WHERE a.brand_id = b.brand_id AND a.category_id = c.category_id AND
	  a.product_id IN (SELECT product_id
                       FROM [production].[stocks]
					   WHERE quantity > 0
					   );

SELECT * FROM [production].[product_available]

SELECT * FROM [production].[product_available]
WHERE model_year = 2016

-- Sipari� detaylar� ile ilgili bir view olu�turun ve birka� sorgu i�inde kullan�n.
-- M��teri ad� soyad�, order_date, product_name, model_year, quantity, list_price, final_price (indirimli fiyat)

CREATE VIEW production_orders_details_2 AS
SELECT a.first_name, a.last_name, b.order_date, 
		c.product_name, c.model_year, d.quantity, d.list_price, d.
		list_price*(1-d.discount) final_price
		FROM [sales].[customers] a, [sales].[orders] b, [production].[products] c, [sales].[order_items] d
WHERE a.customer_id = b.customer_id AND b.order_id = d.order_id AND c.product_id = d.product_id
;

CREATE VIEW production.order_details AS
SELECT	A.first_name, A.last_name, B.order_date, D.product_name, D.model_year,
		C.quantity, C.list_price, C.list_price * (1 - C.discount) final_price
FROM	sales.customers A, sales.orders B, sales.order_items C, production.products D
WHERE	A.customer_id = B.customer_id AND
		B.order_id = C.order_id AND
		C.product_id = D.product_id
;

SELECT * 
FROM production.order_details
WHERE quantity = 2
;

------ WITH ------
-- VIEW konusunun ilk �rne�ini WITH clause ile olu�turup Strider markal� bisikletleri listeleyin.

------ VIEWS ------
-- Sadece stokta bulunan �r�nleri g�steren bir view olu�turun ve birka� sorgu i�inde kullan�n.
-- �r�n ad�, markas�, kategorisi, model_y�l�, liste fiyat�

WITH t1  AS 
		(
		SELECT	A.product_name, B.brand_name, C.category_name, A.model_year, A.list_price
		FROM	production.products A, production.brands B, production.categories C
		WHERE	A.brand_id = B.brand_id AND A.category_id = C.category_id AND
				A.product_id IN (
								SELECT	product_id
								FROM	production.stocks
								WHERE	quantity > 0
								)
)
SELECT * 
FROM t1
WHERE model_year = 2018
;


WITH t1  AS 
		(
		SELECT	A.product_name, B.brand_name, C.category_name, A.model_year, A.list_price
		FROM	production.products A, production.brands B, production.categories C
		WHERE	A.brand_id = B.brand_id AND A.category_id = C.category_id AND
				A.product_id IN (
								SELECT	product_id
								FROM	production.stocks
								WHERE	quantity > 0
								)
),
t2 AS
        (
		SELECT	A.product_name, B.brand_name, C.category_name, A.model_year, A.list_price
		FROM	production.products A, production.brands B, production.categories C
		WHERE	A.brand_id = B.brand_id AND A.category_id = C.category_id AND
				A.product_id IN (
								SELECT	product_id
								FROM	production.stocks
								WHERE	quantity > 0
								)


SELECT * 
FROM t1
WHERE model_year = 2018
;

--Recursive

WITH t1 (rakam) AS 
				(SELECT 0 rakam
				UNION ALL
				SELECT rakam + 1
				FROM t1
				WHERE rakam < 9
				)
SELECT *
FROM t1
;

------ LOGICAL OPERATORS -----
-- AND -- 3 numaral� ma�azadan 2018 y�l� Nisan ay�nda verilmi� sipari�leri listeleyin
SELECT	*
FROM	sales.orders
WHERE	YEAR(order_date) = 2018
		AND MONTH(order_date) = 4
		AND store_id = 3;
-- OR -- 1, 11 ve 111 id numaral� m��terilerin sipari�lerini customer_id ye g�re k���kten b�y��e do�ru listeleyin
SELECT	*
FROM	sales.orders
WHERE	customer_id = 1
		OR customer_id = 11
		OR customer_id = 111
ORDER BY customer_id;
-- BETWEEN -- 20.01.2018 ile 25.01.2018 tarihleri aras�ndaki sipari�leri listeleyin
SELECT	*
FROM	sales.orders
WHERE	order_date BETWEEN '2018-01-20' AND '2018-01-25'
ORDER BY order_date;
-- IN -- Los Angeles, San Diego ve Yuba City �ehirlerinde ikamet eden m��terileri listeleyin
SELECT	*
FROM	sales.customers
WHERE	city IN ('Los Angeles', 'San Diego', 'Yuba City')
ORDER BY city;













