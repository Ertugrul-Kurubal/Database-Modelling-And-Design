--Having
--Product tablosunda herhangi bir product id'in çoklayýp çoklamadýðýný kontrol ediniz.

SELECT * FROM [production].[products]

SELECT product_id, Count(product_id) 
FROM [production].[products]
GROUP BY product_id
HAVING Count(product_id) > 1

--Maximum list price 4000'in üzerinde veya 500'den az olan ürünleri getiriniz.

SELECT b.category_id, MAX(a.list_price) AS max_price FROM [production].[products] a,
[production].[categories] b 
WHERE a.category_id = b.category_id AND (a.list_price > 4000 OR a.list_price <500)

SELECT     category_id, MAX(list_price) AS max_price, MIN(list_price) AS min_price
FROM       production.products
GROUP BY   category_id
HAVING     MAX(list_price) > 4000 OR MIN(list_price) < 500 ;

--Markalara ait ortalama ürün fiyatlarýný bulunuz
--Ortalama fiyatlara göre azalan sýrayla gösteriniz.

SELECT a.brand_name, AVG(list_price) AS Avg_Price  FROM [production].[brands] a,
[production].[products] b
WHERE a.brand_id = b.brand_id
GROUP BY a.brand_name
ORDER BY AVG(list_price) DESC

--Ortalama ürün fiyatý 1000'den yüksek olan markalarý getiriniz.

SELECT a.brand_name, AVG(list_price) AS Avg_Price  FROM [production].[brands] a,
[production].[products] b
WHERE a.brand_id = b.brand_id
GROUP BY a.brand_name
HAVING AVG(list_price) > 1000

/*SELECT * FROM (SELECT a.brand_name, AVG(list_price) FROM [production].[brands] a,
[production].[products] b
WHERE a.brand_id = b.brand_id
GROUP BY a.brand_name)
WHERE  > 1000
*/

--Bir sipariþin toplam net tutarýný getiriniz. (müþterinin sipariþ için ödediði tutar)
--Discount'ý düþmeyi ihmal etmeyiniz.

SELECT order_id,SUM(quantity*list_price*(1-discount)) net_value 
FROM [sales].[order_items]
GROUP BY order_id
ORDER BY order_id

--Summary Table

SELECT b.brand_name AS brand, c.category_name AS category, p.model_year,
     ROUND (SUM (quantity * i.list_price * (1 - discount)) , 0 ) sales
INTO sales.sales_summary
FROM
sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year

--kategorilere göre satýþ miktarýný hesaplayýn 

SELECT category, SUM(sales)
FROM sales.sales_summary
GROUP BY category

--bu tabloyu subquery olarak kullanarak pivot oluþtur.

SELECT *
FROM	(SELECT category,(sales)
		FROM sales.sales_summary
		) A
PIVOT
(
	SUM(sales)
	FOR category IN
	(
	[Children Bicycles],
	[Comfort Bicycles],
	[Cruisers Bicycles],
	[Cyclocross Bicycles],
	[Electric Bikes],
	[Mountain Bikes],
	[Road Bikes])
	) AS PIVOT_TABLE



SELECT *
FROM
			(
			SELECT category , sales,model_year
			FROM SALES.sales_summary
			) A
PIVOT
(
	SUM(sales)
	FOR category IN
	(
	[Children Bicycles],
    [Comfort Bicycles],
    [Cruisers Bicycles],
    [Cyclocross Bicycles],
    [Electric Bikes],
    [Mountain Bikes],
    [Road Bikes])
	) AS PIVOT_TABLE