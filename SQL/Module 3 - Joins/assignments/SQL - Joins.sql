--1. How many Programmers Don’t know PASCAL and C

select count(*) as num_prg
from PROGRAMMER
where PROF1 not like 'PASCAL' and PROF1 not like 'C'
and PROF2 not like 'PASCAL' and PROF2 not like 'C'

--2. Display the details of those who don’t know Clipper, COBOL or PASCAL.

select * from PROGRAMMER
where PROF1 not like 'PASCAL' and PROF1 not like 'COBOL' and PROF1 not like 'CLIPPER'
and PROF2 not like 'PASCAL' and PROF2 not like 'COBOL'and PROF2 not like 'CLIPPER'

--3. Display each language name with AVG Development Cost, AVG Selling Cost 
--and AVG Price per Copy.

select DEVELOPIN, avg(DCOST) as AVG_Dev_Cost, avg(SCOST*SOLD) as AVG_selling_Cost, 
avg(SCOST) as AVG_pri_Cost
from SOFTWARE
group by DEVELOPIN

--4. List the programmer names (from the programmer table) and No. Of Packages each 
--has developed.

select p.PNAME, count(s.TITLE) as NumOfPkg from PROGRAMMER as p
left join SOFTWARE as s
on p.PNAME = s.PNAME
group by p.PNAME

--5. List each PROFIT with the number of Programmers having that PROF and 
--the number of the packages in that PROF.

select pft.pft, COUNT(distinct p.PNAME) as NumOfPrg,
count(s.TITLE) as NumOfPck
from (select (SCOST*SOLD)-DCOST as pft from SOFTWARE) as pft
left join SOFTWARE as s on pft.pft = (SCOST*SOLD)-DCOST
left join PROGRAMMER as p on (p.PROF1 = s.TITLE or p.PROF2 = s.TITLE)
group by pft.pft

--6. How many packages are developed by the most experienced programmer form BDPS.
SELECT TOP 1 COUNT(*) AS package_count
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
INNER JOIN STUDIES st ON p.PNAME = st.PNAME
WHERE st.INSTITUTE = 'BDPS'
GROUP BY p.DOJ
ORDER BY DATEDIFF(YEAR, p.DOJ, GETDATE()) DESC

--7. How many packages were developed by the female programmers earning more than 
--the highest paid male programmer?

SELECT COUNT(*) AS package_count
FROM (
  SELECT TOP 1 p.PNAME
  FROM PROGRAMMER p
  WHERE p.GENDER = 'F' AND p.SALARY > (
  SELECT MAX(p2.SALARY) FROM PROGRAMMER p2 WHERE p2.GENDER = 'M')
  ORDER BY p.SALARY DESC
) AS female_programmer
JOIN SOFTWARE s ON female_programmer.PNAME = s.PNAME;


--8. How much does the person who developed the highest selling package earn 
--and what course did HE/SHE undergo.
SELECT p.PNAME, p.SALARY, s.TITLE, st.COURSE 
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
INNER JOIN STUDIES st ON p.PNAME = st.PNAME
WHERE s.SCOST * s.SOLD = (SELECT TOP 1 SCOST * SOLD FROM SOFTWARE ORDER BY SCOST * SOLD DESC)

--9. In which institute did the person who developed the costliest package study?
select st.INSTITUTE from SOFTWARE s
inner join STUDIES as st on s.PNAME = st.PNAME
where DCOST = (select top 1 DCOST from SOFTWARE order by DCOST desc)

--10. Display the names of the programmers who have not developed any packages.

select PNAME from PROGRAMMER
where PNAME not in (select PNAME from SOFTWARE)

--11. Display the details of the software that has developed in the 
--language which is neither the first nor the second proficiency
select * from SOFTWARE
where DEVELOPIN not in (select PROF1 from PROGRAMMER union select PROF2 from PROGRAMMER)

--12. Display the details of the software Developed by the male 
--programmers Born before 1965 and female programmers born after 1975
SELECT *
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
WHERE (p.GENDER = 'M' AND YEAR(p.DOB) < 1965)
   and (p.GENDER = 'F' AND YEAR(p.DOB) > 1975)


--13. Display the number of packages, No. of Copies Sold and
--sales value of each programmer institute wise.

select st.INSTITUTE,
	sum(s.SCOST * S.SOLD) as Sales,
	SUM(s.SOLD) as CopiesSold,
	count(s.TITLE) as NumPackages
from SOFTWARE s
inner join PROGRAMMER p on s.PNAME = p.PNAME
inner join STUDIES st on p.PNAME = st.PNAME
group by st.INSTITUTE

--14. Display the details of the Software Developed by the 
--Male Programmers Earning More than 3000

select s.*, p.SALARY from SOFTWARE s
inner join PROGRAMMER p on s.PNAME = p.PNAME
where p.GENDER = 'M' and p.SALARY > 3000

--15. Who are the Female Programmers earning more than the Highest Paid male?
select PNAME from PROGRAMMER 
where GENDER = 'F' 
and SALARY > (select max(salary) from PROGRAMMER where GENDER = 'M')

--16. Who are the male programmers earning below the AVG 
--salary of Female Programmers?
select * from PROGRAMMER
where GENDER = 'M' and SALARY<(select AVG(SALARY) from PROGRAMMER where GENDER = 'F')

--17. Display the language used by each programmer to develop the
--Highest Selling and Lowest-selling package.
select PNAME, DEVELOPIN from SOFTWARE
where (SCOST*SOLD)= (select max(SCOST*SOLD) from SOFTWARE)
	or (SCOST*SOLD) = (select min(SCOST*SOLD) from SOFTWARE)

--18. Display the names of the packages, which have sold 
--less than the AVG number of copies.

select TITLE from SOFTWARE
where SOLD < (select AVG(SOLD) from SOFTWARE)

--19. Which is the costliest package developed in PASCAL.
select top 1 TITLE from SOFTWARE
where DEVELOPIN = 'PASCAL'
order by DCOST desc

--20. How many copies of the package that has the least
--difference between development and selling cost were sold.

select SOLD from SOFTWARE
where (DCOST - SCOST) = (select min(DCOST - SCOST) from SOFTWARE)

--21. Which language has been used to develop the package, 
--which has the highest sales amount?

select DEVELOPIN from SOFTWARE
where (SCOST*SOLD) = (select max(SCOST*SOLD) from SOFTWARE)

--22. Who Developed the Package that has sold the least number of copies?
select PNAME from SOFTWARE
where SOLD = (select min(sold) from SOFTWARE)

--23. Display the names of the courses whose fees are within
--1000 (+ or -) of the Average Fee

select COURSE from STUDIES
where COURSE_FEE <= (select (avg(COURSE_FEE)+1000) from STUDIES)
or COURSE_FEE >= (select (avg(COURSE_FEE)-1000) from STUDIES)

--24. Display the name of the Institute and Course, which 
--has below AVG course fee.

select INSTITUTE, COURSE from STUDIES
where COURSE_FEE < (select avg(COURSE_FEE) from STUDIES)

--25. Which Institute conducts costliest course.

select INSTITUTE from STUDIES 
where COURSE_FEE = (select max(COURSE_FEE) from STUDIES)

--26. What is the Costliest course?
select max(COURSE_FEE) as Costliest_course from STUDIES