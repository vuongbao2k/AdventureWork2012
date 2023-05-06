--drop database DW
create database DW;
GO
USE DW;
GO

CREATE TABLE [dbo].[Dim_SalesPerson](
	[BusinessEntityID] [int] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FullName] [nvarchar](308) NULL,
	[NationalIDNumber] [nvarchar](15) NULL,
	[JobTitle] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[Gender] [nchar](1) NULL,
	[HireDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_Territory](
	[TerritoryID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL,
	[Group] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_Year](
	[YearKey] [nvarchar](4) NOT NULL,
	[Year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[YearKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_Month](
	[MonthKey] [nvarchar](6) NOT NULL,
	[YearKey] [nvarchar](4) NULL,
	[Month] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MonthKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_Month]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Month_Dim_Year_YearKey] FOREIGN KEY([YearKey])
REFERENCES [dbo].[Dim_Year] ([YearKey])
GO


CREATE TABLE [dbo].[Dim_Date](
	[DateKey] [nvarchar](8) NOT NULL,
	[MonthKey] [nvarchar](6) NULL,
	[Day] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_Date]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Date_Dim_Month_MonthKey] FOREIGN KEY([MonthKey])
REFERENCES [dbo].[Dim_Month] ([MonthKey])
GO


CREATE TABLE [dbo].[Fact_SalesOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [nvarchar](8) NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[Revenue] [money] NULL,
	[NumberOrder] [numeric](20, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_Date_DateKey] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim_Date] ([DateKey])
GO
ALTER TABLE [dbo].[Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_SalesPerson_SalesPersonID] FOREIGN KEY([SalesPersonID])
REFERENCES [dbo].[Dim_SalesPerson] ([BusinessEntityID])
GO
ALTER TABLE [dbo].[Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_Territory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [dbo].[Dim_Territory] ([TerritoryID])
GO


CREATE TABLE [dbo].[Dim_ProductCategory](
	[ProductCategoryID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_ProductSubcategory](
	[ProductSubcategoryID] [int] NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED 
(
	[ProductSubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_ProductSubcategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[Dim_ProductCategory] ([ProductCategoryID])
GO


CREATE TABLE [dbo].[Dim_Product](
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Weight] [decimal](8, 2) NULL,
	[ProductSubcategoryID] [int] NULL,
 CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY([ProductSubcategoryID])
REFERENCES [dbo].[Dim_ProductSubcategory] ([ProductSubcategoryID])
GO


CREATE TABLE [dbo].[Fact_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [nvarchar](8) NULL,
	[ProductID] [int] NULL,
	[TerritoryID] [int] NULL,
	[OrderQty] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Date_DateKey] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim_Date] ([DateKey])
GO
ALTER TABLE [dbo].[Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Dim_Product] ([ProductID])
GO
ALTER TABLE [dbo].[Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Territory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [dbo].[Dim_Territory] ([TerritoryID])
GO