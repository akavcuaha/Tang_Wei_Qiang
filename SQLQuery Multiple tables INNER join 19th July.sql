

-- Multiple tables joins in SQL


-- Requirements:
    -- Showing the attributes from different tables at a time.
    -- Mention the db table name and field- together.

SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer

SELECT SalesLT.Customer.CustomerID, SalesLT.Customer.FirstName, SalesLT.Customer.LastName
FROM SalesLT.Customer

SELECT c.CustomerID, c.FirstName, c.LastName
FROM SalesLT.Customer as c

-- INNER JOIN and table aliases

SELECT c.CustomerID, c.FirstName, s.SalesOrderNumber, s.TotalDue
FROM SalesLT.Customer as c,
    SalesLT.SalesOrderHeader as s


SELECT c.CustomerID, c.FirstName, s.SalesOrderNumber, s.TotalDue
FROM SalesLT.Customer as c
INNER JOIN SalesLT.SalesOrderHeader as s
ON c.CustomerID = s.CustomerID

SELECT COUNT(CustomerID) TotalCustomers
FROM SalesLT.Customer

SELECT count(c.CustomerID) as TotalCustomers
FROM SalesLT.Customer as c
INNER JOIN SalesLT.SalesOrderHeader as s
ON c.CustomerID = s.CustomerID


SELECT count(c.CustomerID) as TotalCustomers
FROM SalesLT.Customer as c
JOIN SalesLT.SalesOrderHeader as s
ON c.CustomerID = s.CustomerID

-- INNER JOIN on THREE Tables

SELECT c.customerID, soh.customerID, ca.AddressType
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON soh.CustomerID = c.CustomerID              -- Table 1 columns = Table 2 column
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID               -- Table 2 column = Table 3 column

SELECT c.customerID, soh.customerID, ca.AddressType
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON soh.CustomerID = c.CustomerID              -- Table 1 columns = Table 2 column
INNER JOIN SalesLT.CustomerAddress ca
ON ca.CustomerID = soh.CustomerID               -- Table 3 column = Table 2 column

-- LEFT JOIN
-- Customers without orders : They are in Customer table, but not in Sales table

SELECT c.customerID as SalesCustomers, soh.customerID as OrderCustomer 
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID              
 

-- LEFT Join + Group By
-- All customers with number of orders
SELECT c.customerID AS SalesCustomer, soh.customerID AS OrderCustomer, COUNT(soh.SalesOrderID) AS NoOfOrders
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON soh.CustomerID = c.CustomerID
GROUP BY soh.CustomerID, c.CustomerID

-- Customer wihtout orders
SELECT c.customerID AS SalesCustomer, soh.customerID AS OrderCustomer, COUNT(soh.SalesOrderID) AS NoOfOrders
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON soh.CustomerID = c.CustomerID
WHERE soh.CustomerID IS NULL
GROUP BY soh.CustomerID, c.CustomerID

SELECT c.customerID AS SalesCustomer, soh.customerID AS OrderCustomer, COUNT(soh.SalesOrderID) AS NoOfOrders
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON soh.CustomerID = c.CustomerID
WHERE soh.CustomerID IS NOT NULL
GROUP BY soh.CustomerID, c.CustomerID

-- LEFT Join + Group By
-- All customers with number of orders
SELECT c.CustomerID as SalesCustomer, soh.CustomerID as OrderCustomer, COUNT(soh.SalesOrderID) as #OfOrders
FROM SalesLT.Customer as c
LEFT JOIN SalesLT.SalesOrderHeader as soh
ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID, soh.CustomerID   -- aggregate function
ORDER BY soh.customerID DESC     --- Order By: The attribute must be called in the output as well.

-- RIGHT JOIN 
select p.ProductID as ProductTable, s.ProductID as SalesTable
from SalesLT.SalesOrderDetail as s
right join SalesLT.Product as p
on p.ProductID = s.ProductID

-- RIGHT JOIN
SELECT p.ProductID as ProductTable_p, sod.ProductID as SalesTable_sod
FROM SalesLT.SalesOrderDetail as sod
RIGHT JOIN SalesLT.Product as p
ON p.ProductID = sod.ProductID        -- check how many rows of data in both tables out of these 695 rows


SELECT * FROM SalesLT.SalesOrderDetail
ORDER BY ProductID ASC                -- 542 rows of data
Select * FROM SalesLT.Product         -- 295 rows of data



-- SELF Join: When you need to compare a value from another value from the same row.
select e.EmployeeName, m.EmployeeName
from SalesLT.Employee e
left join SalesLT.Employee m
on e.EmployeeID = m.EmployeeID

select * from SalesLT.Employee


select e.EmployeeName Employee, m.EmployeeName Manager
        from SalesLT.Employee e
        left join SalesLT.Employee m
        on e.ManagerID = m.EmployeeID



-- Subqueries: Queries within a query - nested queries
select customerid 
from SalesLT.Customer
where CustomerID IN (select customerid from SalesLT.SalesOrderHeader)

select customerid from SalesLT.SalesOrderHeader

-- MAX: the largest value
SELECT MAX(SalesOrderID) AS LastOrder
FROM SalesLT.SalesOrderHeader


SELECT SalesOrderID, ProductID, OrderQty, UnitPrice
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) AS LastOrder
FROM SalesLT.SalesOrderHeader)

select SUM(TotalDue) 
from SalesLT.SalesOrderHeader