--SeleceAll Country--
--EXEC PR_Country_SelectAll

ALTER PROC [dbo].[PR_Country_SelectAll]
AS

SELECT	[dbo].[LOC_Country].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_Country].[CountryCode],
		[dbo].[LOC_Country].[Created],
		[dbo].[LOC_Country].[Modified]

FROM [dbo].[LOC_Country]

ORDER BY [dbo].[LOC_Country].[CountryName]

--SelectByPK Country--
--EXEC PR_Country_SelectByPK 2
ALTER PROC [dbo].[PR_Country_SelectByPK]
@CountryID INT
AS

SELECT	[dbo].[LOC_Country].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_Country].[CountryCode],
		[dbo].[LOC_Country].[Created],
		[dbo].[LOC_Country].[Modified]

FROM [dbo].[LOC_Country]

WHERE [dbo].[LOC_Country].[CountryID] = @CountryID

ORDER BY [dbo].[LOC_Country].[CountryName]

--Insert Into Country--
--EXEC PR_Country_Insert 'India','IN'
ALTER PROC [dbo].[PR_Country_Insert]
@CountryName		VARCHAR(100),
@CountryCode		VARCHAR(100),
@Created			DATETIME,
@Modified			DATETIME
AS

INSERT INTO [dbo].[LOC_Country]
(
	[CountryName],
	[CountryCode],
	[Created],
	[Modified]
)
VALUES
(
		@CountryName,	
		@CountryCode,
		ISNULL(@Created,getdate()),
		ISNULL(@Modified,getdate())
)

--Update Country--
--EXEC PR_State_UpdateByPK
DROP PROCEDURE PR_State_UpdateByPK
ALTER PROC [dbo].[PR_Country_UpdateByPK]
@CountryID			INT,
@CountryName		VARCHAR(100),
@CountryCode		VARCHAR(100),
@Modified			DATETIME

AS

UPDATE [dbo].[LOC_Country]

SET	[CountryCode] = @CountryCode,		
	[CountryName] = @CountryName,
	Modified = ISNULL(@Modified,GETDATE())
WHERE [dbo].[LOC_Country].[CountryID] = @CountryID


--Delete State--
--EXEC PR_Country_DeleteByPK 59
ALTER PROC [dbo].[PR_Country_DeleteByPK]
@CountryID		INT
AS
DELETE FROM [dbo].[LOC_Country]
WHERE [dbo].[LOC_Country].[CountryID] = @CountryID


