-- Q4) Retrieve names of departments with 2 or more female employees
-- filtering rows
select dname
from employee, department
where dno = dnumber and sex='f'
group by dname, dno
having count(*) >= 2

-- filtering groups
select dname
from employee, department
where dno = dnumber 
group by dname, dno, sex
having count(*) >= 2 and sex='f' 

-- Q5) Retrieve the name of an employee is he/she works in a department alone
select fname, lname
from employee
where dno in (
				select dno 
				from employee 
				group by dno 
				having count(*) = 1
			)
-- Without aggregate functions
-- IN / NOT IN
select fname, lname
from employee e1
where e1.dno not in (
					select e2.dno 
					from employee e2 
					where e2.ssn != e1.ssn  
					)
-- Exists / Not Exists
select fname, lname
from employee e1
where not exists (select * from employee e2 where e2.ssn != e1.ssn and e2.dno = e1.dno)

-- Joins
select e1.fname, e1.lname
from employee e1 left outer join employee e2 on e2.ssn != e1.ssn and e2.dno = e1.dno
where e2.ssn is null




-- Views
select * 
from works_on1


select * from works_on
select * from project
update works_on set emp_hours = 32.5 where essn = '123456789' and pno = 1

-- Assign John Smith to ProductZ
-- This will rename ProductX to ProductZ
update works_on1 set pname = 'ProductX' where fname = 'John' and lname = 'smith' and pname = 'ProductZ'

-- To really reassign John Smith, we need to update base relations
update works_on set pno = 1 where essn = '123456789' and pno = 3


-- In-line views
select fname, lname
from employee, (select dnumber from DEPARTMENT where dname='research') as T -- MUST give an alias
where dno = dnumber


-- 1) The names of employees with salaries greater than the average salary

select fname, lname
from employee, (select avg(salary) as avg_sal from employee) as T
where salary > avg_sal

-- 2) The greatest average salary of employees in a department
select max(avg_sal) as max_avg_sal
from (select avg(salary) as avg_sal from employee group by dno) as T


-- 3) The average number of employees per department
select avg(no_of_emp) as avg_no_emp_per_dept
from (select count(*) as no_of_emp from employee group by dno) as T







