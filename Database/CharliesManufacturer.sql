USE [master]
GO
/****** Object:  Database [CharliesManufacturer]    Script Date: 24/04/2021 15:18:20 ******/
CREATE DATABASE [CharliesManufacturer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CharliesManufacturer2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CharliesManufacturer2.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CharliesManufacturer2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CharliesManufacturer2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CharliesManufacturer] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CharliesManufacturer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CharliesManufacturer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET ARITHABORT OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CharliesManufacturer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CharliesManufacturer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CharliesManufacturer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CharliesManufacturer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET RECOVERY FULL 
GO
ALTER DATABASE [CharliesManufacturer] SET  MULTI_USER 
GO
ALTER DATABASE [CharliesManufacturer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CharliesManufacturer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CharliesManufacturer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CharliesManufacturer] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CharliesManufacturer] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CharliesManufacturer', N'ON'
GO
ALTER DATABASE [CharliesManufacturer] SET QUERY_STORE = OFF
GO
USE [CharliesManufacturer]
GO
/****** Object:  Table [dbo].[Comp_Supp]    Script Date: 24/04/2021 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comp_Supp](
	[order_ID] [float] NOT NULL,
	[comp_ID] [float] NOT NULL,
	[supp_ID] [float] NOT NULL,
	[order_date] [date] NOT NULL,
	[quantity_order] [float] NOT NULL,
 CONSTRAINT [PK_Comp_Supp] PRIMARY KEY CLUSTERED 
(
	[order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Component]    Script Date: 24/04/2021 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Component](
	[comp_ID] [float] NOT NULL,
	[comp_name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[quantity_comp] [float] NULL,
 CONSTRAINT [PK_Component] PRIMARY KEY CLUSTERED 
(
	[comp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prod_Comp]    Script Date: 24/04/2021 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prod_Comp](
	[prod_ID] [float] NOT NULL,
	[comp_ID] [float] NOT NULL,
	[quantity_comp] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 24/04/2021 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[prod_ID] [float] NOT NULL,
	[prod_name] [nvarchar](255) NOT NULL,
	[quantity] [float] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[prod_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 24/04/2021 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[supp_ID] [float] NOT NULL,
	[supp_name] [nvarchar](255) NOT NULL,
	[supp_location] [nvarchar](255) NOT NULL,
	[supp_country] [nvarchar](255) NOT NULL,
	[is_active] [float] NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[supp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10021, 23455, 123434, CAST(N'2020-03-22' AS Date), 19)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10022, 23456, 123435, CAST(N'2020-06-17' AS Date), 34)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10023, 23457, 123436, CAST(N'2020-07-14' AS Date), 62)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10024, 23458, 123437, CAST(N'2020-07-20' AS Date), 35)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10025, 23459, 123438, CAST(N'2020-04-01' AS Date), 14)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10026, 23460, 123439, CAST(N'2020-05-05' AS Date), 12)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10027, 23461, 123440, CAST(N'2020-07-16' AS Date), 28)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10028, 23462, 123441, CAST(N'2020-04-08' AS Date), 14)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10029, 23463, 123442, CAST(N'2020-10-15' AS Date), 45)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10030, 23464, 123443, CAST(N'2020-04-09' AS Date), 22)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10031, 23465, 123444, CAST(N'2020-09-20' AS Date), 18)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10032, 23466, 123445, CAST(N'2020-05-17' AS Date), 16)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10033, 23467, 123446, CAST(N'2020-03-23' AS Date), 39)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10034, 23468, 123447, CAST(N'2020-10-09' AS Date), 39)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10035, 23469, 123448, CAST(N'2020-11-07' AS Date), 31)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10036, 23470, 123449, CAST(N'2020-05-20' AS Date), 40)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10037, 23471, 123450, CAST(N'2020-12-11' AS Date), 42)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10038, 23472, 123451, CAST(N'2020-06-02' AS Date), 62)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10039, 23473, 123452, CAST(N'2020-05-18' AS Date), 61)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10040, 23474, 123453, CAST(N'2020-04-21' AS Date), 63)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10041, 23475, 123454, CAST(N'2020-11-09' AS Date), 66)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10042, 23458, 123455, CAST(N'2020-05-08' AS Date), 50)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10043, 23467, 123456, CAST(N'2020-10-09' AS Date), 14)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10044, 23460, 123457, CAST(N'2020-05-06' AS Date), 40)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10045, 23457, 123458, CAST(N'2020-11-26' AS Date), 51)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10046, 23475, 123459, CAST(N'2020-04-19' AS Date), 41)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10047, 23463, 123440, CAST(N'2020-09-30' AS Date), 31)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10048, 23456, 123447, CAST(N'2020-04-23' AS Date), 33)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10049, 23460, 123453, CAST(N'2020-12-09' AS Date), 53)
INSERT [dbo].[Comp_Supp] ([order_ID], [comp_ID], [supp_ID], [order_date], [quantity_order]) VALUES (10050, 23470, 123435, CAST(N'2020-12-31' AS Date), 47)
GO
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23455, N'Sugar', N'Şeker', 2526)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23456, N'Flavouring', N'Tat verici', 2212)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23457, N'Dairy', N'Mandıra', 2096)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23458, N'Oil and fat', N'Yağ ve yağ', 1744)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23459, N'Salt', N'Tuz', 1585)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23460, N'Vegetable oil and fat', N'Bitkisel yağ ve yağ', 1487)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23461, N'Cocoa', N'Kakao', 1466)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23462, N'Emulsifier', N'emülgatör', 1403)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23463, N'Milk', N'Süt', 1375)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23464, N'E322', N'E322', 1331)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23465, N'Cereal', N'Tahıl', 1296)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23466, N'Natural flavouring', N'Doğal aromalı', 1269)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23467, N'Glucose', N'glikoz', 1222)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23468, N'Flour', N'Un', 1195)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23469, N'Starch', N'Nişasta', 1163)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23470, N'Wheat', N'Buğday', 1128)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23471, N'Milk powder', N'Süt tozu', 1101)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23472, N'E322i', N'E322i', 1076)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23473, N'Vegetable oil', N'Sebze yağı', 1008)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23474, N'Water', N'Su', 973)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23475, N'Cereal flour', N'Tahıl unu', 889)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23476, N'Cocoa butter', N'Kakao yağı', 876)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23477, N'Glucose syrup', N'Glikoz şurubu', 875)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23478, N'Wheat flour', N'Buğday unu', 834)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23479, N'Skimmed milk powder', N'Yağsız süt tozu', 801)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23480, N'Cocoa paste', N'Kakao hamuru', 799)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23481, N'Vegetable', N'Sebze', 786)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23482, N'Minerals', N'Mineraller', 763)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23483, N'Fruit', N'Meyve', 718)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23484, N'Vitamins', N'Vitaminler', 695)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23485, N'Root vegetable', N'Bitki kökü', 650)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23486, N'Palm oil and fat', N'Hurma yağı ve yağ', 632)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23487, N'Vanilla flavouring', N'Vanilya aromalı', 620)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23488, N'Sunflower lecithin', N'Ayçiçeği lesitin', 585)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23489, N'Whey', N'Kesilmiş sütün suyu', 572)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23490, N'Natural vanilla flavouring', N'Doğal vanilya aromalı', 561)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23491, N'Soya lecithin', N'Soya lesitini', 536)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23492, N'Sunflower oil', N'Ayçiçek yağı', 526)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23493, N'E375', N'E375', 518)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23494, N'Palm oil', N'Palmiye yağı', 517)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23495, N'Colour', N'Renk', 506)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23496, N'Iron', N'Demir', 504)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23497, N'Cream', N'Krem', 501)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23498, N'E101', N'E101', 492)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23499, N'Fat', N'Şişman', 488)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23500, N'Spice', N'baharat', 485)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23501, N'Skimmed milk', N'Yağsız süt', 476)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23502, N'Acidity regulator', N'Asitlik düzenleyici', 475)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23503, N'Cocoa powder', N'Kakao tozu', 463)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23504, N'Corn starch', N'Mısır nişastası', 458)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23505, N'Protein', N'Protein', 455)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23506, N'Vitamin B6', N'B6 vitamini', 451)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23507, N'Chocolate', N'Çikolata', 443)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23508, N'Folate', N'Folat', 442)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23509, N'Stabiliser', N'stabilizatör', 440)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23510, N'Folic acid', N'Folik asit', 440)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23511, N'Antioxidant', N'Antioksidan', 434)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23512, N'Whey powder', N'Peynir altı suyu tozu', 430)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23513, N'Lactose', N'Laktoz', 428)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23514, N'Whole milk', N'Tam yağlı süt', 420)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23515, N'Rice', N'Pirinç', 418)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23516, N'Milkfat', N'Süt yağı', 418)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23517, N'Plant', N'Bitki', 414)
INSERT [dbo].[Component] ([comp_ID], [comp_name], [description], [quantity_comp]) VALUES (23518, N'E330', N'E330', 413)
GO
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1203, 23466, 5)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1209, 23462, 2)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1204, 23467, 6)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1205, 23456, 3)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1207, 23458, 7)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1204, 23476, 3)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1205, 23469, 5)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1206, 23471, 8)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1207, 23511, 6)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1208, 23499, 8)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1209, 23467, 9)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1206, 23456, 4)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1207, 23503, 2)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1205, 23514, 3)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1202, 23477, 5)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1208, 23488, 7)
INSERT [dbo].[Prod_Comp] ([prod_ID], [comp_ID], [quantity_comp]) VALUES (1207, 23494, 4)
GO
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1201, N'Aero', 120)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1202, N'Butterfinger', 230)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1203, N'Cailler', 140)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1204, N'Crunch', 180)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1205, N'Kit Kat', 160)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1206, N'Orion', 160)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1207, N'Smarties', 180)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1208, N'Toll House', 120)
INSERT [dbo].[Product] ([prod_ID], [prod_name], [quantity]) VALUES (1209, N'Wonka', 140)
GO
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123434, N'Adm do Brasil Ltda', N'Minas Gerais', N'Brazil', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123435, N'ADM Processing', N'Illinois', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123436, N'ADM Speciality Food Ingredients', N'Illinois', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123437, N'Bunge Alimentos SA', N'Goias', N'Brazil', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123438, N'Bunge', N'Washington', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123439, N'Bunge', N'Kansas', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123440, N'Bunge', N'Kansas', N'USA', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123441, N'Bunge', N'Tennessee', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123442, N'Cargill S A C E I', N'Buenos Aires', N'Argentina', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123443, N'Cargill Soybean', N'Iowa', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123444, N'Cargill Soybean', N'Iowa', N'USA', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123445, N'Cereal Docks Spa', N'Vicenza', N'Italy', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123446, N'CHS (Soybean)', N'Minnesota', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123447, N'Cj Selecta SA', N'Minas Gerais', N'Brazil', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123448, N'Loryb And Dp Ventures Limited', N'Kaduna', N'Nigeria', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123449, N'Masloekstraktsionnyy zavod Amurskiy', N'Amur', N'Russian Federation', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123450, N'Molinos Agro SA', N'Santa Fe', N'Argentina', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123451, N'Nalmaco Nigeria Limited', N'Kaduna', N'Nigeria', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123452, N'SOJAPROTEIN A.D. Becej', N'Vojvodina', N'Serbia', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123453, N'Solae LLC', N'Illinois', N'USA', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123454, N'Solteam', N'Mato Grosso', N'Brazil', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123455, N'Solteam', N'Amazonas', N'Brazil', 0)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123456, N'Solteam', N'Paraná', N'Brazil', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123457, N'Tsentr Soya OOO', N'Krasnodar', N'Russian Federation', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123458, N'Vanden Avenne Commodities NV', N'Goias', N'Brazil', 1)
INSERT [dbo].[Supplier] ([supp_ID], [supp_name], [supp_location], [supp_country], [is_active]) VALUES (123459, N'Vanden Avenne Commodities NV', N'Goias', N'Brazil', 0)
GO
ALTER TABLE [dbo].[Comp_Supp]  WITH CHECK ADD  CONSTRAINT [FK_Comp_Supp_Component] FOREIGN KEY([comp_ID])
REFERENCES [dbo].[Component] ([comp_ID])
GO
ALTER TABLE [dbo].[Comp_Supp] CHECK CONSTRAINT [FK_Comp_Supp_Component]
GO
ALTER TABLE [dbo].[Comp_Supp]  WITH CHECK ADD  CONSTRAINT [FK_Comp_Supp_Supplier] FOREIGN KEY([supp_ID])
REFERENCES [dbo].[Supplier] ([supp_ID])
GO
ALTER TABLE [dbo].[Comp_Supp] CHECK CONSTRAINT [FK_Comp_Supp_Supplier]
GO
ALTER TABLE [dbo].[Prod_Comp]  WITH CHECK ADD  CONSTRAINT [FK_Prod_Comp_Component] FOREIGN KEY([comp_ID])
REFERENCES [dbo].[Component] ([comp_ID])
GO
ALTER TABLE [dbo].[Prod_Comp] CHECK CONSTRAINT [FK_Prod_Comp_Component]
GO
ALTER TABLE [dbo].[Prod_Comp]  WITH CHECK ADD  CONSTRAINT [FK_Prod_Comp_Product] FOREIGN KEY([prod_ID])
REFERENCES [dbo].[Product] ([prod_ID])
GO
ALTER TABLE [dbo].[Prod_Comp] CHECK CONSTRAINT [FK_Prod_Comp_Product]
GO
USE [master]
GO
ALTER DATABASE [CharliesManufacturer] SET  READ_WRITE 
GO
