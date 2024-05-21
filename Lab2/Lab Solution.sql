USE Company_SD

-- 1.	Display all the employee's Data.
SELECT * 
FROM Employee;

-- 2.	Display the employee's First name, last name, Salary, and Department number.
SELECT Fname, Lname, Salary, Dno 
FROM Employee;

-- 3.	Display all the project's names, locations, and the department which is responsible for it.
SELECT  Pname , Plocation, Dnum
FROM Project;

-- 4.	If you know that the company policy is to pay an annual commission for each employee with a specific percentage equal to 10% of his/her yearly salary. Display each employee's full name and his annual commission in an ANNUAL COMM column (alias).
SELECT fname + ' ' + Lname AS fullname, (12 * Salary * 0.1) AS "ANNUAL COMM"
FROM Employee;

--5.	Display the employee's ID, and name who earns more than 1000 LE monthly.
SELECT SSN, fname + ' ' + Lname AS fullname
FROM Employee
WHERE Salary > 1000;

--6.	Display the employee's ID, and name who earns more than 10000 LE annually.
SELECT SSN, fname + ' ' + Lname AS fullname
FROM Employee
WHERE (Salary*12) > 10000;

--7.	Display the names and salaries of the female employees 
SELECT fname + ' ' + Lname AS fullname
FROM Employee 
WHERE  sex='F';

--8.	Display each department ID, a name managed by a manager with an ID equal to 968574.
SELECT dname,dnum 
FROM Departments
WHERE MGRSSN=968574;

--9.	Display the IDs, names, and locations of the projects which controlled by department 10.
SELECT pnumber,pname,plocation 
FROM Project
WHERE dnum=10;