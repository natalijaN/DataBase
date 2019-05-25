/*
Create new procedure called CreateGrade​
	1. Procedure should create only Grade header info (not Grade Details) ​
	2. Procedure should return the total number of grades in the system for 
	   the Student on input (from the CreateGrade)​
	3. Procedure should return second resultset with the MAX Grade of all grades 
	   for the Student and Teacher on input (regardless the Course)
*/

USE SEDCHome
GO

CREATE PROCEDURE dbo.CreateGrade
(@StudentID int, @CourseID smallint, @TeacherID smallint, @Grade tinyint, @Comment nvarchar(100),
@CreatedDate datetime)
AS
BEGIN

INSERT INTO dbo.Grade ([StudentID],[CourseID],[TeacherID],[Grade],[Comment],[CreatedDate])
VALUES (@StudentID,@CourseID,@TeacherID,@Grade,@Comment,@CreatedDate)

SELECT COUNT(*) as TotalNumberOfGrades 
FROM dbo.Grade
WHERE StudentID = @StudentID

SELECT MAX(Grade) AS MaxGrade
FROM dbo.Grade
WHERE StudentID = @StudentID AND TeacherID = @TeacherID

END
GO

select * from dbo.Grade
EXEC dbo.CreateGrade
@StudentID = 434,
@CourseID = 7,
@TeacherID = 88,
@Grade = 7,
@Comment = 'Snaodliv',
@CreatedDate = '2019-05-23'



/*
Create new procedure called CreateGradeDetail​
	1. Procedure should add details for specific Grade 
	   (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)​
	2. Output from this procedure should be resultset with SUM of GradePoints calculated 
	   with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade
*/

/*
Add error handling on CreateGradeDetail procedure​
Test the error handling by inserting not-existing values for AchievementTypeID
*/

CREATE PROCEDURE dbo.CreateGradeDetail
(@GradeID int, @AchivementTypeId tinyint, @AchivementPoints tinyint, 
 @AchievementMaxPoints tinyint, @AchievemntDate datetime = null)
 AS
 BEGIN

 SET @AchievemntDate = (SELECT (CreatedDate) FROM dbo.Grade WHERE ID = @GradeId)

 BEGIN TRY

 INSERT INTO dbo.GradeDetails ([GradeID],[AchievementTypeID],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
 VALUES (@GradeId, @AchivementTypeId,@AchivementPoints,@AchievementMaxPoints,@AchievemntDate)

 SELECT SUM(gd.AchievementPoints * 1.0/gd.AchievementMaxPoints*a.ParticipationRate) as GradePoints
 FROM dbo.GradeDetails gd
 INNER JOIN dbo.AchievementType a on a.ID = gd.AchievementTypeID
 WHERE gd.GradeID = @GradeId

 END TRY
 BEGIN CATCH
 SELECT ERROR_MESSAGE() as ErrorMessage
 SELECT ERROR_LINE() as ErrorLine
 END CATCH

 END
GO

 EXEC dbo.CreateGradeDetail
 @GradeId = 1,
 @AchivementTypeId = 1,
 @AchivementPoints = 60,
 @AchievementMaxPoints = 100


select * from dbo.Grade
where id  = 1

select * from dbo.AchievementType 
where id = 1

select * from dbo.GradeDetails
where GradeID = 1

/*
Add error handling on CreateGradeDetail procedure​
Test the error handling by inserting not-existing values for AchievementTypeID
*/

ALTER TABLE dbo.GradeDetails WITH CHECK
ADD CONSTRAINT FK_GradeDetails_AchievementType
FOREIGN KEY (AchievementTypeID) 
REFERENCES dbo.AchievementType([ID])
GO

EXEC dbo.CreateGradeDetail
 @GradeId = 1,
 @AchivementTypeId = 10,
 @AchivementPoints = 60,
 @AchievementMaxPoints = 100