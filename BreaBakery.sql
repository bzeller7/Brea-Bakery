/**	
	Author: Brea Zeller
	Description: Creates the database for
		Brea's Bakery
	Date: August 14th, 2018

**/

USE master
GO

-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'BreaBakery'
)
DROP DATABASE BreaBakery
GO

CREATE DATABASE BreaBakery
GO

USE BreaBakery
/************************************************
	CREATE TABLES
***********************************************/

GO
--This creates a schema to be used when
--creating tables, instead of dbo
--CREATE SCHEMA OrderTable
GO
CREATE TABLE dbo.Employees
(
	EmployeeID		tinyint			PRIMARY KEY
	,LastName		varchar(50)		NOT NULL
	,FirstName		varchar(50)		NOT NULL
	,Title			varchar(50)		NOT NULL
	,BirthDate		DATETIME		NOT NULL
	,HireDate		DATETIME		NOT NULL
	,Phone			varchar(22)		NOT NULL
	,City			varchar(50)		NOT NULL
)



INSERT INTO Employees(EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Phone, City)
	VALUES('30',	'Rickword',	'Cosme', 'Help Desk Technician', '1-9-2018','3/4/2018',	'123-115-9115', 'Seattle')
	,('18', 'Digginson',	'Moe','Food Chemist','7-13-2018','6/18/2018','370-496-8285', 'San Jose')
	,('19', 'Thorouggood','Gunner','Recruiter','1/6/2018','9/12/2017','809-555-1131', 'Lakewood')
	,('50',	'Childers',	'Lil',	'Sales Representative',	'2/8/2018',	'3/29/2018','410-318-2654', 'Tacoma')

CREATE TABLE dbo.orderTable
 ( 
   OrderID		tinyint			PRIMARY KEY IDENTITY
  ,OrderDetails varchar(50)		NOT NULL 
  ,Customer		varchar(50)		NOT NULL
  ,EmployeeID	tinyint			NOT NULL REFERENCES Employees (EmployeeID)
  )
  

  INSERT INTO orderTable(OrderID, OrderDetails, Customer, EmployeeID)
	VALUES ('1', 'Brown Betty Apple', 'Bob McBobAppleperson', '30')
		,('2', 'Fruit Fool', 'Mrs. Smiths', '26')
		,('3', 'Devil Food Cake with Berries','Father Johnson', '50')

CREATE TABLE dbo.Customer
(
	CustomerID		tinyint			PRIMARY KEY 
	,FirstName		varchar(30)		NOT NULL
	,LastName		varchar(50)		NOT NULL
	,Phone			varchar(22)		NOT NULL
	,City			varchar(50)		NULL
)



INSERT INTO Customer(CustomerID, FirstName, LastName, Phone, City)
	VALUES ('13', 'Betty', 'Boop', '(234)322-2222', 'Seattle' )
		,('21', 'John', 'Doe', '(233)222-2340', 'Las Vegas')
		,('33', 'Jane', 'Doe','(444)333-2222', 'San Jose')

CREATE TABLE dbo.Suppliers
(
	SupplierID		varchar(50)		PRIMARY KEY
	,CompanyName	varchar(50)		NOT NULL
	,Address		varchar(50)		NULL
	,City			varchar(20)		NOT NULL
	,Country		varchar(20)		NOT NULL
	,Phone			varchar(22)		NOT NULL
)

INSERT INTO Suppliers (SupplierID, CompanyName, Address, City, Country, Phone)
	VALUES('22', 'Rolling Stone Suga Company', '', 'Seattle', 'USA', '(222)222-5555')
	,('14', 'Egging On Eds', '18 Box PO', 'San Jose', 'USA', '(444)333-2222')
	,('62', 'Cows ON MOOve', '', 'Las Vegas', 'USA', '(555)555-5555')
	,('33', 'Flowery Flour CO.', '44 La Street', 'Calgary', 'Canada', '(666)333-3333')

CREATE TABLE dbo.Products
(
	ProductID		varchar(50)		PRIMARY KEY
	,ProductName	varchar(50)		NOT NULL
	,UnitPrice		char(10)		NOT NULL
	,SupplierID		varchar(50)		REFERENCES Suppliers (SupplierID)
	,CategoryID		varchar(50)		NOT NULL
	,QuantityPer	varchar(50)		NOT NULL
)

INSERT INTO Products (ProductName, UnitPrice, SupplierID, CategoryID, QuantityPer)
	VALUES('Flour', '80.00', '33', '5', '100')
		,('Eggs', '122.00', '14', '11','300')
		,('Milk', '200.00', '62', '991','800')
		,('Sugar', '40.00', '22', '4', '60')

CREATE TABLE dbo.Categories
(
	CategoryID			varchar(100)		PRIMARY KEY
	,CategoryName		varchar(100)		NOT NULL
	,Description		varchar(100)		NOT NULL
)

INSERT INTO Categories (CategoryID, CategoryName, Description)
	VALUES (1, 'Chocolate Liqueur - Godet White', 'Suspendisse ornare consequat lectus.')
	,(2, 'Banana cream pie', 'Nullam varius. Has Milk and Eggs')
	,(3, 'Plain white cake', 'Aliquam augue quam, sollicitudin vitae, Flour')
	,(4, 'Chocolate Chip Cookies', 'Quisque id justo sit amet sapien dignissim ves')
	,(5, 'Red Velvet Cake', 'Morbi sem mauris=')

CREATE TABLE dbo.OrderDetails 
(
	OrderID		tinyint			PRIMARY KEY
	,UnitPrice	varchar(50)		NOT NULL
	,Quanity	varchar(50)		NOT NULL
	,Discount	varchar(50)		NULL	
)

INSERT INTO OrderDetails(OrderID, UnitPrice, Quanity, Discount)
	VALUES ('1', '33.00', '3', '')
	,('2', '80.00', '10', '5.00')
	,('3', '49.99', '60', '10.00')



CREATE TABLE dbo.Invoices
(
	OrderID			tinyint		PRIMARY KEY
	,InvoiceNum		tinyint		NOT NULL
	,OrderDate		DATETIME	NOT NULL
	,InvoiceDate	DATETIME	NOT NULL
	,EmployeeID		tinyint		REFERENCES Employees (EmployeeID)
)

INSERT INTO Invoices(OrderID, InvoiceNum, OrderDate, InvoiceDate)
	VALUES (1, 25, '2017-06-23 06:27:59', '2017-12-13 22:18:23')
	,(2, 40, '2018-01-10 16:45:10', '2017-12-31 19:48:40')
	,(3, 48, '2017-09-14 06:59:49', '2017-10-20 21:32:24')
	,(4, 53, '2017-05-18 02:19:11', '2018-03-16 07:10:03')
	,(5, 35, '2018-02-23 03:59:15', '2017-09-13 20:33:41')

CREATE TABLE dbo.ActiveOrderDetails
(
	ContactID	tinyint			PRIMARY KEY
	,LastName	varchar(50)		NOT NULL
	,Email		char(50)		NOT NULL 
	,Status		varchar(20)		NOT NULL
)

INSERT INTO ActiveOrderDetails (ContactID, LastName, Email, Status)
	VALUES (1, 'Barkes', 'rbarkes0@merriam-webster.com', 'Not Delivered')
	,(2, 'Goldhill', 'pgoldhill1@answers.com', 'Delivered')
	,(3, 'Pavelin', 'gpavelin2@msu.edu', 'Delivered')
	,(4, 'Wainwright', 'mwainwright3@slashdot.org','Refunded')
	,(5, 'Standeven', 'kstandeven4@surveymonkey.com', 'Refunded')

CREATE TABLE dbo.ActiveOrderCustomers
(
	ContactID		tinyint			PRIMARY KEY
	,DateTime		DATETIME		NOT NULL
	,ProductType	varchar(20)		NOT NULL
	,Description	varchar(50)		NOT NULL
)

INSERT INTO ActiveOrderCustomers(ContactID, DateTime, ProductType, Description)
	VALUES (1, '2017-06-23 06:27:59', 'Cake', 'Vanilla Cake')
	,(2, '2017-05-18 02:19:11', 'Pie', 'Pumpkin Pie')
	,(3, '2017-09-13 20:33:41', 'Cookies', 'Oatmal Raisins')
	,(4, '2017-12-31 19:48:40', 'Brownies','Cocoa Chips Brownies')
	,(5, '2018-02-23 03:59:15', 'Cake', 'Carrot Cake')