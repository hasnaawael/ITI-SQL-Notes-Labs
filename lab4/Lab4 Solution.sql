use Company_SD;

-- DQL
-- 1.	Display (Using Union Function)
        -- The name and the gender of the dependence that's gender is Female and depending on Female Employee.
        -- And the male dependence that depends on Male Employee.
SELECT d.Dependent_name, d.Sex
FROM Dependent d inner join Employee e
ON E.SSN = D.ESSN and e.Sex = 'F' and d.Sex = 'F' 
UNION all
SELECT d.Dependent_name, d.Sex
FROM Dependent d inner join Employee e
ON E.SSN = D.ESSN and e.Sex = 'M' and d.Sex = 'M';

-- 2.	For each project list the project name and the total hours per week (for all employees) spent on that project
SELECT p.pname , SUM(w.Hours) AS Total_hours
FROM Project p INNER JOIN Works_for w
ON p.Pnumber = w.Pno
GROUP BY Pname;

-- 3.	Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT * 
FROM Departments
WHERE Dnum = (
		SELECT Dno 
		FROM Employee
		WHERE SSN = (
				SELECT MIN(SSN)
				FROM Employee));

-- 4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT MIN(salary) AS min_value, MAX(salary) as max_value, AVG(salary) AS avg_value , dname
FROM Employee e,Departments d
WHERE d.Dnum=e.Dno
GROUP BY Dname

-- 5.	List the full name of all managers who have no dependents.
SELECT e.Fname + ' ' + e.Lname AS Full_Name
FROM Employee e
INNER JOIN Departments d ON e.SSN = d.MGRSSN
LEFT JOIN Dependent dep ON e.SSN = dep.ESSN
WHERE dep.ESSN IS NULL;

/* 6.	For each department if its average salary is less than the average salary of all employees
        display its number, name and number of its employees.*/
SELECT AVG(Salary) AS Average_Salary ,COUNT(SSN) AS Count_Of_Employee , d.Dname, d.Dnum 
FROM Employee e inner join Departments d
ON d.Dnum = e.Dno 
GROUP BY  d.Dname , d.Dnum
HAVING AVG(Salary) <
		(SELECT AVG(Salary)
		 FROM Employee);

/* 7.	Retrieve a list of employee’s names and the projects names they are working on ordered by department number and within each department,
        ordered alphabetically by last name, first name. */
SELECT e.*, p.*
FROM Departments d inner join Project p
ON d.Dnum = p.Dnum
inner join Employee e 
ON e.Dno = d.Dnum
ORDER BY d.Dname  ,e.Lname ,e.Fname;

-- 8.	Try to get the max 2 salaries using subquery
SELECT salary
FROM Employee
WHERE salary IN (
    SELECT TOP 2 salary
    FROM Employee
    ORDER BY salary DESC
)
ORDER BY salary DESC;

-- 9.	Get the full name of employees that is similar to any dependent name
SELECT e.Fname + ' ' + e.Lname AS Full_name
FROM Employee e inner join Dependent d
ON e.SSN = d.ESSN
WHERE e.Fname + ' ' + e.Lname = d.Dependent_name;

-- 10.	Display the employee number and name if at least one of them have dependents (use exists keyword)
SELECT e.SSN, e.Fname
FROM Employee e
WHERE exists (
		SELECT ESSN
		FROM Dependent
		WHERE ESSN = e.SSN)

/* 11.	In the department table insert new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for
        this department. The start date for this manager is '1-11-2006' */
INSERT into Departments
(Dname, Dnum, MGRSSN, [MGRStart Date])
VALUES('DEPT IT', 100, 112233, '1-11-2006');

/* 12.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672) */
UPDATE Departments
SET  MGRSSN = 968574
WHERE Dnum = 100;

UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;

/*13. Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees, or works on any projects and handles these cases).*/
DELETE Dependent where ESSN=223344

UPDATE Departments
SET MGRSSN = 102672
WHERE MGRSSN = 223344;

UPDATE Employee set Superssn = 102672  where Superssn=223344;

DELETE Employee where SSN=223344

/* 14.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% */
UPDATE Employee
SET Salary += (Salary * 30 )/100
WHERE Dno = 
		(SELECT Dnum
         FROM Project
         WHERE Pname = 'Al Rabwah');