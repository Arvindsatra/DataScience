--Get all the details from the person table including email ID, phone number,
--and phone number type

SELECT *
FROM Person.Person;


--Get the details of the sales header order made in May 2011:

SELECT *
FROM Sales.SalesOrderHeader
WHERE DATEPART(MONTH, OrderDate) = 5
    AND DATEPART(YEAR, OrderDate) = 2011;

--Get the details of the sales details order made in the month of May 2011:
SELECT *
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (
    SELECT SalesOrderID
    FROM Sales.SalesOrderHeader
    WHERE DATEPART(MONTH, OrderDate) = 5
        AND DATEPART(YEAR, OrderDate) = 2011
);

--Get the total sales made in May 2011:

SELECT SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE DATEPART(MONTH, OrderDate) = 5
    AND DATEPART(YEAR, OrderDate) = 2011;


--Get the total sales made in the year 2011 by month ordered by increasing sales:

SELECT DATEPART(MONTH, OrderDate) AS Month, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = 2011
GROUP BY DATEPART(MONTH, OrderDate)
ORDER BY TotalSales;


--Get the total sales made to the customer with FirstName='Gustavo' and LastName='Achong':
SELECT SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Person.Person
    WHERE FirstName = 'Gustavo'
        AND LastName = 'Achong'
);
