-- INNER JOIN

SELECT A.product_id, A.product_name, A.category_id, B.category_name 
FROM production.products A
INNER JOIN production.categories B
ON A.category_id = B.category_id
;

SELECT A.product_id, A.product_name, A.category_id, B.category_name 
FROM production.products A, production.categories B
WHERE A.category_id = B.category_id
; --This is other type

-- Ma�aza �al��anlar�n� �al��t�klar� ma�aza bilgileriyle birlikte listeleyin
-- �al��an ad�, soyad�, ma�aza adlar�n� se�in

SELECT A.first_name, A.last_name, B.store_name FROM [sales].[staffs] A, [sales].[stores] B
WHERE A.store_id = B.store_id
;

-- LEFT JOIN

SELECT A.product_id, A.product_name, A.category_id, B.category_name 
FROM production.products A  -- This is left table
LEFT JOIN production.categories B
ON A.category_id = B.category_id
;

-- �r�n bilgilerini stok miktarlar� ile birlikte listeleyin
--		Stokta bulunmayan �r�nlerin bilgileri de gelsin istiyoruz
--		ProductID si 310 dan b�y�k olan �r�nleri getirin
--		ProductID, ProductName ve stok bilgilerini se�in
-- Bu sorguyu INNER JOIN ile yapsayd�n�z nas�l bir farkl�l�k olurdu?

SELECT A.product_id, A.product_name, B.* 
FROM production.products A  -- This is left table
LEFT JOIN [production].[stocks] B
ON A.product_id = B.product_id
;

SELECT A.product_id, A.product_name, B.* 
FROM production.products A  -- This is left table
LEFT JOIN [production].[stocks] B
ON A.product_id = B.product_id AND 
A.product_id > 310
;

SELECT A.product_id, A.product_name, B.* 
FROM production.products A  -- This is left table
LEFT JOIN [production].[stocks] B
ON A.product_id = B.product_id
WHERE A.product_id > 310
;

-- RIGHT JOIN

-- Stok miktarlar� ile ilgili LEFT JOIN ile yapt���n�z sorguyu RIGHT JOIN ile yap�n
-- Her iki sorgu sonucunun da ayn� olmas�n� sa�lay�n (sat�r say�s�, s�tun s�ralamas� vs.)

SELECT A.product_id, A.product_name, B.* 
FROM [production].[stocks] B  
RIGHT JOIN  production.products A -- This is right table
ON A.product_id = B.product_id
WHERE A.product_id > 310
;

-- Ma�aza �al��anlar�n� yapt�klar� sat��lar ile birlikte listeleyin
-- Hi� sat�� yapmayan �al��an varsa onlar�n da gelmesini istiyoruz.
-- Staff ID, Staff ad�, soyad� ve sipari� bilgilerini se�in
-- Sonucu daha iyi analiz edebilmek i�in sorguyu Staff ID alan�na g�re s�ralay�n.

SELECT A.staff_id, A.first_name, A.last_name, B.* 
FROM [sales].[orders] B
RIGHT JOIN [sales].[staffs] A
ON A.staff_id = B.staff_id
ORDER BY A.staff_id
;

-- FULL OUTER JOIN

-- �r�nlerin stok miktarlar� ve sipari� bilgilerini birlikte listeleyin
-- production.stocks ve sales.order_items tablolar�n� kullan�n
-- Sorgu sonucunda b�t�n s�tunlar�n gelmesini sa�lay�n
-- ��kan sonucu daha kolay yorumlamak i�in product_id ve order_id alanlar�na g�re s�ralay�n

SELECT * 
FROM [sales].[order_items] A
FULL OUTER JOIN [production].[stocks] B
ON A.product_id = B.Product_id
ORDER BY A.product_id, A.order_id

-- CROSS JOIN

-- Hangi markada hangi kategoride ka�ar �r�n oldu�u bilgisine ihtiya� duyuluyor
-- �r�n say�s� hesaplamadan sadece marka * kategori ihtimallerinin hepsini i�eren bir tablo olu�turun.
-- ��kan sonucu daha kolay yorumlamak i�in brand_id ve category_id alanlar�na g�re s�ralay�n

SELECT * 
FROM production.brands A
CROSS JOIN production.categories B
ORDER BY A.brand_id, B.category_id

-- Baz� �r�nlerin stok bilgileri stocks tablosunda yok.
-- Bu �r�nlerin herbir ma�azada 0 adet olacak �ekilde stocks tablosuna bas�lmas� isteniyor.
-- Bunu nas�l yapars�n�z?
-- �rne�in product_id = 314 olan �r�n�n stok bilgilerini kontrol edebilirsiniz
-- Sadece stock tablosuna bas�lacak listeyi olu�turun, INSERT etmeyin

SELECT B.store_id, A.product_id, 0 quantity
FROM production.products A
CROSS JOIN sales.stores B
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks)
ORDER BY A.product_id, B.store_id

-- SELF JOIN
-- Personelleri ve �efleri listeleyin

SELECT A.first_name staff_name,
       B.first_name manager_name
FROM sales.staffs A
JOIN sales.staffs B
ON A.manager_id = B.staff_id
;

SELECT A.first_name staff_name,
       B.first_name manager_name
FROM sales.staffs A, sales.staffs B
WHERE A.manager_id = B.staff_id
;

-- Bir �nceki sorgu sonucunda gelen �eflerin yan�na onlar�n da �eflerini getiriniz
-- �al��an ad�, �ef ad�, �efin �efinin ad� bilgilerini getirin

SELECT A.first_name staff_name,
       B.first_name manager_name,
	   C.first_name managers_manager_name
FROM sales.staffs A, sales.staffs B, sales.staffs C
WHERE A.manager_id = B.staff_id AND
	  B.manager_id = C.staff_id
;

-- Breakout Session Sorular:
-- Soru 1: Bir liste olu�turun ve bu listede �r�n ad�, model y�l�, fiyat�, kategorisi ve markas� bulunsun.
-- Soru 2: -- Bu liste olu�turun ve bu listede �al��an ad� soyad�, sipari� tarihi, m��teri ad� soyad� bulunsun.
-- Bu listede t�m �al��anlar�n olmas�n� sa�lay�n fakat m��terilerden sadece sipari� verenler bulunsun.

-- Q1 1-way
SELECT A.product_name, A.model_year, A.list_price, B.category_name, C.brand_name FROM production.products A
INNER JOIN production.categories B
ON A.category_id = B.category_id
INNER JOIN production.brands C
ON A.brand_id = C.brand_id

-- Q2 1-way
SELECT A.first_name, A.last_name, B.order_date, C.first_name, C.last_name FROM sales.staffs A
LEFT JOIN sales.orders B
ON A.staff_id = B.staff_id
LEFT JOIN sales.customers C
ON B.customer_id = C.customer_id

-- Q1 2-way
SELECT A.product_name, A.model_year, A.list_price, B.category_name, C.brand_name 
FROM production.products A, production.categories B, production.brands C
WHERE A.category_id = B.category_id AND
A.brand_id = C.brand_id