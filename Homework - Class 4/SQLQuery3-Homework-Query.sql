USE SEDCHome
GO

/*
Declare scalar variable for storing FirstName values​
	Assign value ‘Antonio’ to the FirstName variable​
	Find all Students having FirstName same as the variable​

Declare table variable that will contain StudentId, StudentName and DateOfBirth​
	Fill the table variable with all Female students​

Declare temp table that will contain LastName and EnrolledDate columns​
	Fill the temp table with all Male students having First Name starting with ‘A’​
	Retrieve the students from the table which last name is with 7 characters​
	Find all teachers whose FirstName length is less than 5 and​
	the first 3 characters of their FirstName and LastName are the same​
*/

--1. Declare scalar variable for storing FirstName values​
		--Assign value ‘Antonio’ to the FirstName variable​
		--Find all Students having FirstName same as the variable​

		DECLARE @FirstName nvarchar(100)
		SET @FirstName = 'Antonio'

		SELECT * FROM dbo.Student
		WHERE FirstName = @FirstName


--2. Declare table variable that will contain StudentId, StudentName and DateOfBirth​
		--Fill the table variable with all Female students​

		DECLARE @StudentList TABLE
		(StudentId int, StudentName nvarchar(100), DateOfBirth date);

		INSERT INTO @StudentList
		SELECT Id, FirstName, DateOfBirth
		FROM dbo.Student
		WHERE Gender = 'F'

		SELECT * FROM @StudentList
		GO


--3. Declare temp table that will contain LastName and EnrolledDate columns​
		--Fill the temp table with all Male students having First Name starting with ‘A’​
		--Retrieve the students from the table which last name is with 7 characters​

		CREATE TABLE #StudentInfo
		(FirstName nvarchar(100), LastName nvarchar(100), EnrollerDate date);

		INSERT INTO #StudentInfo
		SELECT FirstName, LastName, EnrolledDate
		FROM dbo.Student 
		WHERE Gender = 'M' AND FirstName like 'A%'

		SELECT * FROM #StudentInfo
		WHERE LEN(LastName) = 7

--4. Find all teachers whose FirstName length is less than 5 and​
	--the first 3 characters of their FirstName and LastName are the same​

		SELECT * FROM dbo.Teacher
		WHERE LEN(FirstName) < 5 
		AND LEFT(FirstName,3) = LEFT(LastName,3)

/*
Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:​
	-StudentCardNumber without “sc-”​
	-“ – “​
	-First character of student FirstName​
	-“.”​
	-Student LastName
*/

select * from dbo.Student

CREATE FUNCTION dbo.fn_FormatStudentName (@StudentId int) 
RETURNS nvarchar(100)
AS
BEGIN
DECLARE @Result nvarchar(500)
SELECT @Result = SUBSTRING(StudentCardNumber,4,LEN(StudentCardNumber)) + N'-' + LEFT(FirstName,1) + '.' + LastName
FROM dbo.Student
WHERE Id = @StudentId

RETURN @Result
END

GO

SELECT *,dbo.fn_FormatStudentName(Id) AS StudentDescription
FROM dbo.Student


--Create multi-statement table value function that for specific Teacher and Course
--will return list of students (FirstName, LastName) who passed the exam, together with Grade and CreatedDate

CREATE FUNCTION dbo.fn_TeacherAndCource (@TeacherId int, @CourseId int)
RETURNS @Result TABLE (StudentFirstName nvarchar(100), StudentLastName nvarchar(100), Grade int, CreatedDate date)
AS
BEGIN

INSERT INTO @Result
SELECT s.FirstName as StudentFirstName, s.LastName as StudentLastName, g.Grade as Grade, g.CreatedDate as CreatedDate
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
inner join dbo.Teacher t on t.ID = g.TeacherID
WHERE t.ID = @TeacherId AND g.CourseID = @CourseId

RETURN
END

GO

DECLARE @TeacherId int = 1
DECLARE @CourseId int = 1

SELECT * FROM dbo.fn_TeacherAndCource (@TeacherId,@CourseId)



