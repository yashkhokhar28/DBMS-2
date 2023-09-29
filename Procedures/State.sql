--SeleceAll State--
SELECT * FROM LOC_State
--EXEC PR_State_SelectAll
ALTER PROC [dbo].[PR_State_SelectAll]
AS

SELECT	[dbo].[LOC_State].[StateID],
		[dbo].[LOC_State].[StateName],
		[dbo].[LOC_State].[StateCode],
		[dbo].[LOC_State].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_State].[Created],
		[dbo].[LOC_State].[Modified]
		
FROM [dbo].[LOC_State]

INNER JOIN [dbo].[LOC_Country]
ON [dbo].[LOC_Country].[CountryID] = [dbo].[LOC_State].[CountryID]

ORDER BY [dbo].[LOC_Country].[CountryName],[dbo].[LOC_State].[StateName]


--SelectByPK State--
--EXEC PR_State_SelectByPK 7
ALTER PROC [dbo].[PR_State_SelectByPK]
@StateID INT
AS

SELECT	[dbo].[LOC_State].[StateID],
		[dbo].[LOC_State].[StateName],
		[dbo].[LOC_State].[StateCode],
		[dbo].[LOC_State].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_State].[Created],
		[dbo].[LOC_State].[Modified]

FROM [dbo].[LOC_State]

INNER JOIN [dbo].[LOC_Country]
ON [dbo].[LOC_State].[CountryID] = [dbo].[LOC_Country].[CountryID]

WHERE [dbo].[LOC_State].[StateID] = @StateID

ORDER BY [dbo].[LOC_Country].[CountryName],[dbo].[LOC_State].[StateName]
--Insert Into State--
--EXEC PR_State_Insert 'Gujarat','GJ',119
ALTER PROC [dbo].[PR_State_Insert]
@StateName		VARCHAR(100),
@StateCode		VARCHAR(100),
@CountryID		INT,
@Created		DATETIME,
@Modified		DATETIME

AS

INSERT INTO [dbo].[LOC_State]
(
	[StateName],
	[StateCode],
	[CountryID],
	[Created],
	[Modified]
)
VALUES
(
		@StateName,	
		@StateCode,
		@CountryID,
		ISNULL(@Created,getdate()),
		ISNULL(@Modified,getdate())
)

--Update State--
--EXEC PR_State_UpdateByPK 3,'GUJ','GJ',1
ALTER PROC [dbo].[PR_State_UpdateByPK]
@StateID		INT,
@StateName		VARCHAR(100),
@StateCode		VARCHAR(100),
@CountryID		INT,
@Modified		DATETIME

AS

UPDATE [dbo].[LOC_State]

SET StateName = @StateName,
	StateCode = @StateCode,
	CountryID = @CountryID,
	Modified = ISNULL(@Modified,GETDATE())
			
WHERE [dbo].[LOC_State].[StateID] = @StateID
SELECT * FROM LOC_State


--Delete State--
--EXEC PR_State_DeleteByPK 2
ALTER PROC [dbo].[PR_State_DeleteByPK]
@StateID		INT
AS
DELETE FROM [dbo].[LOC_State]
WHERE [dbo].[LOC_State].[StateID] = @StateID





		
