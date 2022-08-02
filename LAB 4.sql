--• Stored Procedures

SELECT * FROM Department;
SELECT * FROM Designation;
SELECT * FROM PERSON;

--Insert Department

	CREATE PROCEDURE PR_DEPARTMENT_INSERT
	@DepartmentID  int,
	@DepartmentName varchar(100)
	AS
	BEGIN
	INSERT INTO Department(DepartmentID,DepartmentName)
	VALUES
		(@DepartmentID,@DepartmentName)

		END;
	EXEC  PR_DEPARTMENT_INSERT 1,'Admin';
	EXEC  PR_DEPARTMENT_INSERT 2,'IT';
	EXEC  PR_DEPARTMENT_INSERT 3,'HR';
	EXEC  PR_DEPARTMENT_INSERT 4,'Account';

	--Insert Designation

	CREATE PROCEDURE PR_DESIGNATION_INSERT
	@DesignationID int,
	@DesignationName varchar(100)
	AS
	BEGIN
	INSERT INTO Designation(DesignationID,DesignationName)
	VALUES
		(@DesignationID,@DesignationName)
	END;

	EXEC PR_DESIGNATION_INSERT 11,'Jobber';
	EXEC PR_DESIGNATION_INSERT 12,'Welder';
	EXEC PR_DESIGNATION_INSERT 13,'Clerk';
	EXEC PR_DESIGNATION_INSERT 14,'Manager';
	EXEC PR_DESIGNATION_INSERT 15,'CEO';

	--Insert Person

	CREATE PROCEDURE PR_PERSON_INSERT
	@FirstName		varchar(100),
	@LastName		varchar(100),
	@Salary			decimal(8,2),
	@JoiningDate	datetime,
	@DepartmentID	int,
	@DesignationID	int
	AS
	BEGIN
	INSERT INTO Person(FirstName,LastName,Salary,JoiningDate,DepartmentID,DesignationID)
	VALUES
	(@FirstName,		
	@LastName,		
	@Salary,			
	@JoiningDate,	
	@DepartmentID,
	@DesignationID)
	END;	

	EXEC PR_PERSON_INSERT 'Rahul','Anshu',56000,'01-JAN-90',1,12;
	EXEC PR_PERSON_INSERT 'Hardik','Hinsu',18000,'25-SEP-90',2,11;
	EXEC PR_PERSON_INSERT 'Bhavin','Kamani',25000,'14-MAY-90',NULL,11;
	EXEC PR_PERSON_INSERT 'Bhoomi','Patel',39000,'20-FEB-90',1,13;
	EXEC PR_PERSON_INSERT 'Rohit','Rajgor',17000,'23-JULY-90',2,15;
	EXEC PR_PERSON_INSERT 'Priya','Mehta',25000,'18-OCT-90',2,NULL;
	EXEC PR_PERSON_INSERT 'Neha','Trevedi',18000,'20-FEB-90',3,15;

	--Update Department

	CREATE PROCEDURE PR_Department_UPDATE
	(
	@DepartmentID int,
	@DepartmentName varchar(100)
	)
	AS
	BEGIN
	UPDATE Department
	SET   DepartmentName = @DepartmentName
		 WHERE  DepartmentID = @DepartmentID
		 END;

		 EXEC  PR_Department_UPDATE 1,'ADMIN1';

	--Update Designation
	CREATE PROCEDURE PR_Designation_UPDATE
	(
	@DesignationID int,
	@DesignationName varchar(100)
	)
	AS
	BEGIN
	UPDATE Designation
	SET DesignationName = @DesignationName
		WHERE DesignationID = @DesignationID 
		END;
		--Update Person

		CREATE PROCEDURE PR_PERSON_UPDATE
		( 
		@WorkerID		int,
		@FirstName		varchar(100),
		@LastName		varchar(100),
		@Salary			decimal(8,2),
		@JoiningDate	datetime,
		@DepartmentID	int,
		@DesignationID	int
		)
		AS
		BEGIN
		UPDATE Person
		SET 	
		FirstName  =@FirstName,	
		LastNamE  =@LastName,	
		Salary = @Salary,	
		JoiningDate = @JoiningDate,	
		DepartmentID = @DepartmentID,
		DesignationID = @DesignationID
		WHERE WorkerID = @WorkerID
		END;
		EXEC  PR_PERSON_UPDATE 103,'Bhavin','Kamani',25000,'14-MAY-91',NULL,11;
		EXEC  PR_PERSON_UPDATE 104,'Bhoomi','Pate',39000,'27-JULY-14',1,13;
		EXEC  PR_PERSON_UPDATE 107,'Neha','Trivedi',18000,'20-FEB-14',3,15;

		--DELETE DEPARTMENT

		CREATE PROCEDURE PR_DEPARTMENT_DELETE
		@DepartmentID INT
		AS 
		BEGIN
		DELETE FROM Department 
		WHERE DepartmentID = @DepartmentID
		END;

		EXEC PR_DEPARTMENT_DELETE 4

		--DELETE DESIGNATION

		CREATE PROCEDURE PR_DESIGNATIOIN_DELETE
		@DesignationId INT
		AS
		BEGIN
		DELETE FROM Designation
		WHERE DesignationID = @DesignationId
		END;

		EXEC PR_DESIGNATIOIN_DELETE 3

		--DELETE PERSON

		CREATE PROCEDURE PR_PERSON_DELETE
		@WorkerId INT
		AS
		BEGIN
		DELETE FROM Person
		WHERE WorkerID = @WorkerId
		END;

		EXEC PR_PERSON_DELETE 103
		EXEC PR_PERSON_DELETE 107
		EXEC PR_PERSON_DELETE 110
		EXEC PR_PERSON_DELETE 112
		EXEC PR_PERSON_DELETE 109
		EXEC PR_PERSON_DELETE 113

--2. All tables SelectAll (If foreign key is available than do write join and take columns on select list)

CREATE PROCEDURE PR_PERSON_SELECTALL
AS
BEGIN
	SELECT	WorkerID,
			FirstName,
			LastName,
			Salary,
			JoiningDate,
			Person.DepartmentID,
			Person.DesignationID,
			Department.DepartmentName,
			Designation.DesignationName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			END;

		EXEC PR_PERSON_SELECTALL

--3. All tables SelectPK

CREATE PROCEDURE PR_PERSON_SELECTBYPK
AS
BEGIN
	SELECT	Person.WorkerID,
			Department.DepartmentID,
			Designation.DesignationID
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			END;
			
		EXEC PR_PERSON_SELECTBYPK

--4. Create Procedure that takes Department Name & Designation Name as Input and Returns a
--table with Worker’s First Name, Salary, Joining Date & Department Name.

CREATE PROCEDURE PR_SELECT_BY_DEP_DES
@DepartmentName		Varchar(100),
@DesignationName	Varchar(100) 
AS 
BEGIN
	SELECT	FirstName,
			Salary,
			JoiningDate,
			Department.DepartmentName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			WHERE	DepartmentName = @DepartmentName AND
					DesignationName = @DesignationName
			END;

			EXEC PR_SELECT_BY_DEP_DES 'ADMIN1','Welder'

--5. Create Procedure that takes FirstName as an input parameter and displays’ all the details of
--the worker with their department & designation name.

ALTER PROCEDURE PR_PERSON_ALL_DETAIL
@FirstName	Varchar(100)
AS
BEGIN
	SELECT	WorkerID,
			FirstName,
			LastName,
			Salary,
			JoiningDate,
			Person.DepartmentID,
			Person.DesignationID,
			Department.DepartmentName,
			Designation.DesignationName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			WHERE	FirstName = @FirstName
			END;

			EXEC PR_PERSON_ALL_DETAIL 'RAHUL'


--6. Create Procedure which displays department wise maximum, minimum & total salaries.

CREATE PROCEDURE PR_PERSON_MIN_MAX
AS
BEGIN
	SELECT	Department.DepartmentName,
			MAX(Salary) AS MAX_SALARY,
			MIN(Salary) AS MIN_SALARY,
			SUM(Salary) AS TOTAL_SALARY

			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			GROUP BY DepartmentName
			END;

	EXEC PR_PERSON_MIN_MAX


	---- • Views -------

--1. Create a view that display first 100 workers details.

CREATE VIEW VW_PERSON_DETAILS
AS
	SELECT TOP 100 
			WorkerID,
			FirstName,
			LastName,
			Salary,
			JoiningDate,
			Person.DepartmentID,
			Person.DesignationID,
			Department.DepartmentName,
			Designation.DesignationName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID

			SELECT * FROM VW_PERSON_DETAILS


--2. Create a view that displays designation wise maximum, minimum & total salaries.

CREATE VIEW VW_PR_PERSON_MIN_MAX
AS
	SELECT	Designation.DesignationName,
			MAX(Salary) AS MAX_SALARY,
			MIN(Salary) AS MIN_SALARY,
			SUM(Salary) AS TOTAL_SALARY

			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			GROUP BY DesignationName

			SELECT * FROM VW_PR_PERSON_MIN_MAX

--3. Create a view that displays Worker’s first name with their salaries & joining date, it also displays
--duration column which is difference of joining date with respect to current date.

CREATE VIEW VW_WORKER
AS
	SELECT	FirstName,
			Salary,
			JoiningDate,
			DATEDIFF(YEAR,JoiningDate,getdate()) AS DURATION
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			
			SELECT * FROM VW_WORKER

--4. Create a view which shows department & designation wise total number of workers.

CREATE VIEW VW_COUNT_WORKER
AS
	SELECT	COUNT(WorkerId) AS TOTAL_WORKER,
			Designation.DesignationName,
			Department.DepartmentName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			GROUP BY DepartmentName,DesignationName

			SELECT * FROM VW_COUNT_WORKER
			
--5. Create a view that displays worker names who don’t have either in any department or
--designation.CREATE VIEW VW_NULL_WORKERAS	SELECT FirstName	FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			WHERE Person.DesignationID IS NULL OR Person.DepartmentID IS NULL;

			SELECT * FROM VW_NULL_WORKER


			---• User Defined Functions---
--1. Create a table valued function which accepts DepartmentID as a parameter & returns a worker
--table based on DepartmentID.

ALTER  FUNCTION F_WORKER(@DepartmentId INT)
RETURNS TABLE
AS

RETURN (SELECT 
			WorkerID,
			FirstName,
			LastName,
			Salary,
			JoiningDate,
			Person.DepartmentID,
			Person.DesignationID,
			Department.DepartmentName,
			Designation.DesignationName
			FROM Person INNER JOIN Department
			ON Person.DepartmentID = Department.DepartmentID
			INNER JOIN Designation
			ON Person.DesignationID = Designation.DesignationID
			WHERE Department.DepartmentID = @DepartmentId
)

SELECT * FROM F_WORKER(1)

--2. Create a table valued function which returns a table with unique city names from worker table.


--3. Create a scalar valued function which accepts two parameters start date & end date, and
--returns a date difference in days.

CREATE FUNCTION F_DATEDIFF_DAYS(@START DATETIME,@END DATETIME)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(DAY,@START,@END)
END;

SELECT dbo.F_DATEDIFF_DAYS('2004-JULY-26','2022-JULY-26');

--4. Create a scalar valued function which accepts two parameters year in integer & month in
--integer and returns total days in passed month & year.


--5. Create a scalar valued function which accepts two parameters year in integer & month in
--integer and returns first date in passed month & year.