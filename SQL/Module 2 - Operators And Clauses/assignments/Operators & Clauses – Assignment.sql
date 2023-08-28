--1) What is the Highest Number of copies sold by a Package?

select MAX(SOLD) as MaxCopiesSold
from SOFTWARE;

--2) Display lowest course Fee.

select min(COURSE_FEE) from studies

--3) How old is the Oldest Male Programmer.

select PNAME, DATEDIFF(YEAR,DOB, GETDATE()) as Age, DATEDIFF(YEAR, DOJ, GETDATE()) as Experience
from PROGRAMMER
order by Experience DESC

--4) What is the AVG age of Female Programmers?

select AVG(DATEDIFF(YEAR,DOB, GETDATE())) as avg_Age 
from PROGRAMMER
where GENDER = 'F'

--5) Calculate the Experience in Years for each Programmer and Display with
--their names in Descending order.

select PNAME, DATEDIFF(YEAR, DOJ, GETDATE()) as Experience
from PROGRAMMER 
order by Experience DESC

--6) How many programmers have done the PGDCA Course?

select count(*) as num_programmers from studies
where COURSE = 'PGDCA'

--7) How much revenue has been earned thru sales of Packages Developed in C.

select SUM(SCOST*SOLD) as RevenueFromC from SOFTWARE
where DEVELOPIN = 'C'

--8) How many Programmers Studied at Sabhari?

select count(*) from studies
where INSTITUTE = 'SABHARI'

--9) How many Packages Developed in DBASE?

select count(*) from SOFTWARE
where DEVELOPIN = 'DBASE'

--10) How many programmers studied in Pragathi?

select count(*) from studies
where INSTITUTE = 'PRAGATHI'

--11) How many Programmers Paid 5000 to 10000 for their course?
select count(*) as NUM_PROGRAMMERS from studies
where COURSE_FEE between 5000 AND 10000

--12) How many Programmers know either COBOL or PASCAL?
select count(*) from PROGRAMMER
where PROF1 = 'COBOL' or PROF1 = 'PASCAL' or PROF2 = 'COBOL' or PROF2 = 'PASCAL'

--13) How many Female Programmers are there?
select count(*) from PROGRAMMER
where GENDER = 'F'

--14) What is the AVG Salary?
select avg(SALARY) as avg_salary from PROGRAMMER

--15) How many people draw salary 2000 to 4000?

select count(*) from PROGRAMMER
where SALARY between 2000 and 4000

--16) Display the sales cost of the packages Developed by each Programmer Language wise
select PNAME, DEVELOPIN, sum(SCOST) as SumOfscost from SOFTWARE
group by PNAME, DEVELOPIN

--17) Display the details of the software developed by the male students of Sabhari.
select s.* from SOFTWARE s
join PROGRAMMER p on s.PNAME = p.PNAME
join studies st on p.PNAME = st.PNAME
where p.GENDER = 'M' and st.INSTITUTE = 'SABHARI'

--18) Who is the oldest Female Programmer who joined in 1992?

select PNAME, DOJ, GENDER, DATEDIFF(year, DOB, getdate()) as age from PROGRAMMER
where GENDER = 'F' and year(DOJ) = '1992'
order by age desc

--19) Who is the youngest male Programmer born in 1965?
select PNAME, DOB, GENDER, DATEDIFF(year, DOB, getdate()) as age from PROGRAMMER
where GENDER = 'M' and year(DOB) = '1965'
order by age asc

--20) Which Package has the lowest selling cost?
select top 1 TITLE, SCOST from SOFTWARE
order by SCOST 

--21) Which Female Programmer earning more than 3000 does not know C, C++,
--ORACLE or DBASE?

select * from PROGRAMMER
where GENDER = 'F' and SALARY > 3000 and PROF1 not in ('C','C++','ORACLE','DBASE') 
and PROF2 not in ('C','C++','ORACLE','DBASE')

--22) Who is the Youngest Programmer knowing DBASE?
select top 1 PNAME, DATEDIFF(year,DOB,getdate()) as age,PROF1,PROF2 from PROGRAMMER 
where PROF1 = 'DBASE' or PROF2 = 'DBASE'
order by age 

---23) Which Language is known by only one Programmer?
SELECT PROF1 AS Language, COUNT(*) AS NumProgrammers
FROM PROGRAMMER
GROUP BY PROF1
HAVING COUNT(*) = 1

UNION

SELECT PROF2 AS Language, COUNT(*) AS NumProgrammers
FROM PROGRAMMER
GROUP BY PROF2
HAVING COUNT(*) = 1;

--24) Who is the most experienced male programmer knowing PASCAL?
select top 1 PNAME, DATEDIFF(year, DOJ, GETDATE()) as experience, GENDER from PROGRAMMER
where GENDER = 'M' and PROF1 = 'PASCAL' or PROF2 = 'PASCAL'
order by experience desc

--25) Who is the least experienced Programmer?
select top 1 PNAME, DATEDIFF(year, DOJ, GETDATE()) as experience
from PROGRAMMER
order by experience

--26) Display the Number of Packages in Each Language for which Development
--Cost is less than 1000.

select DEVELOPIN, count(TITLE) as NoOfPKG from SOFTWARE
where DCOST < 1000
group by DEVELOPIN

--27) Display Highest, Lowest and Average Salaries for those earning more than 2000.

select max(SALARY) as Highest, min(SALARY) as Lowest, avg(SALARY) as Average
from PROGRAMMER
where SALARY > 2000