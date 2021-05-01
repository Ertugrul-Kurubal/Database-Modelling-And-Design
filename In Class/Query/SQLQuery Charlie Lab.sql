CREATE DATABASE CharliesFactory;
USE CharliesFactory;

CREATE TABLE Product
(
ProductID INT,
ProductName VARCHAR (50),
Quantity INT
PRIMARY KEY (ProductID)
);

CREATE TABLE Component
(
ComponentID INT PRIMARY KEY,
ComponentName VARCHAR(50),
[Description] NVARCHAR (250),
Quantity_comp int
);

CREATE TABLE Supplier
(
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR(50),
SupplierLocation VARCHAR (50),
SupplierCountry VARCHAR (50),
IsActive bit
);

CREATE TABLE ProdComp
(
ProductID INT,
ComponentID INT,
Quantity_comp INT
PRIMARY KEY (ProductID, ComponentID)
FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
FOREIGN KEY (ComponentID) REFERENCES Component (ComponentID)
);

CREATE TABLE SuppComp
(
OrderID INT PRIMARY KEY,
ComponentID INT,
SupplierID INT,
OrderDate DATE,
QuantityOrder INT,
FOREIGN KEY (ComponentID) REFERENCES Component (ComponentID),
FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID)
)

INSERT Product(ProductID, ProductName, Quantity)
VALUES (1201, 'Aero', 120),
		(1202, 'Butterfinger', 230),
		(1203, 'Cailler', 140),
		(1204, 'Crunch', 180),
		(1205, 'Kit Kat', 160),
		(1206, 'Orion', 160),
		(1207, 'Smarties', 180),
		(1208, 'Toll House', 120),
		(1209, 'Wonka', 140)

BULK INSERT Component
   FROM 'C:\Users\e_kur\Documents\Clarusway\Database-Modelling-And-Design\In Class\Component'
WITH
   (
   rowterminator='\n',
   fieldterminator=','
   )

SELECT * FROM Component

INSERT INTO Supplier VALUES (123434, 'Adm do Brasil Ltda', 'Minas Gerais', 'Brazil', 1)
					 ,(123435, 'ADM Processing', 'Illinois', 'USA', 1)
					 ,(123436, 'ADM Speciality Food Ingredients', 'Illinois', 'USA', 1)
					 ,(123437, 'Bunge Alimentos SA', 'Goias', 'Brazil', 0)
					 ,(123438, 'Bunge', 'Washington', 'USA', 1)
					 ,(123439, 'Bunge', 'Kansas', 'USA', 1)
					 ,(123440, 'Bunge', 'Kansas', 'USA', 0)
					 ,(123441, 'Bunge', 'Tennessee', 'USA', 1)
					 ,(123442, 'Cargill S A C E I', 'Bluenos Aires', 'Argentina', 1)
					 ,(123443, 'Cargill Soybean', 'lowa', 'USA', 1)
					 ,(123444, 'Cargill Soybean', 'lowa', 'USA', 0)
					 ,(123445, 'Cereal Docks Spa', 'Vicenza', 'Italy', 1)
					 ,(123446, 'CHS (Soybean)', 'Minnesota', 'USA', 1)
					 ,(123447, 'Cj Selecta SA', 'Minas Gerais', 'Brazil', 1)
					 ,(123448, 'Loryb And Dp Ventures Limited', 'Kaduna', 'Nigeria', 1)
					 ,(123449, 'Masloekstraktsionnyy zavod Amurskiy', 'Amur', 'Russian Federation', 0)
					 ,(123450, 'Molinos Agro SA', 'Santa Fe', 'Argentina', 1)
					 ,(123451, 'Nalmaco Nigeria Limited', 'Kaduna', 'Nigeria', 1)
					 ,(123452, 'SOJAPROTEIN A.D. Becej', 'Vojvodina', 'Serbia', 1)
					 ,(123453, 'Solae LLC', 'Illinois', 'USA', 1)
					 ,(123454, 'Solteam', 'Mato Grosso', 'Brazil', 0)
					 ,(123455, 'Solteam', 'Amazonas', 'Brazil', 0)
					 ,(123456, 'Solteam', 'Parana', 'Brazil', 1)
					 ,(123457, 'Tsentr Soya OOO', 'Krasnodar', 'Russian Federation', 1)
					 ,(123458, 'Vanden Avenne Commodities NV', 'Goias', 'Brazil', 1)
					 ,(123459, 'Vanden Avenne Commodities NV', 'Goias', 'Brazil', 0)

INSERT INTO ProdComp(ProductID, ComponentID, Quantity_comp)
VALUES (1203, 23466, 5),
(1209, 23462, 2),
(1204, 23467, 6),
(1205, 23456, 3),
(1207, 23458, 7),
(1204, 23476, 3),
(1205, 23469, 5),
(1206, 23471, 8),
(1207, 23511, 6),
(1208, 23499, 8),
(1209, 23467, 9),
(1206, 23456, 4),
(1207, 23503, 2),
(1205, 23514, 3),
(1202, 23477, 5),
(1208, 23488, 7),
(1207, 23494, 4)

SELECT * FROM ProdComp