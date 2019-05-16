CREATE DATABASE Faculty_Mechanic
GO

USE Faculty_Mechanic
GO

DROP TABLE IF EXISTS [dbo].[Student];
DROP TABLE IF EXISTS [dbo].[Teacher];
DROP TABLE IF EXISTS [dbo].[Course];
DROP TABLE IF EXISTS [dbo].[Grade];
DROP TABLE IF EXISTS [dbo].[GradeDetails];
DROP TABLE IF EXISTS [dbo].[AchievementType];

create table [dbo].[Student](
[Id] [bigint] IDENTITY (1,1) NOT NULL,
[FirstName] [nvarchar] (50) NOT NULL,
[LastName] [nvarchar] (50) NOT NULL,
[DateOfBirth] [date] NULL,
[EnrolledDate] [date] NOT NULL,
[Gender] [nchar] (1) NOT NULL,
[NationalIdNumber] [nvarchar] (50) NULL,
[StudentCardNumber] [nvarchar] (20) NOT NULL,
CONSTRAINT [Pk_Student]	PRIMARY KEY CLUSTERED
(
[ID] ASC
))
GO

CREATE TABLE [dbo].[Teacher](
[Id] [int] IDENTITY (1,1) NOT NULL,
[FirstName] [nvarchar] (50) NOT NULL,
[LastName] [nvarchar] (50) NOT NULL,
[DateOfBirth] [date] NULL,
[AcademicRank] [nvarchar] (100) NOT NULL,
[HireDate] [date] NULL,
CONSTRAINT [Pk_Teacher] PRIMARY KEY CLUSTERED
(
[Id] ASC
))
GO

CREATE TABLE [dbo].[Course](
[Id] [int] IDENTITY (1,1) NOT NULL,
[Name] [nvarchar] (100) NOT NULL,
[Credit] [smallint] NOT NULL,
[AcademicYear] [nvarchar] (50) NOT NULL,
[Semester] [nvarchar] (50) NOT NULL,
CONSTRAINT [Pk_Cource] PRIMARY KEY CLUSTERED
(
[Id] ASC
))
GO


CREATE TABLE [dbo].[Grade](
[Id] [bigint] IDENTITY (1,1) NOT NULL,
[StudentId] [bigint] NOT NULL,
[CourseId] [int] NOT NULL,
[TeacherId] [int] NOT NULL,
[Grade] [smallint] NOT NULL,
[Comment] [nvarchar] (max) NULL,
[CreatedDate] [date] NOT NULL,
CONSTRAINT [Pk_Grade] PRIMARY KEY CLUSTERED
(
[ID] ASC
))
GO

CREATE TABLE [dbo].[GradeDetails](
[Id] [bigint] IDENTITY (1,1) NOT NULL,
[GradeId] [bigint] NOT NULL,
[AchievementTypeId] [bigint] NOT NULL,
[AchievementPoints​] [int] NOT NULL,
[AchievementMaxPoints] [int] NOT NULL,
[AchievementDate] [date] NOT NULL,
CONSTRAINT [Pk_GradeDetails] PRIMARY KEY CLUSTERED
(
[ID] ASC
))
GO

CREATE TABLE [dbo].[AchievementType](
[Id] [bigint] IDENTITY (1,1) NOT NULL,
[Name] [nvarchar] (200) NOT NULL,
[Description] [nvarchar] (max) NULL,
[ParticipationRate] [int] NOT NULL,
CONSTRAINT [Pk_AchievementType] PRIMARY KEY CLUSTERED
(
[ID] ASC
))
GO

--STUDENT

INSERT INTO [Student] ([FirstName],[LastName],[DateOfBirth],[EnrolledDate],[Gender],[NationalIdNumber],[StudentCardNumber])
VALUES ('Natalija','Nikolova','08/08/1994','09/15/2013','f','123', '581'),
	   ('Stefan','Trajkov','05/12/1994','09/15/2014','m','456', 'A1023')
GO

SELECT * FROM Student


--TEACHER

INSERT INTO [Teacher] ([FirstName],[LastName],[DateOfBirth],[HireDate],[AcademicRank])
VALUES ('Goce','Tasevski','03/26/1985','04/09/2006','Docent'),
	   ('Ivan','Mickoski','03/26/1968','04/09/1998','Dr-prof')
GO

SELECT * FROM Teacher


--COURSE

INSERT INTO [Course] ([Name],[Credit],[AcademicYear],[Semester])
VALUES ('Static', 6, '2013/2014', 'Winter'),
	   ('Kinematic and Dynamic', 6, '2014/2015','Winter')
GO

SELECT * FROM Course


--Grade

INSERT INTO [Grade] ([StudentId],[CourseId],[TeacherId],[Grade],[CreatedDate])
VALUES (1, 1, 1, 9,'12/26/2013' ),
	   (1, 2, 2, 10,'12/28/2014')
GO

SELECT * FROM Grade


--AchievementType

INSERT INTO [AchievementType] ([Name],[Description],[ParticipationRate])
VALUES ('Activity','MediumActive', 7),
	   ('Homework','Regulary', 10)
GO

SELECT * FROM [AchievementType]



--GradeDetails

INSERT INTO [GradeDetails] ([GradeId],[AchievementTypeId],[AchievementPoints​],[AchievementMaxPoints],[AchievementDate])
VALUES (1, 1, 70, 100,'12/20/2013' ),
	   (2, 2, 100, 100,'12/27/2014')
GO

SELECT * FROM GradeDetails


