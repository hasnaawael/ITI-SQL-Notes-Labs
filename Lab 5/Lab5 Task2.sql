USE AdventureWorks2012

/* 1.	Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema) 
to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’ */ 
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE OrderDate between '7/28/2002' and '7/29/2014';

/* 2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only) */
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;

/* 3.	Display ProductID, Name if its weight is unknown */
SELECT ProductID, Name
FROM Production.Product
WHERE Weight is null;

/* 4.	 Display all Products with a Silver, Black, or Red Color */
SELECT Name, Color
FROM Production.Product
WHERE Color in ('Silver', 'Black', 'Red');

/* 5.	 Display any Product with a Name starting with the letter B */ 
SELECT Name
FROM Production.Product
WHERE name like 'B%';

/* 6.	Run the following Query */
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

-- Then write a query that displays any Product description with underscore value in its description.
SELECT Description
FROM Production.ProductDescription 
WHERE Description LIKE '%[_]%' ;

/* 7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014' */ 
SELECT COUNT(TotalDue)
FROM Sales.SalesOrderHeader
WHERE OrderDate between '2001/01/07' and '2014/07/31'
GROUP BY  OrderDate;

/* 8.	 Display the Employees HireDate (note no repeated values are allowed) */
SELECT distinct HireDate
FROM HumanResources.Employee
ORDER BY HireDate desc;

/* 9.	 Calculate the average of the unique ListPrices in the Product table */ 
SELECT AVG(distinct ListPrice)
FROM Production.Product;

/* 10.	Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the following format
"The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value) */ 
SELECT 'The '+  Name  +' is only! 'AS ListPrice
FROM Production.Product
WHERE ListPrice in (100, 120);

/* 11.	a)	 Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
Note: Check your database to see the new table and how many rows in it?
b)	Try the previous query but without transferring the data? */ 

-- with data -- 
SELECT rowguid, Name, SalesPersonID, Demographics into [store_archive]
FROM Sales.Store;

SELECT * 
FROM store_archive; 

-- only structure of table -- 
select rowguid, Name, SalesPersonID, Demographics into [store_archive2]
from Sales.Store
where 1 = 2;

/* 12.	Using union statement, retrieve the today’s date in different styles using convert or format funtion. */

select convert(varchar(20),getdate())
union
select cast(getdate() as varchar(20))
union
select convert(varchar(20),getdate(),102)
union
select convert(varchar(20),getdate(),103)
union
select convert(varchar(20),getdate(),104)
union
select convert(varchar(20),getdate(),105)

select format(getdate(),'dd-MM-yyyy')
union
select format(getdate(),'dddd MMMM yyyy')
union
select format(getdate(),'ddd MMM yy')
union
select format(getdate(),'dddd')
union
select format(getdate(),'MMMM')
union
select format(getdate(),'hh:mm:ss')
union
select format(getdate(),'HH')
union
select format(getdate(),'hh tt')
union
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')
union
select format(getdate(),'dd')

select day(getdate())

select eomonth(getdate())

select format(eomonth(getdate()),'dddd')
union
select format(eomonth(getdate()),'dd')

-----------------------------------------------------------------------------------------------
select @@VERSION


select @@SERVERNAME