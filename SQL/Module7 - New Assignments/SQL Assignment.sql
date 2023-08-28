CREATE TABLE Employee (
Employee_id INT,
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Salary INT,
Join_Date DATE,
Department VARCHAR(50)
);

insert into Employee values
(1, 'Anika', 'Arora', 100000, '2020-02-14', 'HR'),
(2, 'Veena', 'Verma', 80000, '2011-06-15', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2020-02-16', 'HR'),
(4, 'Sushanth', 'Singh', 500000, '2020-02-17', 'Admin'),
(5, 'Bhupal', 'Bhati', 500000, '2011-06-18', 'Admin'),
(6, 'Dheeraj', 'Diwan', 200000, '2011-06-19', 'Account'),
(7, 'Karan', 'Kumar', 75000, '2020-01-14', 'Account'),
(8, 'Chandrika', 'Chauhan', 90000, '2011-04-15', 'Admin');


select * from Employee

create table Employee_Bonus (
Employee_id INT,
Bonus_Amount int,
Bonus_Date date)

insert into Employee_Bonus values
(1,5000,'2020-02-16'),
(2,3000,'2011-06-16'),
(3,4000,'2020-02-16'),
(1,4500,'2020-02-16'),
(2,3500,'2011-06-16')

select * from Employee_Bonus

create table Employee_Title
(Employee_id int,
Employee_Title varchar(50),
Affectvie_Date date)

insert into Employee_Title values 
(1,'Manager','2016-02-20'),
(2,'Executive','2016-06-11'),
(8,'Executive','2016-06-11'),
(5,'Manager','2016-06-11'),
(4,'Asst Manager','2016-06-11'),
(7,'Executive','2016-06-11'),
(6,'Lead','2016-06-11'),
(3,'Lead','2016-06-11')


select * from Employee_Title


--1 Display the “FIRST_NAME” from Employee
--table using the alias name as Employee_name.

select First_Name as Employee_name
from Employee

--2 Display “LAST_NAME” from Employee table in upper case.
select upper(Last_Name) as Employee_name
from Employee

--3 Display unique values of DEPARTMENT from EMPLOYEE table.
select distinct Department
from Employee

--4 Display the first three characters of LAST_NAME from EMPLOYEE table.
select substring(Last_Name, 1, 3) as FirstThreeChar
from Employee

--5 Display the unique values of DEPARTMENT from EMPLOYEE table 
--and prints its length.
select distinct len(Department) as LengthOfUniqueValues
from Employee

--6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a 
--single column AS FULL_NAME. a space char should separate them.
select concat( First_Name, ' ', Last_Name) as full_Name
from Employee

--7 DISPLAY all EMPLOYEE details from the employee table
--order by FIRST_NAME Ascending.
select * from Employee
order by First_Name 

--8.Display all EMPLOYEE details order by FIRST_NAME 
--Ascending and DEPARTMENT Descending.
select * from Employee
order by First_Name asc, Department desc

--9 Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” 
--from EMPLOYEE table. 
select * from Employee
where First_Name = 'Veena' or First_Name = 'Karan'

--10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”. 
select * from Employee
where Department = 'Admin'

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’. 
select * from Employee
where First_Name like '%V%'

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
select * from Employee
where Salary between 100000 and 500000

--13 Display details of the employees who have joined in Feb-2020. 
select * from Employee
where Join_Date like '%2020-02%'

--14 Display employee names with salaries >= 50000 and <= 100000.
select * from Employee
where Salary >= 50000 and Salary <=100000  

--15 Display the number of Employees for each department in the descenting order.
select Department, Count(*) as NoOfEmployees from Employee
group by Department
order by Count(*) desc

--16 DISPLAY details of the EMPLOYEES who are also Managers. 
select e.*
from Employee e
join Employee_Title et
on e.Employee_id = et.Employee_id
where et.Employee_title = 'Manager'

--17 DISPLAY duplicate records having matching data in some fields of a table.
select *
from Employee where Employee_id 
in (select Employee_id from Employee
group by Employee_id
Having count(*) >1)

--18 Display only odd rows from a table. 
SELECT *
FROM Employee
WHERE Employee_id % 2 <> 0;


--19 Clone a new table from EMPLOYEE table. 
SELECT *
INTO Employee_Clone
FROM Employee;

select * from Employee_Clone

--20 DISPLAY the TOP 2 highest salary from a table. 
SELECT TOP 2 Salary
FROM Employee
GROUP BY Salary
ORDER BY Salary DESC

--21. DISPLAY the list of employees with the same salary.
select * from Employee e1
join Employee e2 on e1.Salary = e2.Salary and e1.Employee_id <> e2.Employee_id

--22 Display the second highest salary from a table. 
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)

--23 Display the first 50% records from a table.
select top 50 percent * from Employee

--24.Display the departments that have less than 4 people in it.
select Department, count(*) as NoOfEmployees from Employee
group by Department
Having count(*)<4
order by count(*)

--25.Display all departments along with the number of people in there.
select Department, Count(*) as NoOfEmployees from Employee
group by Department
order by count(*)

--26 Display the name of employees having the highest salary in each department.
select Department, Max(Salary) as HighstSalary from Employee
group by Department
order by Max(Salary)

--27 Display the names of employees who earn the highest salary.
SELECT e1.First_Name, e1.Last_Name, e1.Department, e1.Salary
FROM Employee e1
WHERE e1.Salary = (
    SELECT MAX(e2.Salary)
    FROM Employee e2
    WHERE e2.Department = e1.Department
);

--28 Diplay the average salaries for each department 
SELECT Department, AVG(Salary) as AvgSalary
FROM Employee
GROUP BY Department

--29 display the name of the employee who has got maximum bonus 
SELECT e.First_Name, e.Last_Name
FROM Employee e
WHERE e.Employee_id = (
    SELECT TOP 1 b.Employee_id
    FROM Employee_Bonus b
    GROUP BY b.Employee_id
    ORDER BY SUM(b.Bonus_Amount) DESC
)

--30 Display the first name and title of all the employees
select e.First_Name, et.Employee_Title from Employee e
join Employee_Title et on e.Employee_id = et.Employee_id


