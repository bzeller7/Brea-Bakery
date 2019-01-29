SELECT *
FROM ActiveOrderDetails
WHERE LastName LIKE 'B%'

SELECT *
FROM
ActiveOrderCustomers
WHERE ProductType NOT LIKE 'C%'

SELECT CompanyName
FROM Suppliers
WHERE Country NOT LIKE 'USA'

SELECT LastName
FROM
ActiveOrderDetails
WHERE Status = 'Refunded'

SELECT CategoryName
FROM Categories
WHERE CategoryName NOT LIKE '%cake%'

SELECT CompanyName
FROM Suppliers
WHERE SupplierID = '22'

SELECT Title, FirstName, LastName
FROM Employees
ORDER BY Title

Select *
FROM Suppliers
WHERE City = 'Seattle'