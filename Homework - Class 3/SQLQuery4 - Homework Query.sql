/*
Calculate the count of all grades in the system​
Calculate the count of all grades per Teacher in the system​
Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
Find the Maximal Grade, and the Average Grade per Student on all grades in the system
*/

USE SEDCHome
GO

--1. Calculate the count of all grades in the system​

SELECT COUNT(*) as TotalGrades
FROM dbo.Grade
GO

--2. Calculate the count of all grades per Teacher in the system​

SELECT g.TeacherID, t.FirstName, COUNT(*) as AllGradesPerTeacher
FROM dbo.[Grade] g
INNER JOIN dbo.Teacher t on g.TeacherID = t.ID
GROUP BY TeacherID, t.FirstName
GO


--3. Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)​

SELECT TeacherId, COUNT(*) as AllGrades
FROM dbo.Grade g
INNER JOIN dbo.Teacher t on g.TeacherID = t.ID
WHERE g.StudentID < 100
GROUP BY TeacherID
GO


--4. Find the Maximal Grade, and the Average Grade per Student on all grades in the system

SELECT StudentId, Max(Grade) as MaxGrade, AVG(Grade) as AverageGrade
FROM dbo.[Grade]
GROUP BY StudentId
GO

/*
Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200​
Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count​
Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade​
List Student First Name and Last Name next to the other details from previous query
*/

--1. Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200​

SELECT t.ID, t.FirstName, t.LastName, Count(*) as AllGradePerTeacher
FROM dbo.Grade g
INNER JOIN dbo.Teacher t on t.ID = g.TeacherID
GROUP BY t.ID, t.FirstName, t.LastName
HAVING COUNT(g.Grade) > 200
GO


--2. Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count​

SELECT t.FirstName, t.LastName, Count(*) as AllGradePerTeacher
FROM dbo.Grade g
INNER JOIN dbo.Teacher t on t.ID = g.TeacherID
WHERE g.StudentID < 100
GROUP BY t.FirstName, t.LastName
HAVING Count(g.Grade) > 50
GO

--3. Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade​

SELECT s.ID, COUNT(g.Grade)as GradeCount, MAX(g.Grade) as MaxGrade, AVG(g.Grade) as AverageGrade
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
GROUP BY s.ID
HAVING MAX(g.Grade) = AVG(g.Grade)
GO


--4. List Student First Name and Last Name next to the other details from previous query

SELECT s.ID, s.FirstName ,s.LastName, COUNT(g.Grade)as GradeCount, MAX(g.Grade) as MaxGrade, AVG(g.Grade) as AverageGrade
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
GROUP BY s.Id, s.FirstName ,s.LastName
HAVING MAX(g.Grade) = AVG(g.Grade)
GO

/*
Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student​
Change the view to show Student First and Last Names instead of StudentID​
List all rows from view ordered by biggest Grade Count​

Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
*/

--1. Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student​

DROP VIEW IF EXISTS vv_StudentGrades;
GO

CREATE VIEW vv_StudentGrades
AS
SELECT s.ID, COUNT(g.Grade) as GradesPerStudent
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
GROUP BY s.ID
GO

--2. Change the view to show Student First and Last Names instead of StudentID​
ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName,S.LastName, COUNT(g.Grade) as GradesPerStudent
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
GROUP BY s.FirstName,S.LastName
GO

--3. List all rows from view ordered by biggest Grade Count​

SELECT * FROM vv_StudentGrades
ORDER BY GradesPerStudent DESC
GO

--4. Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
DROP VIEW IF EXISTS vv_StudentGradeDetails;
GO

CREATE VIEW vv_StudentGradeDetails
AS
SELECT s.FirstName,s.LastName, a.Name as AchivementType, Count(*) as PassedCourse
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
INNER JOIN dbo.GradeDetails gd on gd.GradeID = g.ID
INNER JOIN dbo.AchievementType a on gd.AchievementTypeID = a.ID
WHERE a.Name = 'Ispit'
GROUP BY s.FirstName,s.LastName, a.Name
GO
