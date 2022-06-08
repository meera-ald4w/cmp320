create database summer22

use summer22

-- Defining primary key constraints
-- attriute level
-- Covers Key and Entity integrity constraint from the relatiponal model
create table R(A int constraint R_PK primary key, B int)
drop table r

-- table level
create table R(A int, B int, constraint R_PK primary key(A))
drop table r

-- composite keys
-- R(A, B, C) A and B are a composite key
create table R(A int, 
B int, 
C char,
constraint R_PK primary key (A, B))
drop table r


-- Adding primary keys using ALTER
create table R(A int, B int)
drop table r
-- ADD PK using LATER
-- Make sure A does not allow nulls
alter table r alter column A int not null
-- enforce PK constraints
alter table r add constraint R_PK primary key (A)

alter table r add constraint B_UNQ unique (B)

insert into r values(3, NULL)

select * from r

update r set B = 2 where A = 2

drop table r

-- adding multiple constraints on attribute level
create table r (a int not null constraint R_PK primary key constraint A_CHK check (A > 0),
B int constraint B_Default default 1)

insert into r(a) values(-1)
insert into r(a) values (2),(3),(4)
insert into r values(5, 2), (6, 3)

select * from r

alter table r nocheck constraint A_CHK
alter table r check constraint A_CHK -- will not check existing values
alter table r with check check constraint A_CHK -- will check existing values

update r set a = 7 where a = -1

drop table r

-- student(ID, Stname, section), ID is PK, section is a FK
-- section(SectID, CourseName), SectID is PK
create table section(SectID int constraint Section_PK primary key,
CourseName varchar(30) not null)

create table student(ID int constraint Student_PK primary key,
Stname varchar(20) not null,
section int,
constraint Student_Section_FK foreign key (section) references section(SectID))

insert into section values(1, 'database')
insert into section values(2, 'Digital Systems')

select * from section

update section set CourseName = 'Database Systems' where SectID = 1

insert into student values(1, 'Ali', 1) -- databse
insert into student values(2, 'Sami', 1) -- databse
insert into student values(3, 'Rami', 2) -- digital

select * from student

-- violating foreign key constraints
-- Deleting from the referenced table
-- delete the digital systems section
delete section where sectID = 2

-- Insert an non-existing PK value
insert into student values(4, 'Hani', 3) -- section 3 does not exist
insert into student values(4, 'Hani', NULL)
insert into student(ID, Stname) values(5, 'Hani')

-- update a PK vale that is referenced
-- change ID of database section
select * from section

update section set SectID = 3 where sectid = 1 -- section 1 is already referenced

-- changing the value of the FK to a value that does not exist

select * from student

update student set section = 3 where ID = 1 -- Section 3 does not exist

-- redefin table section and add triggered action on FK
-- drop the FK constraint
alter table student drop constraint student_section_FK

-- redefine FK constraint
alter table student 
add constraint student_section_FK 
foreign key (section) references section (SectID)
on update cascade 
on delete set null

update student set section = 2 where section is null

-- Testing violations again
select * from section
select * from student

delete section where sectID = 2 -- to test on delete set null
update section set SectID = 3 where sectid = 1 -- to test on update cascade

-- Use triggered action "set default" instead of set null on delete
-- We want to assign students to section 0 by default (section 0 is a dummy section)
-- Define a default value fro the FK
alter table student add constraint section_default default 0 for section

-- drop the FK constraint
alter table student drop constraint student_section_FK

-- redefine FK constraint
alter table student 
add constraint student_section_FK 
foreign key (section) references section (SectID)
on update cascade 
on delete set default

-- Testing set default
select * from section
select * from student

insert into section values(0, 'Default')

update student set section = 1 where section is null

delete section where sectid = 1


-- R(A, B), S(FK_A, C)
create table r(a int primary key, b char)
-- A constraint that involves two attributes MUST be added at table level
-- For example we need to check that FK_A >= C
create table s(FK_A int references r, C int, -- shortest way to define a FK
constraint S_CHK check (FK_A >= C)) -- this constraint MUST be at table level


drop table s
drop table r

/*
Employee(SSN, Name, Dno), SSN is PK, Dno is FK referencing Department
Department(Dno, Dname), Dno is PK
Phones (SSN, phone), (SSN, Phone) is PK, and SSN is FK referencing Employee
*/
create table department(Dno int constraint Dept_PK primary key,
Dname varchar(20) not null);

create table employee(SSN char(9) constraint Emp_PK primary key,
Name varchar(30) not null,
Dno int constraint EMP_DEPT_FK foreign key references department(dno));

create table phone(SSN char(9) constraint PHONE_EMP_FK foreign key references Employee(SSN),
Phone char(10),
constraint PHONE_PK primary key (SSN, Phone));






