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

-- Maðaza çalýþanlarýný çalýþtýklarý maðaza bilgileriyle birlikte listeleyin
-- Çalýþan adý, soyadý, maðaza adlarýný seçin

SELECT A.first_name, A.last_name, B.store_name FROM [sales].[staffs] A, [sales].[stores] B
WHERE A.store_id = B.store_id
;

-- LEFT JOIN

SELECT A.product_id, A.product_name, A.category_id, B.category_name 
FROM production.products A  -- This is left table
LEFT JOIN production.categories B
ON A.category_id = B.category_id
;

-- Ürün bilgilerini stok miktarlarý ile birlikte listeleyin
--		Stokta bulunmayan ürünlerin bilgileri de gelsin istiyoruz
--		ProductID si 310 dan büyük olan ürünleri getirin
--		ProductID, ProductName ve stok bilgilerini seçin
-- Bu sorguyu INNER JOIN ile yapsaydýnýz nasýl bir farklýlýk olurdu?

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

-- Stok miktarlarý ile ilgili LEFT JOIN ile yaptýðýnýz sorguyu RIGHT JOIN ile yapýn
-- Her iki sorgu sonucunun da ayný olmasýný saðlayýn (satýr sayýsý, sütun sýralamasý vs.)

SELECT A.product_id, A.product_name, B.* 
FROM [production].[stocks] B  
RIGHT JOIN  production.products A -- This is right table
ON A.product_id = B.product_id
WHERE A.product_id > 310
;

-- Maðaza çalýþanlarýný yaptýklarý satýþlar ile birlikte listeleyin
-- Hiç satýþ yapmayan çalýþan varsa onlarýn da gelmesini istiyoruz.
-- Staff ID, Staff adý, soyadý ve sipariþ bilgilerini seçin
-- Sonucu daha iyi analiz edebilmek için sorguyu Staff ID alanýna göre sýralayýn.

SELECT A.staff_id, A.first_name, A.last_name, B.* 
FROM [sales].[orders] B
RIGHT JOIN [sales].[staffs] A
ON A.staff_id = B.staff_id
ORDER BY A.staff_id
;

-- FULL OUTER JOIN

-- Ürünlerin stok miktarlarý ve sipariþ bilgilerini birlikte listeleyin
-- production.stocks ve sales.order_items tablolarýný kullanýn
-- Sorgu sonucunda bütün sütunlarýn gelmesini saðlayýn
-- Çýkan sonucu daha kolay yorumlamak için product_id ve order_id alanlarýna göre sýralayýn

SELECT * 
FROM [sales].[order_items] A
FULL OUTER JOIN [production].[stocks] B
ON A.product_id = B.Product_id
ORDER BY A.product_id, A.order_id

-- CROSS JOIN

-- Hangi markada hangi kategoride kaçar ürün olduðu bilgisine ihtiyaç duyuluyor
-- Ürün sayýsý hesaplamadan sadece marka * kategori ihtimallerinin hepsini içeren bir tablo oluþturun.
-- Çýkan sonucu daha kolay yorumlamak için brand_id ve category_id alanlarýna göre sýralayýn

SELECT * 
FROM production.brands A
CROSS JOIN production.categories B
ORDER BY A.brand_id, B.category_id

-- Bazý ürünlerin stok bilgileri stocks tablosunda yok.
-- Bu ürünlerin herbir maðazada 0 adet olacak þekilde stocks tablosuna basýlmasý isteniyor.
-- Bunu nasýl yaparsýnýz?
-- Örneðin product_id = 314 olan ürünün stok bilgilerini kontrol edebilirsiniz
-- Sadece stock tablosuna basýlacak listeyi oluþturun, INSERT etmeyin

SELECT B.store_id, A.product_id, 0 quantity
FROM production.products A
CROSS JOIN sales.stores B
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks)
ORDER BY A.product_id, B.store_id

-- SELF JOIN
-- Personelleri ve þefleri listeleyin

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

-- Bir önceki sorgu sonucunda gelen þeflerin yanýna onlarýn da þeflerini getiriniz
-- Çalýþan adý, þef adý, þefin þefinin adý bilgilerini getirin

SELECT A.first_name staff_name,
       B.first_name manager_name,
	   C.first_name managers_manager_name
FROM sales.staffs A, sales.staffs B, sales.staffs C
WHERE A.manager_id = B.staff_id AND
	  B.manager_id = C.staff_id
;

-- Breakout Session Sorular:
-- Soru 1: Bir liste oluþturun ve bu listede ürün adý, model yýlý, fiyatý, kategorisi ve markasý bulunsun.
-- Soru 2: -- Bu liste oluþturun ve bu listede çalýþan adý soyadý, sipariþ tarihi, müþteri adý soyadý bulunsun.
-- Bu listede tüm çalýþanlarýn olmasýný saðlayýn fakat müþterilerden sadece sipariþ verenler bulunsun.

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