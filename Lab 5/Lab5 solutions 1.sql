USE ITI;

-- 1.	Retrieve number of students who have a value in their age. 
SELECT COUNT(St_Age)
FROM Student
WHERE St_Age is not null;

-- 2.	Get all instructors Names without repetition
SELECT distinct Ins_Name
FROM Instructor;

-- 3.	Display student with the following Format (Student ID, Student Full Name, Department name)
SELECT s.St_Id ,isnull(s.St_Fname + ' '+ s.St_Lname ,'' )AS Full_Name ,d.Dept_Name
FROM Student s inner join Department d
ON s.Dept_Id = d.Dept_Id;

/* 4.	Display instructor Name and Department Name 
 Note: display all the instructors if they are attached to a department or not */
 SELECT i.Ins_Name , d.Dept_Id
 FROM Instructor i left join Department d 
 ON i.Dept_Id = d.Dept_Id;

/* 5.	Display student full name and the name of the course he is taking
For only courses which have a grade */
SELECT isnull(s.St_Fname + ' '+ s.St_Lname ,'' )AS Full_Name ,Crs_name
FROM Student s inner join Stud_Course sc 
ON s.St_Id = sc.St_Id
inner join Course c 
ON c.Crs_Id = sc.Crs_Id
WHERE Grade is not null;

/* 6.	Display number of courses for each topic name */
SELECT t.Top_Id, count(Crs_Id)
FROM Topic t inner join Course c
ON t.Top_Id = c.Top_Id
GROUP BY t.Top_Id;

/* 7.	Display max and min salary for instructors */
SELECT MAX(Salary) AS Max_Salary ,MIN(Salary) AS Min_Salary
FROM Instructor;

/* 8.	Display instructors who have salaries less than the average salary of all instructors. */
SELECT ins_name
FROM Instructor
WHERE salary < (
			SELECT AVG(salary)
			FROM Instructor);

/* 9.	Display the Department name that contains the instructor who receives the minimum salary.*/ 
SELECT Dept_Name
FROM Instructor i inner join Department d
ON i.Dept_Id = d.Dept_Id
WHERE Salary = (
		SELECT MIN(salary)
		FROM Instructor);

/* 10. Select max two salaries in instructor table. */
SELECT top 2 Salary
FROM Instructor
ORDER BY salary DESC ;

/* 11.	 Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function” */
SELECT ins_name ,coalesce(convert( varchar(20),salary),'bounas')
FROM  Instructor

/* 12.	Select Average Salary for instructors */
SELECT AVG(salary)
FROM Instructor;

/* 13.	Select Student first name and the data of his supervisor */
SELECT s.St_Fname ,super.*
FROM Student s inner join student super
ON s.St_super = super.St_Id;

/* 14.	Create a view that displays student full name, course name if the student has a grade more than 50 */
CREATE VIEW StudentCourseGradesAbove50 AS
SELECT s.St_Fname+' '+ s.St_Lname AS full_name,c.crs_name
FROM Student s
JOIN Stud_Course sc 
ON s.St_Id = sc.St_Id
JOIN Course c 
ON sc.Crs_Id =c.Crs_Id
WHERE sc.Grade > 50;

-- Check --
SELECT * FROM StudentCourseGradesAbove50;

-- 15.	 Create an Encrypted view that displays manager names and the topics they teach. 
CREATE VIEW ManagerTopics
WITH ENCRYPTION
AS
SELECT I.Ins_Name , T.Top_Name 
FROM Instructor I
JOIN
    Ins_Course IC ON I.Ins_Id = IC.Ins_Id
JOIN
    Course C ON IC.Crs_Id = C.Crs_Id
JOIN
    Topic T ON C.Top_Id = T.Top_Id;

-- Check --
SELECT * FROM ManagerTopics;

-- 16.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
CREATE VIEW InstructorDepartmentView AS
SELECT I.Ins_Name , D.Dept_Name 
FROM Instructor I
JOIN Department D 
ON I.Dept_Id = D.Dept_Id
WHERE D.Dept_Name IN ('SD', 'Java');

-- Check --
SELECT * FROM InstructorDepartmentView;

/* 17.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’ */ 
CREATE VIEW V1 AS
SELECT St_Id, St_Fname, St_Lname, St_Address, St_Age, Dept_Id, St_super
FROM Student
WHERE St_Address IN ('Alex', 'Cairo')
WITH CHECK OPTION;

-- Check -- 
SELECT * FROM V1;

-- TRY TO UPDATE -- >> ERROR 
UPDATE V1 
SET St_Address = 'Tanta'
WHERE St_Address = 'Alex';






