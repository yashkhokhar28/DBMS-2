--SeleceAll City--
--EXEC PR_City_SelectAll
ALTER PROC [dbo].[PR_City_SelectAll]
AS

SELECT	[dbo].[LOC_City].[CityID],
		[dbo].[LOC_City].[CityName],
		[dbo].[LOC_City].[Citycode],
		[dbo].[LOC_City].[StateID],
		[dbo].[LOC_State].[StateName],
		[dbo].[LOC_City].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_City].[CreationDate],
		[dbo].[LOC_City].[Modified]
		
FROM [dbo].[LOC_City]

INNER JOIN [dbo].[LOC_State]
ON [dbo].[LOC_State].[StateID] = [dbo].[LOC_City].[StateID]

INNER JOIN [dbo].[LOC_Country]
ON [dbo].[LOC_State].[CountryID] = [dbo].[LOC_Country].[CountryID]

ORDER BY [dbo].[LOC_Country].[CountryName],[dbo].[LOC_State].[StateName],[dbo].[LOC_City].[CityName]


--SelectByPK City--
--EXEC PR_City_SelectByPK 2
ALTER PROC [dbo].[PR_City_SelectByPK] 
@CityID INT
AS

SELECT	[dbo].[LOC_City].[CityID],
		[dbo].[LOC_City].[CityName],
		[dbo].[LOC_City].[Citycode],
		[dbo].[LOC_City].[StateID],
		[dbo].[LOC_State].[StateName],
		[dbo].[LOC_City].[CountryID],
		[dbo].[LOC_Country].[CountryName],
		[dbo].[LOC_City].[CreationDate],
		[dbo].[LOC_City].[Modified]

FROM [dbo].[LOC_City]

INNER JOIN [dbo].[LOC_State]
ON [dbo].[LOC_State].[StateID] = [dbo].[LOC_City].[StateID]

INNER JOIN [dbo].[LOC_Country]
ON [dbo].[LOC_Country].[CountryID] = [dbo].[LOC_State].[CountryID]

WHERE [dbo].[LOC_City].[CityID] = @CityID

ORDER BY [dbo].[LOC_Country].[CountryName],[dbo].[LOC_State].[StateName],[dbo].[LOC_City].[CityName]

--Insert Into City--
--EXEC PR_City_Insert 'Rajkot','RJT',8,85
ALTER PROC [dbo].[PR_City_Insert]
@CityName		VARCHAR(100),
@Citycode		VARCHAR(100),
@StateID		INT,
@CountryID		INT,
@CreationDate	DATETIME,
@Modified		DATETIME

AS

INSERT INTO [dbo].[LOC_City]
(
		[CityName],
		[Citycode],
		[StateID],
		[CountryID],
		[CreationDate],
		[Modified]
)
VALUES
(
		@CityName,
		@Citycode,
		@StateID,
		@CountryID,
		ISNULL(@CreationDate,getdate()),
		ISNULL(@Modified,getdate())
)


--Update City--
--EXEC PR_City_UpdateByPK
ALTER PROC [dbo].[PR_City_UpdateByPK]
@CityID			INT,
@CityName		VARCHAR(100),
@Citycode		VARCHAR(100),
@StateID		INT,
@CountryID		INT,
@Modified			DATETIME

AS

UPDATE [dbo].[LOC_City]

SET	[CityName] = @CityName,
	[Citycode] = @Citycode,
	[StateID]= @StateID,		
	[CountryID] = @CountryID,
	[Modified] = ISNULL(@Modified,GETDATE())
	
WHERE [dbo].[LOC_City].[CityID] = @CityID


--Delete State--
--EXEC PR_City_DeleteByPK 2
CREATE PROC [dbo].[PR_City_DeleteByPK]
@CityID		INT
AS
DELETE FROM [dbo].[LOC_City]
WHERE [dbo].[LOC_City].[CityID] = @CityID
