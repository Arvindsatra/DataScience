--1. what is the cost of the costliest software development in basic?
select SCOST, DCOST from SOFTWARE
where DEVELOPIN = 'BASIC' 

--2. display details of packages whose sales crossed the 2000 mark.
select *, (SCOST * SOLD) as Sales from SOFTWARE
where (SCOST * SOLD) > 2000
order by Sales 

--3. Who are the Programmers who celebrate their Birthdays 
--during the Current Month?
select PNAME from PROGRAMMER
where MONTH(DOB) = month(getdate())

--4. Display the Cost of Package Developed By each Programmer.
select p.PNAME, s.DCOST from PROGRAMMER p
inner join SOFTWARE s on p.PNAME = s.PNAME 


--5. Display the sales values of the Packages Developed by each Programmer.
select p.PNAME, (s.SCOST*s.SOLD) as SALES from PROGRAMMER p
inner join SOFTWARE s on p.PNAME = s.PNAME 

--6. Display the Number of Packages sold by Each Programmer.
select p.PNAME, count(s.TITLE) as NumOfPkg from SOFTWARE s
inner join PROGRAMMER p on s.PNAME = p.PNAME
where SOLD <> '0'
group by p.PNAME

--7. Display each programmer’s name, costliest and cheapest 
--Packages Developed by him or her.
select p.PNAME,s.TITLE, max(s.DCOST) as costliest, min(s.DCOST) as cheapest from SOFTWARE s 
inner join PROGRAMMER p on s.PNAME = p.PNAME
group by p.PNAME, s.TITLE
order by p.PNAME

--8. Display each institute name with the number of Courses,
--Average Cost per Course.
select INSTITUTE, count(COURSE) as NumOfCourses, AVG(COURSE_FEE) as avg_fee
from STUDIES
group by INSTITUTE

--9. Display each institute Name with Number of Students.
select INSTITUTE, count(PNAME) as NumOfStudents from STUDIES
group by INSTITUTE

--10. List the programmers (form the software table) and the 
--institutes they studied.
select distinct s.PNAME, st.INSTITUTE from SOFTWARE s
join STUDIES st on s.PNAME=st.PNAME
order by s.PNAME

--11. How many packages were developed by students, who studied
--in institute that charge the lowest course fee?

select st.PNAME, count(s.TITLE) as NumOfPkg from STUDIES st
inner join SOFTWARE s on st.PNAME = s.PNAME
where INSTITUTE = (select top 1 INSTITUTE from STUDIES
					group by INSTITUTE
					order by min(COURSE_FEE))
group by st.PNAME

--12. What is the AVG salary for those whose software sales is more than 50,000/-.
select distinct s.PNAME, p.SALARY from SOFTWARE s
inner join PROGRAMMER p on s.PNAME = p.PNAME
where (SCOST*SOLD) > 50000
order by p.SALARY

--13. Which language listed in prof1, prof2 has not been used to develop any package.
select distinct p.PROF1 as unused_language from PROGRAMMER p 
where p.PROF1 not in (select distinct s.DEVELOPIN from SOFTWARE s)
union
select distinct p.PROF2 from PROGRAMMER p
where p.PROF2 not in ( select distinct s.DEVELOPIN from SOFTWARE s)

--14. Display the total sales value of the software, institute wise.
select st.INSTITUTE, sum(SCOST*SOLD) as SaleValue from SOFTWARE s
join STUDIES st on s.PNAME = st.PNAME
group by st.INSTITUTE

--15. Display the details of the Software Developed in C By female programmers of
--Pragathi.
select * from STUDIES st
join PROGRAMMER p on st.PNAME = p.PNAME
join SOFTWARE s on p.PNAME = s.PNAME
where st.INSTITUTE = 'PRAGATHI' and p.GENDER = 'F' and s.DEVELOPIN = 'C'

--16. Display the details of the packages developed in Pascal by the Female Programmers.
select s.* from SOFTWARE s 
join PROGRAMMER p on s.PNAME = p.PNAME
where s.DEVELOPIN = 'PASCAL' and p.GENDER = 'F'

--17. Which language has been stated as the proficiency by most of the 
--Programmers?
select top 1 PROF, count(*) as NoOfCount
from (
select PROF1 as PROF from PROGRAMMER
union all
select PROF2 as PROF from PROGRAMMER
) as COMB
group by PROF
order by NoOfCount desc

--18. Who is the Author of the Costliest Package?
select top 1 PNAME,TITLE, max(SCOST*SOLD) as COST from SOFTWARE
group by PNAME, TITLE
order by COST desc

--19. Which package has the Highest Development cost?
select top 1 TITLE, max(DCOST) as Dev_Cost from SOFTWARE
group by TITLE
order by Dev_Cost desc

--20. Who is the Highest Paid Female COBOL Programmer?
select top 1 p.PNAME, s.DEVELOPIN, max(p.SALARY) as PAID
from PROGRAMMER p 
join SOFTWARE s on p.PNAME = s.PNAME
where p.GENDER = 'F' and s.DEVELOPIN = 'COBOL'
group by p.PNAME, s.DEVELOPIN
order by PAID desc

--21. Display the Name of Programmers and Their Packages.
select p.PNAME, s.TITLE from SOFTWARE s 
join PROGRAMMER p on s.PNAME = p.PNAME


--22. Display the Number of Packages in Each Language Except C and C++.
select DEVELOPIN, count(TITLE) NoOfPkg from SOFTWARE
where DEVELOPIN <> 'C' and DEVELOPIN <>'C++'
group by DEVELOPIN

--23. Display AVG Difference between SCOST, DCOST for Each Package.
select TITLE, AVG(SCOST-DCOST) as AvgDiff from SOFTWARE
group by TITLE

--24. Display the total SCOST, DCOST and amount to Be Recovered 
--for each Programmer for Those Whose Cost has not yet been Recovered.
select p.PNAME,sum(s.DCOST) as TotalSCOST, sum(s.SCOST) as TotalDCOST,
(sum(s.DCOST)-sum(s.SCOST)) as AmtToBeRecovered 
from SOFTWARE s
join PROGRAMMER p on s.PNAME = p.PNAME
group by p.PNAME
order by AmtToBeRecovered desc

--25. Who is the Highest Paid C Programmers?
select top 1 PNAME, max(SALARY) MaxSalary from PROGRAMMER 
where PROF1 = 'C' or PROF2 = 'C'
group by PNAME
order by MaxSalary desc

--26. Who is the Highest Paid Female COBOL Programmer?
select top 1 PNAME, max(SALARY) MaxSalary from PROGRAMMER 
where PROF1 = 'COBOL' or PROF2 = 'COBOL' and GENDER = 'F'
group by PNAME
order by MaxSalary desc
