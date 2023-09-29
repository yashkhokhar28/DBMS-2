--SeleceAll Branch--
--EXEC PR_Branch_SelectAll
CREATE PROC [dbo].[PR_Branch_SelectAll]
AS

SELECT	[dbo].MST_Branch.[BranchID],
		[dbo].MST_Branch.[BranchName],
		[dbo].MST_Branch.[BranchCode],
		[dbo].MST_Branch.[Created],
		[dbo].MST_Branch.[Modified]
		
FROM [dbo].MST_Branch

ORDER BY [dbo].MST_Branch.[BranchName]


--SelectByPK Branch--
--EXEC PR_Branch_SelectByPK 2
CREATE PROC [dbo].[PR_Branch_SelectByPK] 
@BranchID INT
AS

SELECT	[dbo].MST_Branch.[BranchID],
		[dbo].MST_Branch.[BranchName],
		[dbo].MST_Branch.[BranchCode],
		[dbo].MST_Branch.[Created],
		[dbo].MST_Branch.[Modified]

FROM [dbo].MST_Branch

WHERE [dbo].MST_Branch.[BranchID] = @BranchID

ORDER BY [dbo].MST_Branch.[BranchName]

--Insert Into Branch--
--EXEC PR_Branch_Insert 'Computer','CE'
ALTER PROC [dbo].[PR_Branch_Insert]
@BranchName		VARCHAR(100),
@BranchCode		VARCHAR(100),
@Created		DATETIME,
@Modified		DATETIME


AS

INSERT INTO [dbo].MST_Branch
(
		[BranchName],
		[BranchCode],
		[Created],
		[Modified]
)
VALUES
(
		@BranchName,
		@BranchCode,
		ISNULL(@Created,GETDATE()),
		ISNULL(@Modified,GETDATE())
)


--Update Branch--
--EXEC PR_Branch_UpdateByPK
ALTER PROC [dbo].[PR_Branch_UpdateByPK]
@BranchID			INT,
@BranchName		VARCHAR(100),
@BranchCode		VARCHAR(100),
@Modified		DATETIME

AS

UPDATE [dbo].MST_Branch

SET	[BranchName] = @BranchName,
	[BranchCode] = @BranchCode,
	[Modified] = ISNULL(@Modified,GETDATE())
	
WHERE [dbo].MST_Branch.[BranchID] = @BranchID


--Delete Branch--
--EXEC PR_Branch_DeleteByPK 2
CREATE PROC [dbo].[PR_Branch_DeleteByPK]
@BranchID		INT
AS
DELETE FROM [dbo].MST_Branch
WHERE [dbo].MST_Branch.[BranchID] = @BranchID
