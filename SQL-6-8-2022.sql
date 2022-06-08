
-- like: to compare attributes against patterns
select fname
from employee
where bdate like '%1955%'

-- Between: to compare against a range
select fname, salary
from employee
where salary between 50000 and 30000 -- salary >= 30000 adn salary <= 50000 (in this order)

select fname
from employee
where fname between 'A' and 'J'


-- display the salries of employees working on project 'ProductX' raised by 10%
select fname, salary * 1.1 as new_salary, salary as old_salary
from employee, works_on, project
where ssn = essn and pno = pnumber and pname = 'productx'



-- Order by: to order the results
-- can order on an attribute that is not selected
select fname, salary
from employee
order by salary desc, fname desc

-------------------------------- CHAPTER 7 -----------------------------
-- use IS or NOT IS to test NULL values
select * from employee

select fname from employee where super_ssn is NULL and salary > 40000

select fname from employee where super_ssn is not NULL and salary > 40000


-- Nested queries 
-- Queries in the where clause

-- Get the names of employees working in the research department 

select fname, lname
from employee, DEPARTMENT
where dno = dnumber and dname ='research'

-- semi-join
select fname, lname
from employee
where dno IN (select dnumber from DEPARTMENT where dname = 'research')

-- Get the names of employees working in the research department or the administration department
select fname, lname
from employee, DEPARTMENT
where dno = dnumber and (dname ='research' or dname = 'administration')

select fname, lname
from employee
where dno IN (select dnumber from DEPARTMENT where dname = 'research' or dname = 'administration')
-- equivalent to dno = v1 OR dno = V2 OR dno = V3

select * from employee

select salary from employee where dno = 5

select fname, lname
from employee
where salary > all (select salary from employee where dno = 5)


-- correlated
select e.fname
from employee as e
where e.ssn in (select d.essn from EMP_DEPENDENT as d
where e.fname = d.Dependent_name and e.sex = d.sex)

select e.fname
from employee e, EMP_DEPENDENT d
where d.essn = e.ssn and d.Dependent_name = e.fname and d.sex = e.sex


-- Using exists
-- Get the names of employees working in the research department 

-- without nested queries
select fname, lname
from employee, DEPARTMENT
where dno = dnumber and dname ='research'

-- Using IN
select fname, lname
from employee
where dno IN (select dnumber from DEPARTMENT where dname = 'research')

-- Using Exists
select fname, lname
from employee
where exists (select dnumber from DEPARTMENT where dname = 'research' and dno = dnumber)


-- Names of employees how are managers
select fname, lname
from employee
where ssn in (select mgr_ssn from DEPARTMENT)

-- exists
select fname, lname
from employee
where exists (select mgr_ssn from DEPARTMENT where ssn = mgr_ssn)

-- Names of employees how are not managers
select fname, lname
from employee
where ssn not in (select mgr_ssn from DEPARTMENT)

-- exists
select fname, lname
from employee
where not exists (select mgr_ssn from DEPARTMENT where ssn = mgr_ssn)

-- retrieve a department name if it has employees with salaries greater than 30000
-- without nesting
select dname
from DEPARTMENT, employee
where dnumber = dno and salary > 30000

select dname
from DEPARTMENT
where exists (select * from employee where salary > 30000 and dno = dnumber)


select dname
from DEPARTMENT
where dnumber in (select dno from employee where salary > 30000)

-- Joins

-- implicit joins
select fname, lname
from employee, DEPARTMENT
where dno = dnumber and dname ='research'

-- explicit joins
select fname, lname
from employee join DEPARTMENT on dno = dnumber
where dname ='research'