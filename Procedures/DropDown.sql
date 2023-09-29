--EXEC PR_Country_ComboBox
CREATE PROCEDURE [dbo].[PR_Country_ComboBox]
AS
SELECT	[dbo].[LOC_Country].[CountryID],
		[dbo].[LOC_Country].[CountryName]
FROM [dbo].[LOC_Country]


--EXEC PR_State_ComboBox
CREATE PROCEDURE [dbo].[PR_State_ComboBox]
AS
SELECT	[dbo].[LOC_State].[StateID],
		[dbo].[LOC_State].[StateName]
FROM [dbo].[LOC_State]

--EXEC PR_City_ComboBox
CREATE PROCEDURE [dbo].[PR_City_ComboBox]
AS
SELECT	[dbo].[LOC_City].[CityID],
		[dbo].[LOC_City].[CityName]
FROM [dbo].[LOC_City]

--EXEC PR_Branch_ComboBox
CREATE PROCEDURE [dbo].[PR_Branch_ComboBox]
AS
SELECT	[dbo].[MST_Branch].[BranchID],
		[dbo].[MST_Branch].[BranchName]
FROM [dbo].[MST_Branch]

--EXEC PR_LOC_State_SelectComboBoxByCountryName 45
CREATE PROCEDURE [dbo].[PR_LOC_State_SelectComboBoxByCountryName]
@CountryID INT
AS
SELECT	[dbo].[LOC_State].[StateID],
		[dbo].[LOC_State].[StateName]
FROM [dbo].[LOC_State]
WHERE [dbo].[LOC_State].[CountryID] = @CountryID

