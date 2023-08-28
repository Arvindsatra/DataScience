CREATE DATABASE A4

USE A4

1.Use the inbuilt functions and find the minimum, maximum and average amount from the orders table


CREATE TABLE ORDERS(ORDER_ID INT,ORDER_DATE DATE,AMOUNT INT, CUSTOMER_ID INT);

INSERT INTO ORDERS VALUES(3,'2020-10-01',9000,20),
						(110,'2020-10-01',9000,10),
						(111,'2020-10-02',8000,2),
						(112,'2020-10-03',7000,3),
						(113,'2020-10-04',6000,4),
						(114,'2020-10-05',5000,5);

SELECT * FROM ORDERS

FUNCTIONS

IN-BUILT -> AGG FUN -> MIN , MAX ,AVG ,COUNT ,SUM

USER DEFINED FUNC

SELECT MAX(AMOUNT) AS MAX_AMOUNT , MIN(AMOUNT) AS MIN_AMOUNT , AVG(AMOUNT) AS AVG_AMOUNT FROM ORDERS



2.Create a user-defined function, which will multiply the given number with 10


CREATE FUNCTION MULTIPLY(@NUM INT)
RETURNS INT
AS BEGIN
RETURN(@NUM*10)
END


SELECT dbo.multiply(10) as output


3.Use the case statement to check if 100 is less than 200, greater than 200 or equal to 2oo and print the corresponding value

case statement


select 
case 
when 100<200 then 'smaller'
when 100>200 then 'greater'
else 'equal'
end
