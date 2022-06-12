


-- Q1) Retrieve the name of an employee if he/she is a supervisor and a manager 
--1) IN
select fname, lname 
from employee
where ssn in (select super_ssn from employee) 
and ssn in (select mgr_ssn from department)
--2) Exists
select fname, lname 
from employee e
where exists (select super_ssn from employee s where e.ssn = s.super_ssn) 
and exists (select mgr_ssn from department where ssn = mgr_ssn)
--3) Joins
select distinct e.fname, e.lname
from employee e, employee s, DEPARTMENT
where e.ssn = s.Super_ssn and e.ssn = mgr_ssn



-- Q2) Retrieve the name of an employee if his/her supervisor is a manager of a department
--1) IN
select fname, lname
from employee
where super_ssn in (select mgr_ssn from department)
--2) Exists
select fname, lname
from employee
where exists (select mgr_ssn from department where super_ssn = mgr_ssn)
--3) Joins
select fname, lname
from employee, DEPARTMENT
where super_ssn = mgr_ssn


-- Q3) Retrieve the names of employees who are not supervisors
--1) IN
select fname, lname
from employee
where ssn not in (select super_ssn from employee where super_ssn is not null)
-- A not in (B1, B2, ..., Bn) ==> A != B1 AND A != B2 AND ... AND A != Bn
--2) Exists
select fname, lname
from employee e
where not exists (select super_ssn from employee s where s.super_ssn = e.ssn)

--3) Joins
select e.fname, e.lname
from employee e left outer join employee s on e.ssn = s.Super_ssn
where s.ssn is null


-- Q4) Retrieve the name of an employee if he/she is paid the lowest salary 
-- no aggregations allowed

select * from employee

--1) IN
select fname, salary
from employee
where salary <= all (select salary from employee)

--2) Exists
select fname, salary
from employee e1
where not exists (select * from employee e2 where e1.salary > e2.salary)

--3) Joins
select e1.fname, e1.salary
from employee e1 left outer join employee e2 on e1.salary > e2.salary
where e2.ssn is null


-- AGGREGATE FUNCTIONS

select count(*) as num_of_employees, count(super_ssn) as num_of_supers, 
count(distinct super_ssn) as num_of_distinct_supers
from employee

-- count the number of employees in each department
select dname, count(*) as num_of_emp
from employee, DEPARTMENT
where dno = dnumber
group by dno, dname

-- count the number of male and female employees in each department
select dname, sex, count(*) as num_of_emp
from employee, DEPARTMENT
where dno = dnumber
group by dno, dname, sex


-- Filtering groups
-- count the number of male employees in each department
select dname, sex, count(*) as num_of_emp
from employee, DEPARTMENT
where dno = dnumber
group by dno, dname, sex
having sex = 'M' -- Filtered groups


select dname, sex, count(*) as num_of_emp
from employee, DEPARTMENT
where dno = dnumber and sex='m' -- filter tuples
group by dno, dname, sex

-- count the number of male and female employees in each department. 
-- Show the groups where there are at least 2 employees
select dname, sex, count(*) as num_of_emp
from employee, DEPARTMENT
where dno = dnumber
group by dno, dname, sex
having count(*) >= 2


select * from employee

-- Q1) Retrieve the names of employees with lowest salaries
select fname, lname, salary
from employee
where salary = min(salary) -- The wrong way. Aggregate functions MUST be in the SELECT clause

select fname, lname, salary
from employee
where salary = (select min(salary) from employee)

-- Q2) Retrieve the names of employees with two or more dependents
select fname, lname
from employee, EMP_DEPENDENT
where ssn = essn
group by ssn, fname, lname
having count(*) >= 2

select fname, lname
from employee
where ssn in (
				select essn 
				from EMP_DEPENDENT
				group by essn
				having count(*) >= 2
			)


select * from employee
select * from EMP_DEPENDENT



-- Q3) Retrieve the names of employees with two or more sons
select fname, lname
from employee, EMP_DEPENDENT
where ssn = essn and relationship = 'son'
group by ssn, fname, lname
having count(*) >= 2

select fname, lname
from employee
where ssn in (
				select essn 
				from EMP_DEPENDENT
				where relationship = 'son'
				group by essn
				having count(*) >= 2
			)

-- filter groups
select fname, lname
from employee, EMP_DEPENDENT
where ssn = essn 
group by ssn, fname, lname, relationship 
having count(*) >= 2 and relationship = 'son'
-- Q4) Retrieve names of departments with 2 or more female employees
-- Q5) Retrieve the name of an employee is he/she works in a department alone
