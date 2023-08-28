--1. Display the names of the highest paid programmers for each Language.
SELECT s.DEVELOPIN AS Language, p.PNAME AS Programmer, p.SALARY AS Salary
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON p.PROF1 = s.DEVELOPIN OR p.PROF2 = s.DEVELOPIN
WHERE p.SALARY = (SELECT MAX(SALARY) FROM PROGRAMMER p2 WHERE p2.PROF1 = s.DEVELOPIN OR p2.PROF2 = s.DEVELOPIN)
GROUP BY s.DEVELOPIN, p.PNAME, p.SALARY;

--2. Display the details of those who are drawing the same salary.
SELECT p1.*
FROM PROGRAMMER p1
JOIN PROGRAMMER p2 ON p1.SALARY = p2.SALARY AND p1.PNAME <> p2.PNAME
order by p1.SALARY desc


--3. Who are the programmers who joined on the same day?
select p1.PNAME from PROGRAMMER p1
join PROGRAMMER p2 on p1.DOJ = p2.DOJ and p1.PNAME <> p2.PNAME

--4. Who are the programmers who have the same Prof2?
select distinct p1.PNAME from PROGRAMMER p1
join PROGRAMMER p2 on p1.PROF2 = p2.PROF2 and p1.PNAME <> p2.PNAME

--5. How many packages were developed by the person who developed the cheapest package,
--where did he/she study?
select count(TITLE) as PkgDev
from SOFTWARE
where PNAME in (select PNAME
from SOFTWARE
where DCOST = (select min(DCOST) from SOFTWARE))

select INSTITUTE from STUDIES
where PNAME = (select PNAME
from SOFTWARE
where DCOST = (select min(DCOST) from SOFTWARE))
