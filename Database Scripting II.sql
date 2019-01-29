-- =============================================
-- Author:		Brea Zeller
-- Create date: August 21, 2018
-- Description:	Creates the views, stored Prodecures and use CHECK Constraints
-- =============================================


--Creating the Views

-- I've made this view so we can include the email AND what kind of product the customer did order so the employees can contact 
-- the customer regarding the product. 
Create View Active_Orders AS
SELECT        dbo.ActiveOrderDetails.LastName, dbo.ActiveOrderCustomers.ContactID, dbo.ActiveOrderDetails.Email, dbo.ActiveOrderCustomers.ProductType, dbo.ActiveOrderDetails.Status
FROM            dbo.ActiveOrderCustomers INNER JOIN
                         dbo.ActiveOrderDetails ON dbo.ActiveOrderCustomers.ContactID = dbo.ActiveOrderDetails.ContactID

--Testing to see if View Active_Orders work

SELECT *
FROM Active_Orders

-- I want the supply_Order to have both name of Supply needed for the bakery AND name of company who supplied the product
CREATE VIEW Supply_Orders AS
SELECT        dbo.Suppliers.CompanyName, dbo.Products.CategoryID, dbo.Products.ProductName, dbo.OrderDetails.UnitPrice
FROM            dbo.Suppliers INNER JOIN
                         dbo.Products ON dbo.Suppliers.SupplierID = dbo.Products.SupplierID CROSS JOIN
                         dbo.OrderDetails

--Testing Supply_Orders View
SELECT DISTINCT *
FROM Supply_Orders 

--For this view, I've include the contactID each for name and last name of customer, even if it's repeating customers to keep up 
-- with the order they made. 
CREATE View Older_Orders AS
SELECT        dbo.ActiveOrderCustomers.ContactID, dbo.Customer.CustomerID, dbo.Customer.FirstName, dbo.Customer.Phone, dbo.Customer.LastName, dbo.ActiveOrderCustomers.ProductType, dbo.ActiveOrderCustomers.Description, 
                         dbo.ActiveOrderCustomers.DateTime
FROM            dbo.ActiveOrderCustomers CROSS JOIN
                         dbo.Customer
--Testing Older_Orders View
SELECT DISTINCT FirstName, LastName,
				ContactID
FROM Older_Orders


-- This view has combined the name of product, what number of invoice it is, and the date that it has been ordered.
CREATE VIEW Invoice_Order AS
SELECT        dbo.Categories.CategoryName, dbo.Invoices.InvoiceNum, dbo.OrderDetails.OrderID, dbo.Products.ProductName, dbo.Invoices.OrderDate
FROM            dbo.Products INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID CROSS JOIN
                         dbo.OrderDetails INNER JOIN
                         dbo.Invoices ON dbo.OrderDetails.OrderID = dbo.Invoices.OrderID
--Testing Invoice_Order View
SELECT CategoryName, InvoiceNum, OrderDate
FROM Invoice_Order

--The view has the database of both first and last name from Employees and Customers so the bakery can keep track of it.
CREATE VIEW People_Name AS
SELECT        TOP (100) PERCENT dbo.Employees.FirstName AS EmpFirstName, dbo.Employees.LastName AS EmpLastName, dbo.Customer.FirstName AS CustFirstName, dbo.Customer.LastName AS CustLastName
FROM            dbo.ActiveOrderDetails CROSS JOIN
                         dbo.Customer CROSS JOIN
                         dbo.Employees
ORDER BY dbo.ActiveOrderDetails.LastName

--Testing People_Name View
SELECT DISTINCT CustFirstName, EmpFirstName
FROM People_Name


--Creating the stored Procedures

CREATE PROCEDURE Employees_data
	-- Add the parameters for the stored procedure here
	@LastName varchar(50) = NULL, 
	@FirstName varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @LastName, @FirstName From Employees
END

GO

USE [BreaBakery]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Employees_data]
		@LastName = N'Johnson',
		@FirstName = N'Jack'

SELECT	'Return Value' = @return_value

GO

CREATE PROCEDURE Customer_Data 
	-- Add the parameters for the stored procedure here
	@City nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @City From Customer
END
GO

USE [BreaBakery]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Customer_Data]
		@City = N'Seattle'

SELECT	'Return Value' = @return_value

GO


CREATE PROCEDURE Product_Details 
	-- Add the parameters for the stored procedure here
	@P_Type nvarchar(50) = NULL, 
	@P_Descrip nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @P_Type, @P_Descrip
END
GO

CREATE PROCEDURE Order_Details 
	-- Add the parameters for the stored procedure here
	@Customer_Name varchar(50) = 0, 
	@Product_Name varchar(50) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @Customer_Name, @Product_Name
END
GO

CREATE PROCEDURE Supplier_Name 
	-- Add the parameters for the stored procedure here
	@Supply_Com varchar(50) = 0, 
	@City varchar(20) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @Supply_Com, @City
END
GO

CREATE PROCEDURE Supply_Order 
	-- Add the parameters for the stored procedure here
	@ProductName varchar(50) = 0, 
	@QuantityPer varchar(50) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @ProductName, @QuantityPer
END
GO

CREATE PROCEDURE Categories_Info 
	-- Add the parameters for the stored procedure here
	@CategoryName varchar(100) = 0, 
	@Descrip varchar(100) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @CategoryName, @Descrip
END
GO

ALTER TABLE Customer
ADD CONSTRAINT CHK_Customer CHECK (FirstName IS NOT NULL)

ALTER TABLE Customer
DROP CONSTRAINT CHK_Customer

ALTER TABLE Employees
ADD CONSTRAINT CHK_Employee CHECK (FirstName IS NOT NULL)

ALTER TABLE Employees
DROP CONSTRAINT CHK_Employee

ALTER TABLE Invoices 
ADD CONSTRAINT CHK_Invoice CHECK(InvoiceNum > 0)

ALTER TABLE Invoices 
DROP CONSTRAINT CHK_Invoice

ALTER TABLE ActiveOrderDetails
ADD CONSTRAINT CHK_ActiveOrderDetails CHECK(Status IS NOT NULL)

ALTER TABLE ActiveOrderDetails
DROP CONSTRAINT CHK_ActiveOrderDetails

ALTER TABLE Suppliers
ADD CONSTRAINT CHK_Suppliers CHECK(City IS NOT NULL)

ALTER TABLE Suppliers
DROP CONSTRAINT CHK_Suppliers

