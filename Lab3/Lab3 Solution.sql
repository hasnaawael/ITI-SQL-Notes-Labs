USE Company_SD;

-- 1.	Display the Department id, name and id and the name of its manager.
SELECT Dnum, Dname, MGRSSN, Fname
FROM Departments d , Employee e
WHERE d.MGRSSN = e.SSN;

-- 2.	Display the name of the departments and the name of the projects under its control.
SELECT  Dname, Pname
FROM Departments d , Project p
WHERE d.Dnum = p.Dnum;

-- 3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT d.*  , e.Fname
FROM Dependent d inner join Employee e
ON d.ESSN = e.SSN;

-- 4.	Display the Id, name and location of the projects in Cairo or Alex city.
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE City in ('Alex', 'Cairo');

-- 5.	Display the Projects full data of the projects with a name starts with "a" letter.
SELECT * 
FROM Project
WHERE Pname like 'a%';

-- 6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT * 
FROM Employee
WHERE Dno = 30 AND Salary between 1000 and 2000;

-- 7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
SELECT e.*
FROM  Employee e
inner join Works_for w ON e.SSN = w.ESSn
inner join Project p ON p.Pnumber = w.Pno
WHERE w.Hours >= 10 and p.Dnum = 10 and p.Pname = 'AL Rabwah';

-- 8.	Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT X.Fname AS employee
FROM Employee X , Employee Y
WHERE Y.Fname = 'Kamel' and Y.Lname = 'Mohamed' and X.Superssn = Y.SSN;

-- 9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT e.Fname , p.Pname
FROM Employee e inner join Works_for w
ON e.SSN = w.ESSn
inner join Project p 
ON p.Pnumber = w.Pno
WHERE w.Pno = p.Pnumber
ORDER BY p.Pname;

-- 10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
SELECT p.Pnumber , d.Dname, e.Lname, e.Address, e.Bdate
FROM Project p 
inner join Departments d 
ON p.Dnum = d.Dnum
inner join Employee e
ON e.SSN = d.MGRSSN
WHERE p.City = 'Cairo';

-- 11.	Display All Data of the managers
SELECT e.* 
FROM Employee e, Departments d
WHERE d.MGRSSN = e.SSN;

-- 12.	Display All Employees data and the data of their dependents even if they have no dependents
SELECT e.*
FROM Employee e left join Dependent d
ON e.SSN = d.ESSN;

-- 13.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee
values('Hasnaa', 'Wael', 1022672, '2001/08/20', 'mansoura', 'F', 3000,112233, 30);

-- 14.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
insert into Employee
values('Khaled', 'tarek', 102660, '2000/10/29', 'mansoura', 'm', NULL,NULL, 30);

-- 15.	Upgrade your salary by 20 % of its last value.
update Employee
set Salary += (Salary*20)/100
where SSN = 1022672;