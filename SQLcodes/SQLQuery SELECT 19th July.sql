
-- QUERYING TABLE WITH SELECT

-- Agenda:
    -- SELECT 
        -- All, without filter
        -- Specific columns
        -- Filtering based on some conditions (Where)
        -- Unique or distinct
        -- Sorting - order by
        -- Grouping - group by

SELECT *  FROM SalesLT.Customer

select CustomerID, FirstName
from SalesLT.Customer 

-- To know the data structure of DB
EXEC sp_help

EXEC sp_help 'SalesLT.Product'


select ProductID, Color
From SalesLT.Product

select Color from SalesLT.Product
select COlor from SalesLT.Product    -- The attribute names in a syntax is NOT case-sensitive
select COLOR from SalesLT.Product
select Colr from SalesLT.Product

-- Get data without duplicates - DISTINCT
SELECT DISTINCT color
FROM SalesLT.Product

-- Orderby Desc or Asc

SELECT DISTINCT color
FROM SalesLT.Product
ORDER BY Color ASC          -- Ascending order 

SELECT DISTINCT color
FROM SalesLT.Product
ORDER BY Color              -- By default, the order is ASC

SELECT DISTINCT color
FROM SalesLT.Product
ORDER BY Color DESC         -- DESC for descending order

-- Conditions

select name, ListPrice
from SalesLT.Product

SELECT TOP 10 Name   -- Filtering by value and the filter attribute is ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC

SELECT TOP 10 Name, ListPrice   -- Filtering by value and the filter attribute is ListPrice
FROM SalesLT.Product
ORDER BY ListPrice

SELECT TOP 10 Name, ListPrice   -- 
FROM SalesLT.Product
ORDER BY Weight


-- WHERE conditions --

select name, ListPrice
from SalesLT.Product
WHERE Color = 'whiTE'

SELECT Name, Color 
FROM SalesLT.Product
WHERE Color IN ('Red', 'White', 'Black')  -- OR statement.

select name, ListPrice
from SalesLT.Product
WHERE Color = 'White' OR Color = 'Red'

-- QUES - Use AND syntax with WHERE clause

SELECT ProductID, Name
FROM SalesLT.Product
WHERE Color = 'Black' AND Size = 58

SELECT ProductID, Name
FROM SalesLT.Product
WHERE Size = 'S'

SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Color = 'Red' AND ListPrice >= 1000

-- Ques. - Use NOT

SELECT ProductID, Name
FROM SalesLT.Product
WHERE NOT (Color = 'Red' AND Size = '58') -- Exclusing both argument

SELECT ProductID, Name
FROM SalesLT.Product
WHERE NOT Color = 'Red' AND Size = '58'  -- Excluding only the next/only one argument

SELECT Name, ListPrice, [Size]
FROM SalesLT.Product
WHERE Color = 'Black' AND NOT(Size = 'S' OR Size ='58')

-- Ques. - Use BETWEEN

SELECT ProductID, ListPrice
FROM SalesLT.Product
WHERE ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice                      -- Order By will go after Where By


-- LIKE for filtering
SELECT Name, ProductNumber
FROM SalesLT.Product
WHERE ProductNumber LIKE 'FR%'  -- Starting with FR

SELECT Name, ProductNumber
FROM SalesLT.Product
WHERE ProductNumber LIKE '%M'   -- Ending with M

SELECT Name, ProductNumber
from SalesLT.Product
WHERE ProductNumber LIKE '%M%'

SELECT ProductID, Color, Size 
FROM SalesLT.Product
WHERE Color NOT LIKE 'RED' AND Size = '58'  --  NOT, LIKE and AND

-- Joining two columns, without changing the original dataset
SELECT *
FROM SalesLT.Customer

SELECT FirstName, MiddleName, LastName
FROM SalesLT.Customer

-- Representing all names in a single column
SELECT FirstName + ' ' + MiddleName + ' ' + LastName as FullName -- creating as alias
FROM SalesLT.Customer

Select FirstName + ' ' + ISNULL(MiddleName +' ', '') + LastName
FROM SalesLT.Customer

SELECT Firstname + ' ' + MiddleName + ' ' + Lastname as FULLNAME     -- Creating as alias
From SalesLT.Customer
WHERE FirstName IS NOT NULL
AND MiddleName IS NOT NULL
AND Lastname IS NOT NULL

Select concat(FirstName, coalesce(' '+MiddleName+' ',' '), LastName) as FullName 
from SalesLT.Customer


-- Assignment

SELECT DISTINCT City, StateProvince
FROM SalesLT.Address


SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC


SELECT TOP 10 Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC

SELECT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY


SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1


SELECT ProductNumber, Name, Color 
FROM SalesLT.Product
WHERE Color IN ('Red', 'White', 'Black') 
    AND Size IN ('S', 'M')

-- Retrieve the product number, name, and list price of products whose product number begins 'BK-'
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK%'
