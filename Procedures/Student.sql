--SeleceAll Student--
--EXEC PR_Student_SelectAll
ALTER PROC [dbo].[PR_Student_SelectAll]
AS

SELECT	[dbo].[MST_Student].[StudentID],
		[dbo].[MST_Student].[StudentName],
		[dbo].[MST_Student].[MobileNoStudent],
		[dbo].[MST_Student].[Email],
		[dbo].[MST_Student].[MobileNoFather],
		[dbo].[MST_Student].[Address],
		[dbo].[MST_Student].[BirthDate],
		[dbo].[MST_Student].[Age],
		[dbo].[MST_Student].[IsActive],
		[dbo].[MST_Student].[Gender],
		[dbo].[MST_Student].[Password],
		[dbo].[MST_Student].[Created],
		[dbo].[MST_Student].[Modified],
		[dbo].[MST_Branch].[BranchID],
		[dbo].[MST_Branch].[BranchName],
		[dbo].[MST_Branch].[BranchCode],
		[dbo].[LOC_City].[CityID],
		[dbo].[LOC_City].[CityName],
		[dbo].[LOC_City].[Citycode]
		
FROM [dbo].[MST_Student]

INNER JOIN [LOC_City]
ON [MST_Student].CityID = [LOC_City].CityID

INNER JOIN [MST_Branch]
ON [MST_Student].BranchID = [MST_Branch].BranchID

ORDER BY [dbo].[MST_Student].[StudentName],[dbo].[MST_Branch].[BranchName],[dbo].[LOC_City].[CityName]

--SelectByPK Student--
--EXEC PR_Student_SelectByPK 1
ALTER PROC [dbo].[PR_Student_SelectByPK] 
@StudentID INT
AS

SELECT	[dbo].[MST_Student].[StudentID],
		[dbo].[MST_Student].[StudentName],
	    [dbo].[MST_Student].[MobileNoStudent],
	    [dbo].[MST_Student].[Email],
	    [dbo].[MST_Student].[MobileNoFather],
	    [dbo].[MST_Student].[Address],
	    [dbo].[MST_Student].[BirthDate],
	    [dbo].[MST_Student].[Age],
	    [dbo].[MST_Student].[IsActive],
	    [dbo].[MST_Student].[Gender],
	    [dbo].[MST_Student].[Password],
	    [dbo].[MST_Student].[Created],
	    [dbo].[MST_Student].[Modified],
	    [dbo].[MST_Branch].[BranchID],
	    [dbo].[MST_Branch].[BranchName],
	    [dbo].[MST_Branch].[BranchCode],
	    [dbo].[LOC_City].[CityID],
	    [dbo].[LOC_City].[CityName],
	    [dbo].[LOC_City].[Citycode]


FROM [dbo].[MST_Student]

INNER JOIN [LOC_City]
ON [MST_Student].CityID = [LOC_City].CityID

INNER JOIN [MST_Branch]
ON [MST_Student].BranchID = [MST_Branch].BranchID

WHERE [dbo].[MST_Student].[StudentID] = @StudentID

ORDER BY [dbo].[MST_Student].[StudentName],[dbo].[MST_Branch].[BranchName],[dbo].[LOC_City].[CityName]

--Insert Into Student--
--EXEC PR_Student_Insert 3,32,'YASH',9428296165,'YASHKHOKHAR28@GMAIL.COM',9898701545,'7-ANKUR NAGAR','2004-07-26',18,1,'MALE','KKR@28'
ALTER PROC [dbo].[PR_Student_Insert]
@BranchID			INT,
@CityID				INT,
@StudentName		VARCHAR(100),
@MobileNoStudent	BIGINT,
@Email				VARCHAR(100),
@MobileNoFather		BIGINT,
@Address			VARCHAR(100),
@BirthDate			DATETIME,
@Age				INT,
@IsActive			BIT,
@Gender				VARCHAR(100),
@Password			VARCHAR(100),
@Created			DATETIME,
@Modified			DATETIME

AS

INSERT INTO [dbo].[MST_Student]
(
	[BranchID],		
	[CityID],			
	[StudentName],	
	[MobileNoStudent],
	[Email],	
	[MobileNoFather],	
	[Address],		
	[BirthDate],		
	[Age],			
	[IsActive],	
	[Gender],			
	[Password],
	[Created],
	[Modified]

)
VALUES
(
	@BranchID,		
	@CityID,			
	@StudentName,	
	@MobileNoStudent,
	@Email,			
	@MobileNoFather,	
	@Address,		
	@BirthDate,		
	@Age,			
	@IsActive,		
	@Gender,		
	@Password,
	ISNULL(@Created,GETDATE()),
	ISNULL(@Modified,GETDATE())
)


--Update Student--
--EXEC PR_Student_UpdateByPK
ALTER PROC [dbo].[PR_Student_UpdateByPK]
@StudentID			INT,
@BranchID			INT,
@CityID				INT,
@StudentName		VARCHAR(100),
@MobileNoStudent	BIGINT,
@Email				VARCHAR(100),
@MobileNoFather		BIGINT,
@Address			VARCHAR(100),
@BirthDate			DATETIME,
@Age				INT,
@IsActive			BIT,
@Gender				VARCHAR(100),
@Password			VARCHAR(100),
@Modified			DATETIME

AS

UPDATE [dbo].[MST_Student]

SET	[BranchID] = @BranchID,		
	[CityID] = @CityID,			
	[StudentName] = @StudentName,	
	[MobileNoStudent] = @MobileNoStudent,
	[Email] = @Email,	
	[MobileNoFather] = @MobileNoFather,	
	[Address] = @Address,		
	[BirthDate] = @BirthDate,		
	[Age] = @Age,			
	[IsActive] = @IsActive,	
	[Gender] = @Gender,			
	[Password] = @Password,
	[Modified] = ISNULL(@Modified,GETDATE())
	
	
WHERE [dbo].[MST_Student].[StudentID] = @StudentID


--Delete Student--
--EXEC PR_Student_DeleteByPK 2
ALTER PROC [dbo].[PR_Student_DeleteByPK]
@StudentID		INT
AS
DELETE FROM [dbo].[MST_Student]
WHERE [dbo].[MST_Student].[StudentID] = @StudentID
