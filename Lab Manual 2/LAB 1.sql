CREATE DATABASE PERSON_INFO_335_2


--From the above given table perform the following queries:

--1. Create INSERT, UPDATE & DELETE Stored Procedures for Person table.

	--INSERT PROCEDURE--
	CREATE PROCEDURE PR_INSERT
	@PERSONID				INT,
	@PERSONNAME				VARCHAR(50),
	@SALARY					DECIMAL(8,2),
	@JOININGDATE			DATETIME,
	@CITY					VARCHAR(100),
	@AGE					INT,
	@BIRTHDATE				DATETIME

	AS
	BEGIN 

	INSERT INTO PERSON
	(
		PERSONID,	
		PERSONNAME,	
		SALARY,		
		JOININGDATE,
		CITY,		
		AGE,		
		BIRTHDATE	
	)
	 VALUES
	(
		@PERSONID,	
		@PERSONNAME,	
		@SALARY,		
		@JOININGDATE,
		@CITY,		
		@AGE,		
		@BIRTHDATE	
	)
	END	;
	EXEC PR_INSERT 105,'YASH k',10000,'26-JULY-04','RAJKOT',18,'10-JAN-10'

	--UPDATE PROCEDURE--

	CREATE PROCEDURE PR_UPDATE
	@PERSONID				INT,
	@PERSONNAME				VARCHAR(50),
	@SALARY					DECIMAL(8,2),
	@JOININGDATE			DATETIME,
	@CITY					VARCHAR(100),
	@AGE					INT,
	@BIRTHDATE				DATETIME

	AS
	BEGIN 

	UPDATE PERSON
	SET 	
		PERSONNAME = @PERSONNAME,
		SALARY = @SALARY,
		JOININGDATE = @JOININGDATE,
		CITY = @CITY,
		AGE = @AGE,
		BIRTHDATE = @BIRTHDATE	

		WHERE PERSONID = @PERSONID;
	 
	END	;

	--DELETE PROCEDURE--

	CREATE PROCEDURE PR_DELETE
	@PERSONID INT
	AS
	BEGIN
		DELETE FROM PERSON 
		WHERE PERSONID = @PERSONID;
		END;
		
--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that,
--create a new table PersonLog to log (enter) all operations performed on the Person table.
 
	--INSERT TRIGGER--
CREATE TRIGGER TRG_PERSON_INSERT
ON PERSON
AFTER INSERT
AS
BEGIN
	DECLARE @PERSONID INT,
			@PERSONNAME VARCHAR(250)
			SELECT @PERSONID = PERSONID FROM INSERTED 
			SELECT @PERSONNAME = PERSONNAME FROM INSERTED
			
			INSERT INTO PERSONLOG VALUES
			(
			@PERSONID,
			@PERSONNAME,
			'INSERTED',
			CAST(GETDATE() AS VARCHAR(20))
			) 
			END;

		--UPDATE TRIGGER--
CREATE TRIGGER TRG_PERSON_UPDATE
ON PERSON
FOR UPDATE
AS
BEGIN
	DECLARE @PERSONID INT,
			@PERSONNAME VARCHAR(250)
			SELECT @PERSONID = PERSONID FROM INSERTED 
			SELECT @PERSONNAME = PERSONNAME FROM INSERTED
			
			INSERT INTO PERSONLOG VALUES
			(
			@PERSONID,
			@PERSONNAME,
			'UPDATED',
			CAST(GETDATE() AS VARCHAR(20))
			) 
			END;

		--DELETE TRIGGER--
CREATE TRIGGER TRG_PERSON_DELETE
ON PERSON
FOR DELETE
AS
BEGIN
	DECLARE @PERSONID INT,
			@PERSONNAME VARCHAR(250)
			SELECT @PERSONID = PERSONID FROM deleted 
			SELECT @PERSONNAME = PERSONNAME FROM deleted
			
			INSERT INTO PERSONLOG VALUES
			(
			@PERSONID,
			@PERSONNAME,
			'DELETED',
			CAST(GETDATE() AS VARCHAR(20))
			) 
			END;

			SELECT * FROM PERSONLOG
			
--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person
--table. For that, log all operation performed on the Person table into PersonLog.

		--INSTEAD OF INSERT--

		DROP TRIGGER INSERT_PERSON_INSTED
		ON PERSON
		INSTEAD OF INSERT
		AS
		BEGIN
		DECLARE @PERSONID INT,
				@PERSONNAME VARCHAR(250)
				SELECT @PERSONID = PERSONID FROM inserted 
				SELECT @PERSONNAME = PERSONNAME FROM inserted

				INSERT INTO PERSONLOG VALUES
				(
					@PERSONID,
					@PERSONNAME,
					'INSERTED',
					CAST(GETDATE() AS VARCHAR(20))
				) 
			END;

			EXEC PR_INSERT 329,'ABHI',1000,'01-SEP-22','MORBI',18,'04-SEP-04'

			SELECT * FROM PERSON;

			SELECT * FROM PERSONLOG;

			--INSTEAD OF UPDATE--

		CREATE TRIGGER INSERT_PERSON_UPDATE
			ON PERSON
			FOR UPDATE
			AS
			BEGIN
			DECLARE @PERSONID INT,
			@PERSONNAME VARCHAR(250)
			SELECT @PERSONID = PERSONID FROM INSERTED 
			SELECT @PERSONNAME = PERSONNAME FROM INSERTED
			
			INSERT INTO PERSONLOG VALUES
			(
			@PERSONID,
			@PERSONNAME,
			'UPDATED',
			CAST(GETDATE() AS VARCHAR(20))
			) 
			END;
			UPDATE PERSON SET PERSONNAME='ABHI KANJIA' WHERE PERSONNAME = 'ABHI'

			SELECT * FROM PERSON;

			SELECT * FROM PERSONLOG;

			--INSTEAD OF DELETE--
			CREATE TRIGGER INSERT_PERSON_DELETE
			ON PERSON
			INSTEAD OF DELETE
			AS
			BEGIN
				DECLARE @PERSONID INT,
						@PERSONNAME VARCHAR(250)
			SELECT @PERSONID = PERSONID FROM deleted 
			SELECT @PERSONNAME = PERSONNAME FROM deleted
			
			INSERT INTO PERSONLOG VALUES
			(
			@PERSONID,
			@PERSONNAME,
			'DELETED',
			CAST(GETDATE() AS VARCHAR(20))
			) 
			END;

			EXEC PR_DELETE 329

--4. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints
--�Record deleted successfully from PersonLog�.

	CREATE TRIGGER TRG_DELETE_PERSONLOG
	ON PERSONLOG
	FOR DELETE
	AS
	BEGIN
			DECLARE @PERSONID INT
			SELECT @PERSONID = PERSONID FROM deleted 

			PRINT 'Record deleted successfully from PersonLog';
	END;

	DELETE FROM PERSONLOG WHERE PERSONID = 105
--5. Create INSERT trigger on person table, which calculates the age and update that age in Person
--table.

CREATE TRIGGER TRG_PERSON_AGE_INSERT
ON PERSON
AFTER INSERT
AS
BEGIN
	DECLARE @AGE INT,@BIRTHDATE DATETIME
			SELECT @BIRTHDATE = BIRTHDATE FROM inserted 
			SELECT @AGE = AGE FROM inserted
			SET @AGE = CONVERT(INT,DATEDIFF(YEAR,@BIRTHDATE,GETDATE()))
			UPDATE PERSON
			SET AGE = @AGE
			WHERE BIRTHDATE = @BIRTHDATE
			END;

			EXEC PR_INSERT 999,'ABHI K',10001,'01-SEP-21','MORbI',0,'04-SEP-04';

			delete from PERSONLOG
			where PERSONID = 329