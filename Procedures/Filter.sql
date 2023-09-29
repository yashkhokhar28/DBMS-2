--EXEC PR_CountryFilter
ALTER PROCEDURE [dbo].[PR_CountryFilter]
@CountryData VARCHAR(100) = NULL

As
SELECT		[dbo].[LOC_Country].[CountryID],
			[dbo].[LOC_Country].[CountryName],
			[dbo].[LOC_Country].[CountryCode],
			[dbo].[LOC_Country].[Created],
			[dbo].[LOC_Country].[Modified]
FROM [dbo].[LOC_Country]
Where
(
		(@CountryData IS NULL OR CountryName LIKE CONCAT('%',@CountryData,'%')) OR
		(@CountryData IS NULL OR CountryCode LIKE CONCAT('%',@CountryData,'%')) 
)

--EXEC PR_StateFilter
ALTER PROCEDURE [dbo].[PR_StateFilter]
@CountryID	INT = NULL,
@StateName varchar(100) = NULL,
@StateCode varchar(100) = NULL

As
SELECT		[dbo].[LOC_State].[StateID],
			[dbo].[LOC_State].[StateName],
			[dbo].[LOC_State].[StateCode],
			[dbo].[LOC_State].[CountryID],
			[dbo].[LOC_Country].[CountryName],
			[dbo].[LOC_State].[Created],
			[dbo].[LOC_State].[Modified]
	FROM [dbo].[LOC_State]
	
	INNER JOIN [dbo].[LOC_Country]
	ON [dbo].[LOC_Country].[CountryID] = [dbo].[LOC_State].[CountryID]
	Where (
		(@CountryID IS NULL OR [dbo].[LOC_State].[CountryID] = @CountryID) AND
		(@StateName IS NULL OR StateName LIKE CONCAT('%',@StateName,'%')) AND
		(@StateCode IS NULL OR StateCode LIKE CONCAT('%',@StateCode,'%'))
		)

--PR_City_SelectByCityName null
CREATE PROC [dbo].[PR_CityFilter]
	@CountryID	INT = NULL,
	@StateID	INT = NULL,
	@CityName	VARCHAR(100) = NULL,
	@CityCode	VARCHAR(100) = NULL
AS
	SELECT  [dbo].[LOC_City].[CityID],
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
	Where (
		(@CountryID IS NULL OR [dbo].[LOC_City].[CountryID] = @CountryID) AND
		(@StateID IS NULL OR [dbo].[LOC_City].[StateID] = @StateID) AND
		(@CityName IS NULL OR StateName LIKE CONCAT('%',@CityName,'%')) AND
		(@CityCode IS NULL OR StateCode LIKE CONCAT('%',@CityCode,'%'))
		)

-- EXEC PR_SelectByBranchName NULL,null
ALTER PROC [dbo].[PR_BranchFilter]
@BranchName varchar(100) = NULL,
@BranchCode varchar(100) = NULL
AS

SELECT	[dbo].MST_Branch.[BranchID],
		[dbo].MST_Branch.[BranchName],
		[dbo].MST_Branch.[BranchCode],
		[dbo].MST_Branch.[Created],
		[dbo].MST_Branch.[Modified]
		
FROM [dbo].MST_Branch
Where (
		(@BranchName IS NULL OR BranchName LIKE CONCAT('%',@BranchName,'%')) OR
		(@BranchCode IS NULL OR BranchCode LIKE CONCAT('%',@BranchCode,'%'))
		)

--EXEC PR_SelectByStudent NULL
ALTER PROC [dbo].[PR_StudentFilter]
	@BranchID		INT = NULL,
	@CityID			INT = NULL,
	@StudentName	VARCHAR(100) = NULL
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

Where (
		(@BranchID IS NULL OR [dbo].[MST_Branch].[BranchID] = @BranchID) AND
		(@CityID IS NULL OR [dbo].[LOC_City].CityID = @CityID) AND
		(@StudentName IS NULL OR StudentName LIKE CONCAT('%',@StudentName,'%'))
		)
