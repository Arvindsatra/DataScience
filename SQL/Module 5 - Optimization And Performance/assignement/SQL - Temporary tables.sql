--1. Display the details of the software developed in DBASE by Male Programmers,
--who belong to the institute in which most number of Programmer

select top 1 s.PNAME, s.TITLE, s.DEVELOPIN, s.SCOST, s.DCOST, s.SOLD,
st.INSTITUTE, p.GENDER
from STUDIES st
join PROGRAMMER p on st.PNAME = p.PNAME
join SOFTWARE s on p.PNAME = s.PNAME
where p.GENDER = 'M' and s.DEVELOPIN = 'DBASE'
group by s.PNAME, st.INSTITUTE, p.GENDER, s.TITLE, s.DEVELOPIN, s.SCOST, s.DCOST, s.SOLD
order by count(st.PNAME) desc

--using temp table

SELECT st.INSTITUTE, COUNT(st.PNAME) AS NoOfProgrammers
INTO #temp
FROM STUDIES st
JOIN PROGRAMMER p ON st.PNAME = p.PNAME
WHERE p.GENDER = 'M'
GROUP BY st.INSTITUTE

select s.* from SOFTWARE s
join  PROGRAMMER p on s.PNAME = p.PNAME
join STUDIES st on p.PNAME = st.PNAME
join (select INSTITUTE from #temp 
where NoOfProgrammers = (select max(NoOfProgrammers) from #temp)) t
on st.INSTITUTE = t.INSTITUTE
where p.GENDER = 'M' and s.DEVELOPIN = 'DBASE'

drop table #temp

--2. In which language are most of the programmer’s proficient?
select l.PROG_LANGUAGE, count(*) as count 
from (select PROF1 as PROG_LANGUAGE from PROGRAMMER 
union all
select PROF2 as PROG_LANGUAGE from PROGRAMMER) as l
group by PROG_LANGUAGE
order by count desc

--3. In which month did the most number of programmers join?

select top 1 month(DOJ) as JoiningMonth, count(*) as NoOfCount
from PROGRAMMER
group by month(DOJ)
order by NoOfCount desc

--4. In which year was the most number of Programmers born.
select top 1 YEAR(DOB) as JoiningYear, count(*) as NoOfCount
from PROGRAMMER
group by YEAR(DOB)
order by NoOfCount desc

--5. Which programmer has developed the highest number of Packages?
select PNAME from SOFTWARE 
where TITLE = (
select top 1 TITLE
from SOFTWARE
group by TITLE
order by COUNT(*) desc
)

--6. Which language was used to develop the most number of Packages.
select top 1 DEVELOPIN from SOFTWARE 
group by DEVELOPIN
order by count(*) desc

--7. Which course has below average number of Students?
create table #TempStudentsPerCourse
( COURSE VARCHAR(50),
NoOfStudents INT)

insert into #TempStudentsPerCourse
select COURSE, COUNT(*) as NoOfStudents
from STUDIES
group by COURSE

select * from #TempStudentsPerCourse

select COURSE, NoOfStudents
from #TempStudentsPerCourse
where NoOfStudents < (select avg(NoOfStudents) from #TempStudentsPerCourse)

--8. Which course has been done by the most of the Students?
select top 1 COURSE, count(*) NoOfStudents
from STUDIES
group by COURSE
order by count(*) desc

--9. Which Institute has the most number of Students?
select top 1 INSTITUTE, count(*) NoOfStudents
from STUDIES
group by INSTITUTE
order by count(*) desc

