CREATE DATABASE A6

USE A6

SQL LANG /STATEMENT

DDL ->CREATE ,RENAME ,TRUNCATE ,ALTER,DROP
DML ->INSERT , UPDATE ,DELETE
DQL ->SELECT
DCL ->GRANT ,REVOKE
TCL ->ROLLBACK ,COMMIT ,SAVEPOINT

CREATE TABLE CUSTOMERS(
CUSTOMER_ID INT,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
EMAIL VARCHAR(50),
ADDRESS VARCHAR(50),
CITY VARCHAR(50),
STATE VARCHAR(50),
ZIP VARCHAR(10)
)


INSERT INTO CUSTOMERS VALUES
	  (10,'JEMMI','JORDAN','JEM@GMAIL.COM','2ND FLOOR GANDHI NAGAR','SANJOSE','KARNATAKA','33222'),
	  (20,'GAGANA','AVANTHIKA','GAGANA@GMAIL.COM','3ND FLOOR JAYA NAGAR','SHANTI NAGAR','KASHMIR','22222'),
	  (30,'JESSICA','VANYA','VANYA@GMAIL.COM','19TH BLOCK BOMMARI','ALLEPPY','TAMIL NADU','33333'),
	  (40,'JERUSHA','JERU','JERU@GMAIL.COM','4TH FLOOR','OOTY','DELHI','44444'),
	  (50,'GRACE','ZIPPORA','GRACE@GMAIL.COM','5TH FLOOR','SAN JOSE','UTTAR PRADESH','55555');



--1.Create a view named ‘customer_san_jose’ which comprises of only those customers who are from san jose

create view customer_san_jose
as
select * from customers where city='san jose'

select * from customer_san_jose

select * from customers


--2.Inside a transaction, update the first name of the customer to Francis, where the last name is Jordan

TCL -TRANSACTION CONTROL LANG
ROLLBACK
COMMIT
SAVE POINT


select * from customers


BEGIN TRANSACTION
UPDATE CUSTOMERS SET FIRST_NAME='FRANICS' WHERE LAST_NAME='JORDAN'



a.Rollback the transaction

ROLLBACK TRANSACTION

select * from customers

b.Set the first name of customer to Alex, where the last name is Jordan


BEGIN TRANSACTION
UPDATE CUSTOMERS SET FIRST_NAME='ALEX' WHERE LAST_NAME='JORDAN'

select * from customers

--3.Inside a try catch block, divide 100 with 0, print the default error message

BEGIN TRY
SELECT 100/1 AS MESSAGE
END TRY
BEGIN CATCH
SELECT 
ERROR_MESSAGE() AS ERR_MSG;
END CATCH