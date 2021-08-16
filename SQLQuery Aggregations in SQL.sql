-- UNION, INTERSECT and EXCEPT

-- The UNION Operator
-- Used to combine the result-set of two or more SELECT statements.
    -- Every SELECT statement within UNION must have the same number of columns.
    -- The columns must have similar data types.
    -- The columns in every SELECT statement must also be in the same order.

-- TableA = 1, 2, 3
-- TableB = 3, 4, 5
-- TableA UNION TableB = 1, 2, 3, 4, 5
-- Table TableA UNION ALL TableB = 1,2,3,3,4,5

-- UNION
    -- UNION -> Excludes duplicates while combining the result
    -- UNION ALL -> Includes duplicates

SELECT CustomerID FROM SalesLT.Customer
UNION
SELECT CustomerID FROM SalesLT.SalesOrderHeader

-- Similar to
SELECT CustomerID FROM SalesLT.Customer
UNION
SELECT DISTINCT CustomerID FROM SalesLT.SalesOrderHeader -- DISTINCT is not required with UNION

-- UNION ALL
SELECT CustomerID FROM SalesLT.Customer
UNION ALL
SELECT CustomerID FROM SalesLT.SalesOrderHeader

SELECT CustomerID FROM SalesLT.Customer
UNION ALL
SELECT DISTINCT CustomerID FROM SalesLT.SalesOrderHeader  
-- DISTINCT does not work on this particular dataset
-- The common 32 values (INNER JOIN) are already unique.

SELECT CustomerID FROM SalesLT.SalesOrderHeader


-- ORDER BY with UNION
SELECT CustomerID FROM SalesLT.Customer
UNION ALL
SELECT CustomerID FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID DESC

-- The attribute in the aggregates such as ORDER BY, GROUP BY, INTERSECT, EXCEPT and JOIN must be in the SELECT statement.

-- WHERE, UNION and ORDER BY

select CustomerID from SalesLT.Customer
WHERE CustomerID = 29982
UNION ALL                                       -- This will have duplicates.
select CustomerID from SalesLT.SalesOrderHeader
WHERE CustomerID = 29982
ORDER BY CustomerID

select CustomerID from SalesLT.Customer
WHERE CustomerID = 29982
UNION                                    -- This will not have duplicates.
select CustomerID from SalesLT.SalesOrderHeader
WHERE CustomerID = 29982
ORDER BY CustomerID


select CustomerID from SalesLT.Customer
WHERE CustomerID = 29980
UNION ALL                                       -- This will have duplicates.
select CustomerID from SalesLT.SalesOrderHeader
WHERE CustomerID = 29982
ORDER BY CustomerID


-- EXCEPT function
-- Returns distinct rows from the 1st/left query that are not in the output by the right/2nd query.
-- LEFT EXCLUDE JOIN
-- Ref: https://www.sqlshack.com/wp-content/uploads/2018/09/Circle2.png

SELECT CustomerID FROM SalesLT.Customer
EXCEPT
SELECT CustomerID FROM SalesLT.SalesOrderHeader   -- 815 rows


SELECT CustomerID FROM SalesLT.Customer
EXCEPT
SELECT CustomerID FROM SalesLT.SalesOrderHeader
WHERE CustomerID = 29982                           -- 846 rows


SELECT CustomerID FROM SalesLT.Customer
EXCEPT
SELECT CustomerID FROM SalesLT.SalesOrderHeader
WHERE CustomerID = 29982 
ORDER BY CustomerID


-- INTERSECT

-- It returns distinct rows that are present in both left and right queries.

-- QUES: Show the customer ID available in both tables

SELECT CustomerID FROM SalesLT.Customer
INTERSECT
SELECT CustomerID FROM SalesLT.SalesOrderHeader

SELECT CustomerID FROM SalesLT.Customer
INTERSECT
SELECT CustomerID FROM SalesLT.SalesOrderHeader
WHERE CustomerID = 29982 


-- Subqueries equivalent to INTERSECT and EXCEPT

SELECT CustomerID FROM SalesLT.Customer
WHERE NOT CustomerID
IN (SELECT CustomerID FROM SalesLT.SalesOrderHeader)

-- the above code is similar to
SELECT CustomerID FROM SalesLT.Customer
EXCEPT
SELECT CustomerID FROM SalesLT.SalesOrderHeader


-- Subquery for INTERSECT
SELECT CustomerID FROM SalesLT.Customer
WHERE CustomerID
IN (SELECT CustomerID FROM SalesLT.SalesOrderHeader)

-- The above code is similar to
SELECT CustomerID FROM SalesLT.Customer
INTERSECT
SELECT CustomerID FROM SalesLT.SalesOrderHeader



-- Table Values Functions

SELECT * FROM dbo.ufnGetCustomerInformation(29982)

SELECT * FROM dbo.ufnGetAllCategories()

SELECT * FROM dbo.ufnGetCustomerFirstName(29982)




-- CROSS APPLY
-- To join table with values function

SELECT p.ProductID, p.ProductCategoryID, pi.ProductCategoryID, pi.ParentProductCategoryName, pi.ParentProductCategoryName
From SalesLT.Product as p
CROSS APPLY ufnGetAllCategories() as pi
WHERE p.ProductCategoryID = 30 AND p.ProductCategoryID = pi.ProductCategoryID



---- group by, where, order by, top, count, sum, desc, asc

-- QUES: Number of orders by customers
SELECT customerid, COUNT(SalesOrderID) as NumOfOders
from SalesLT.SalesOrderHeader
GROUP BY CustomerID

-- Customers with 'amount payable'
SELECT CustomerID, sum(TotalDue) as AmtPayable
from SalesLT.SalesOrderHeader
GROUP by CustomerID

-- List the amount payable by highest to lowest

SELECT CustomerID, sum(TotalDue) as AmtPayable
from SalesLT.SalesOrderHeader
GROUP by CustomerID
ORDER BY AmtPayable DESC


-- HAVING 
SELECT CustomerID, sum(TotalDue) as AmtPayable
from SalesLT.SalesOrderHeader
GROUP by CustomerID
HAVING sum(TotalDue) > 2000
ORDER BY AmtPayable

















