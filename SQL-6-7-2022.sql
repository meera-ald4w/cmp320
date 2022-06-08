select bdate, emp_address
from employee
where fname = 'john' and minit = 'b' and lname = 'smith'

select * from employee

-- get names and addresses of employees working in research department
select fname, lname, emp_address, dname
from employee, department -- N tables, N=2
where dno = dnumber and dname = 'research' -- N-1 join conditions ==> 1 join condition

-- The name of the research department manager
select fname, lname, dname
from employee, department -- N tables, N=2
where mgr_ssn = ssn and dname = 'research' -- N-1 join conditions ==> 1 join condition

-- Query 2 in slides
select pnumber, dnum, lname, bdate, emp_address
from employee, department, project -- N=3
where plocation = 'stafford' and mgr_ssn = ssn and dnum = dnumber -- N-1 = 2 join conditions

-- employees working on projects located in stafford
select fname, lname, bdate, emp_address
from employee, works_on, project
where plocation = 'stafford' and pno = pnumber and essn = ssn


-- no where clause
select * 
from employee

select * 
from DEPARTMENT

-- Analyzing queries
-- get names and addresses of employees working in research department
select e.fname, e.lname, e.emp_address, d.dname -- step 3
from employee as e, department as d -- step 1: cross product
where e.dno = d.dnumber and d.dname = 'research' -- step 2: apply conditions on cross product result

-- For every department with a branch in stafford, get the manager ssn and his/her starting date
select mgr_ssn, mgr_start_date
from DEPARTMENT, DEPT_LOCATIONS
where DEPARTMENT.dnumber = DEPT_LOCATIONS.dnumber and dlocation = 'stafford'

-- renaming: changes attribuye names in results
select fname as first_name, lname last_name -- as is optional
from employee

-- aliasing: assigning names to tables
select mgr_ssn, mgr_start_date
from DEPARTMENT as D, DEPT_LOCATIONS DL -- as is optional
where D.dnumber = DL.dnumber and dlocation = 'stafford'

-- aliasing is needed if we are using the same table more than once
-- For each employee, retrieve the employee’s first and last name 
-- and the first and last name of his or her immediate supervisor.

select e1.fname, e1.lname, e2.fname, e2.lname
from employee as e1, employee as e2
where e1.super_ssn = e2.ssn

-- get employee salaries
select distinct salary, ssn
from employee

-- set operations
-- get the ssns of supervisors and managers
-- names in the result will be determined by the first relation
(select mgr_ssn from DEPARTMENT)
union
(select super_ssn from employee)

-- get ssns of employees who are supervisors but not managers

(select super_ssn from employee)
except
(select mgr_ssn from DEPARTMENT)

-- get names of employees who are managers
select fname, lname
from employee, DEPARTMENT
where ssn = mgr_ssn

-- get names of employees who are not managers
(select fname, lname, ssn from employee)
except
(select fname, lname, ssn
from employee, DEPARTMENT
where ssn = mgr_ssn)

-- is this correct? No
select fname, lname
from employee, DEPARTMENT -- step 1
where ssn != mgr_ssn -- step 2



