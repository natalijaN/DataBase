USE SEDCHome
GO

/*
Find all Students with FirstName = Antonio​
Find all Students with DateOfBirth greater than ‘01.01.1999’​
Find all Male students​
Find all Students with LastName starting With ‘T’​
Find all Students Enrolled in January/1998​
Find all Students with LastName starting With ‘J’ enrolled in January/1998​
*/


--1. Find all Students with FirstName = Antonio​
SELECT *
FROM Student
WHERE FirstName = 'Antonio'
GO

--2.Find all Students with DateOfBirth greater than ‘01.01.1999’​
SELECT *
FROM Student
WHERE DateOfBirth > '1999.01.01'
GO

--3. Find all Male students
SELECT *
FROM Student
WHERE Gender = 'M'
GO


--4. Find all Students with LastName starting With ‘T’​
SELECT *
FROM Student
WHERE Lastname like 'T%'
GO

--5. Find all Students Enrolled in January/1998​
SELECT *
FROM Student
WHERE EnrolledDate >= '1998.01.01' and EnrolledDate <= '1998.01.31'
GO

--6. Find all Students with LastName starting With ‘J’ enrolled in January/1998​
SELECT *
FROM Student
WHERE EnrolledDate >= '1998.01.01' AND EnrolledDate <= '1998.01.31'
AND LastName like 'J%'
GO

/*
Find all Students with FirstName = Antonio ordered by Last Name​
List all Students ordered by FirstName​
Find all Male students ordered by EnrolledDate, starting from the last enrolled
*/

--1.Find all Students with FirstName = Antonio ordered by Last Name​
SELECT *
FROM Student
WHERE FirstName = 'Antonio'
ORDER BY LastName ASC
GO


--2.List all Students ordered by FirstName​
SELECT *
FROM Student
ORDER BY FirstName ASC
GO

--3.Find all Male students ordered by EnrolledDate, starting from the last enrolled
SELECT *
FROM Student
WHERE Gender = 'M'
ORDER BY EnrolledDate DESC
GO

/*
List all Teacher First Names and Student First Names in single result set with duplicates​
List all Teacher Last Names and Student Last Names in single result set. Remove duplicates​
List all common First Names for Teachers and Students
*/

--1.List all Teacher First Names and Student First Names in single result set with duplicates​
SELECT FirstName
FROM Teacher
UNION ALL
SELECT FirstName
FROM Student
GO

--2.List all Teacher Last Names and Student Last Names in single result set. Remove duplicates​
SELECT LastName
FROM Teacher
UNION 
SELECT LastName
FROM Student
GO

--3.List all common First Names for Teachers and Students
SELECT FirstName
FROM Teacher
INTERSECT
SELECT FirstName
FROM Student
GO


/*
Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert​
Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints​
Change AchievementType table to guarantee unique names across the Achievement types
*/

--1.Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert​
ALTER TABLE GradeDetails
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints
DEFAULT 100 FOR AchievementMaxPoints
GO

SELECT * FROM GradeDetails
GO

INSERT INTO GradeDetails (gradeid,achievementtypeid,achievementpoints, achievementdate)
VALUES (1,5,120,'2000.01.01')
GO

--2.Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints​

ALTER TABLE GradeDetails WITH CHECK
ADD CONSTRAINT CHK_GradeDetails_AchievementPoints
CHECK (AchievementPoints <= AchievementMaxPoints)
GO

--3.Change AchievementType table to guarantee unique names across the Achievement types
SELECT * FROM AchievementType
GO

ALTER TABLE AchievementType WITH CHECK
ADD CONSTRAINT UC_AchievementType_Name 
UNIQUE (NAME)
GO


--Create Foreign key constraints from diagram or with script

ALTER TABLE [dbo].[Grade]  WITH CHECK ​
ADD CONSTRAINT [FK_Grade_Teacher] 
FOREIGN KEY([TeacherId])​
REFERENCES [dbo].[Teacher] ([Id])​
GO

/*
List all possible combinations of Courses names and AchievementType names that can be passed by student​
List all Teachers that has any exam Grade​
List all Teachers without exam Grade
List all Students without exam Grade (using Right Join)
*/

--1.List all possible combinations of Courses names and AchievementType names that can be passed by student​
SELECT c.Name as CourseName, a.Name as AchievementTypeName
FROM dbo.Course c
cross join dbo.AchievementType a
GO

--2.List all Teachers that has any exam Grade​
SELECT DISTINCT t.FirstName
FROM dbo.[Grade] g
inner join dbo.Teacher t on t.Id = g.TeacherId
GO

--3.List all Teachers without exam Grade​
SELECT DISTINCT T.FirstName
FROM dbo.Teacher t
left join dbo.[Grade] g on t.Id = g.TeacherId
WHERE g.TeacherId is null
GO


--4.List all Students without exam Grade (using Right Join)
SELECT s.*
FROM dbo.[Grade] g
right join dbo.Student s on g.StudentId = s.Id
WHERE g.StudentId is null

