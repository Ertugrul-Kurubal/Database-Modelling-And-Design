-- DATE and TIME DATA TYPES
-- Bikestores DB tablolarýnda yer alan date veya time sütunlarýný inceleyiniz.
SELECT * FROM
[sales].[orders]

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS --Show all Database data type vb.

SELECT DISTINCT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'date'
;

SELECT*
FROM SYSOBJECTS
WHERE xtype = 'U'
;

-- Herbir date and time data tiplerini içeren bir tablo create ediniz.
CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
);

-- Bu tabloya farklý deðerler giriniz.
-- Deðerleri girerken hem týrnak içinde giriniz hem de Construct Date and Time fonksiyonlarýný kullanýnýz.

SELECT * 
FROM [dbo].[t_date_time]

INSERT INTO [dbo].[t_date_time] (A_time)
VALUES ('12:00:00');

INSERT INTO [dbo].[t_date_time] (A_date)
VALUES ('2021-05-17');

INSERT INTO [dbo].[t_date_time] (A_datetime)
VALUES ('2021-05-16 12:00:00');

INSERT INTO [dbo].[t_date_time] (A_smalldatetime)
VALUES ('2021-04-26 13:00:00');

INSERT INTO [dbo].[t_date_time] (A_datetime2)
VALUES ('2021-04-26 14:24:00');

INSERT INTO [dbo].[t_date_time] (A_datetimeoffset)
VALUES ('2021-04-26 13:00:00 +3:00');

INSERT INTO [dbo].[t_date_time] (A_smalldatetime)
VALUES ('2021-04-26 13:00:00');

INSERT INTO dbo.t_date_time (A_time) VALUES (TIMEFROMPARTS(12,0,0,0,0));

INSERT INTO t_date_time (A_time) VALUES (TIMEFROMPARTS(20,00,00,0,0));
INSERT INTO t_date_time (A_date) VALUES (DATEFROMPARTS(2021,05,17));
INSERT INTO t_date_time (A_datetime) VALUES (DATETIMEFROMPARTS(2021,05,17, 20,0,0,0));
INSERT INTO t_date_time (A_datetimeoffset) VALUES (DATETIMEOFFSETFROMPARTS(2021,05,17, 20,0,0,0, 2,0,0));

-- Return Date or Time Parts fonksiyonlarýný kullanýnýz
-- DATENAME, DATEPART, DAY, MONTH, YEAR
-- Datepartlar nelerdir?
-- Yeni oluþturulan tablodaki tarih deðerlerinden yýl, ay, gün,
-- saat, dakika, saniye deðerlerini getiriniz.

SELECT A_date, DATENAME(D, A_date), DAY(A_date), DATEPART(D, A_date),
DATENAME(WEEK, A_date), DATENAME(YEAR, A_date), DATENAME(MONTH, A_date), DATENAME(DW, A_date)
FROM [dbo].[t_date_time]

SELECT * 
FROM sales.orders;

SELECT *,  
		DATENAME(DW, order_date) hafta_gun,
		DATEDIFF(DAY,order_date, required_date) fark_gun,
		DATEDIFF(WEEK,order_date, required_date) fark_hafta
FROM sales.orders

SELECT *,
		DATEADD(D, 3, order_date) order_date_3,
		DATEADD(M, 2, required_date) required_date_2M,
		DATEADD(WEEK, -1, required_date) required_date_1H_before,
		EOMONTH(order_date) order_date_last
FROM sales.orders;

SELECT *,
		ISDATE(order_date) order_date_ISDATE,
		ISDATE(shipped_date) shipped_date_ISDATE,
		ISDATE(store_id) store_ID_ISDATE
FROM sales.orders

SELECT GETDATE();

SELECT CURRENT_TIMESTAMP;

SELECT GETUTCDATE(); -- Greenwitch hour date

SELECT ISDATE(GETDATE());

SELECT ISDATE('2021-05-17'); -- Right format bool 1 (True)

SELECT ISDATE('2021-17-05'); -- Wrong format bool 0 (False)





























