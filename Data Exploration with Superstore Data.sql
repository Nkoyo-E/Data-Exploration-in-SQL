
USE PortfolioProject2

SELECT * 
FROM INFORMATION_SCHEMA.TABLES

--Retrieving all data from existing table
SELECT *
FROM dbo.Superstoredata
ORDER BY 3,4

SELECT *
FROM dbo.coffee_chain$
ORDER BY 3,4

--Count of data
SELECT COUNT(*)
FROM dbo.Superstoredata

--Retrieving customers name that starts with letter 'H'
SELECT DISTINCT CustomerName, CustomerID
FROM dbo.Superstoredata
WHERE CustomerName LIKE 'h%'

--The maximum profit of superstore
SELECT MAX (Profit)
FROM dbo.Superstoredata

--States with minimum sales
SELECT DISTINCT MIN (Sales), State
from dbo.Superstoredata
GROUP BY State

--Fetching data of a customer with ID = KM-16720
SELECT *
FROM dbo.Superstoredata
WHERE CustomerID = 'KM-16720'

--	The top 20 ProductName, Sales, Region, CustomerName 
SELECT TOP 20 ProductName, Sales, Region, CustomerName
FROM dbo.Superstoredata

-- Total Sales
SELECT SUM (Sales)
FROM dbo.Superstoredata

-- CustomerID greater than 25
SELECT COUNT (CustomerID), CustomerName
FROM dbo.Superstoredata
GROUP BY CustomerName
HAVING COUNT (CustomerID) > 25


-- Maximum Sales where subcategory is 'Paper'
SELECT MAX (Sales), CustomerName
FROM dbo.Superstoredata
WHERE SubCategory = 'Paper'
GROUP BY CustomerName


--The ship modes available for Superstore
SELECT DISTINCT [ShipMode]
FROM dbo.Superstoredata


--Finding out how many days it takes to deliver a Product in a first class

SELECT MIN (a.NumberofDays), MAX(a.NumberofDays)
FROM (
SELECT DATEDIFF(DAY, OrderDate, ShipDate) AS NumberofDays, *
FROM dbo.Superstoredata
WHERE ShipMode = 'First Class' ) a


--The minimum and maximum number of days to deliver a Product using same day ship mode
SELECT MIN (a.NumberofDays), MAX(a.NumberofDays)
FROM (
SELECT DATEDIFF(DAY, OrderDate, ShipDate) AS NumberofDays, *
FROM dbo.Superstoredata
WHERE ShipMode = 'Same Day' ) a


--Customer with maximum orders
SELECT TOP 1 CustomerID, COUNT(OrderID) AS NoOfOrders
FROM dbo.Superstoredata
GROUP BY CustomerID
ORDER BY NoOfOrders desc




--Joining both tables by Profit
SELECT *
FROM dbo.Superstoredata AS S
INNER JOIN dbo.coffee_chain$ AS c
ON S.Profit = c.Profit

--Retrieving Product names from both tables
SELECT ProductName, Product
FROM dbo.Superstoredata AS S
RIGHT JOIN dbo.coffee_chain$ AS c
ON S.Sales = c.Sales

--the Sale involved in both tables
SELECT S.State, c.State
FROM dbo.Superstoredata AS S
 JOIN dbo.coffee_chain$ AS c
ON S.Sales = c.Sales
WHERE Sales = (SELECT MAX(Sales) FROM dbo.Superstoredata)
ORDER BY 2;