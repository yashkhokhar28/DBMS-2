CREATE DATABASE PersonInfo_335;

--From the above given table perform the following queries:
--1. Print message like - Error Occur that is: Divide by zero error encountered.
BEGIN
	TRY
	SELECT 1/0;
	END TRY

	BEGIN CATCH 
		SELECT 'Error Occur that is:' +ERROR_MESSAGE() AS ERROR_MSG;
	END CATCH;

--2. Print error message in insert statement using Error_Message () function: Conversion failed when
--converting datetime from character string.
BEGIN
	TRY
		DECLARE @VALUE VARCHAR(100) = '09/04/2004 06:06:06'
		SELECT CONVERT(datetime,@VALUE,101) AS CONVERSION
	END TRY
	BEGIN CATCH 
		SELECT ERROR_MESSAGE() AS ERROR_MSG
	END CATCH;

--3. Create procedure which prints the error message that “The PLogID is already taken. Try another
--one”.
CREATE PROCEDURE PLog_Table
	@PLogID int,
	@PersonName varchar(50)
AS
BEGIN
	BEGIN TRY
		INSERT INTO PersonLog VALUES (@PLogID,@PersonName,'INSERT',GETDATE());
	END TRY
	BEGIN CATCH 
		PRINT 'The PLogID is already taken. Try another one'
	END CATCH
END;

EXEC PLog_Table 1,abhi
SELECT * FROM PersonLog;	
	
--4. Create procedure that print the sum of two numbers: take both number as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.
ALTER PROCEDURE ADDITION
	@NO1 VARCHAR(10),
	@NO2 INT,
	@RESULT INT OUTPUT
	AS
	BEGIN
		BEGIN TRY
			SET @RESULT = @NO2 + @NO1 ;
		END TRY

		BEGIN CATCH
			SELECT 
				ERROR_NUMBER() AS [ERROR NUMBER],
				ERROR_SEVERITY() AS [ERROR SEVERITY],
				ERROR_STATE() AS [ERROR STATE],
				ERROR_PROCEDURE() AS [ERROR PROCEDURE],
				ERROR_MESSAGE() AS [ERROR MESSAGE],
				ERROR_LINE() AS [ERROR LINE]
			END CATCH
		END;

DECLARE @R INT;
EXEC ADDITION 3,2, @R OUTPUT;
PRINT @R;

--5. Throw custom exception using stored procedure which accepts PLogID as input & that throws
--Error like no plogid is available in database.
	CREATE PROCEDURE FIND_PLOGID
		@PLogID INT

		AS
		BEGIN
			BEGIN TRY
				SELECT @PLogID FROM PersonLog
			END TRY
			
			BEGIN CATCH
				PRINT 'no plogid is available in database' 
			END CATCH
		END;
EXEC FIND_PLOGID 500	
--6. Create cursor with name per_cursor which takes PLogID & PersonName as variable and produce
--combine output with PLogID & Person Name.
DECLARE
	@PLogID INT,
	@PersonName varchar(250)
	DECLARE PERSON_CURSOR CURSOR
		FOR SELECT
			PLogID,PersonName
		FROM
			PersonLog
	OPEN PERSON_CURSOR;
	FETCH NEXT FROM PERSON_CURSOR INTO
	@PLogID,
	@PersonName
WHILE @@FETCH_STATUS=0
BEGIN
	PRINT CAST(@PLogID AS VARCHAR)+ '-' + @PersonName;
	FETCH NEXT FROM PERSON_CURSOR INTO
	@PLogID,
	@PersonName
	END
CLOSE PERSON_CURSOR
DEALLOCATE PERSON_CURSOR

--7. Use Table Student (Id, Rno, EnrollmentNo, Name, Branch, University) - Create cursor that updates
--enrollment column as combination of branch & Roll No. like SOE22CE0001 and so on. (22 is
--admission year)

CREATE TABLE STUDENT
(	ID INT,
	ROLLNO INT,
	ENROLLMENTNO VARCHAR(50),
	NAME VARCHAR(50),
	BRANCH VARCHAR(50),
	UNIVERSITY VARCHAR(50)
)
DECLARE 
	@ROLLNO INT,
	@BRANCH VARCHAR(50)
		DECLARE STUDENT_CURSOR CURSOR
			FOR SELECT 
				ROLLNO,BRANCH
			FROM 
				STUDENT
		OPEN STUDENT_CURSOR;
		FETCH NEXT FROM STUDENT_CURSOR INTO
		@ROLLNO,
		@BRANCH
			WHILE @@FETCH_STATUS=0
				BEGIN
					UPDATE STUDENT
						SET ENROLLMENTNO = 'SOE'+CAST(22 AS varchar)+CAST(@BRANCH AS varchar)+CAST(@ROLLNO AS varchar)
						WHERE ROLLNO = @ROLLNO;
					FETCH NEXT FROM STUDENT_CURSOR INTO
		@ROLLNO,
		@BRANCH
	END
CLOSE STUDENT_CURSOR
DEALLOCATE STUDENT_CURSOR
INSERT INTO STUDENT VALUES (1,329,210101101097,'ABHI','CSE','DU')
SELECT * FROM STUDENT;