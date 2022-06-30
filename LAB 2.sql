CREATE DATABASE Employee_Info_335

CREATE TABLE EMPLOYEE
(	
	EID INT,
	ENAME VARCHAR(100),
	GENDER VARCHAR(10),
	JOININGDATE DATETIME,
	SALARY DECIMAL(8,2),
	CITY VARCHAR(100)
)

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES (1,'NICK','MALE','01-JAN-13',4000,'LONDON');
INSERT INTO EMPLOYEE VALUES (2,'JULIAN','FEMALE','01-OCT-14',3000,'NEW YORK');
INSERT INTO EMPLOYEE VALUES (3,'RPY','MALE','01-JUN-16',3500,'LONDON');
INSERT INTO EMPLOYEE VALUES (4,'TOM','MALE',NULL,4500,'LONDON');
INSERT INTO EMPLOYEE VALUES (5,'JERRY','MALE','01-FEB-13',2800,'SYDNEY');
INSERT INTO EMPLOYEE VALUES (6,'PHILIP','MALE','01-JAN-15',7000,'NEW YORK');
INSERT INTO EMPLOYEE VALUES (7,'SARA','FEMALE','01-AUG-17',4800,'SYDNEY');
INSERT INTO EMPLOYEE VALUES (8,'EMILY','FEMALE','01-JAN-15',5500,'NEW YORK');
INSERT INTO EMPLOYEE VALUES (9,'MICHAEL','MALE',NULL,6500,'LONDON');
INSERT INTO EMPLOYEE VALUES (10,'JOHN','MALE','01-JAN-15',8800,'LONDON');

--1. Display all the employees whose name starts with “m” and 4 th character is “h”.

	SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE 'M__H%';

--2. Find the value of 3 raised to 5. Label the column as output.

	SELECT POWER(3,5) AS OUTPUT; 

--3. Write a query to subtract 20 days from the current date.

	SELECT GETDATE()-20;

--4. Write a query to display name of employees whose name starts with “j” and contains “n” in their name.

	SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE 'J%N%';
	 
--5. Display 2nd to 9th character of the given string “SQL Programming”.

	SELECT SUBSTRING('SQL Programming',2,9);

--6. Display name of the employees whose city name ends with “ney” &contains six characters.

	SELECT ENAME FROM EMPLOYEE WHERE CITY LIKE '___NEY';

--7. Write a query to convert value 15 to string.

	SELECT CONVERT(VARCHAR,15);

--8. Add department column with varchar (20) to Employee table.

	ALTER TABLE EMPLOYEE ADD DEPARTMENT Varchar(20);

--9. Set the value of department to Marketing who belongs to London city.

	UPDATE EMPLOYEE SET DEPARTMENT = 'MARKETING' WHERE CITY = 'LONDON';
	 
--10. Display all the employees whose name ends with either “n” or “y”.

	SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE '%N' OR ENAME LIKE '%Y';

--11. Find smallest integer value that is greater than or equal to 63.1, 63.8 and -63.2.

	SELECT FLOOR(63.1),FLOOR(63.8),FLOOR(-63.2);

--12. Display all employees whose joining date is not available.

	SELECT * FROM EMPLOYEE WHERE JOININGDATE IS NULL;

--13. Display name of the employees in capital letters and city in small letters.

	SELECT UPPER(ENAME),LOWER(CITY) FROM EMPLOYEE;

--14. Change the data type of Ename from varchar (30) to char (30).

	ALTER TABLE EMPLOYEE ALTER COLUMN ENAME CHAR(30);
	 
--15. Display city wise maximum salary.

	SELECT MAX(SALARY) AS 'MAXSALARY',CITY FROM EMPLOYEE GROUP BY CITY;

--16. Produce output like <Ename> works at <city> and earns <salary> (In single column).

	SELECT ENAME + ' works at ' + CITY + ' and earns ' + CAST(SALARY AS VARCHAR) FROM EMPLOYEE;

--17. Find total number of employees whose salary is more than 5000.

	SELECT COUNT(EID) FROM EMPLOYEE WHERE SALARY > 5000;

--18. Write a query to display first 4 & last 3 characters of all the employees.

	SELECT LEFT(ENAME,4),RIGHT(RTRIM(ENAME),3) FROM EMPLOYEE;

--19. List the city having total salaries more than 15000 and employees joined after 1st January, 2014.

	SELECT CITY FROM EMPLOYEE WHERE JOININGDATE >'01-JAN-14' GROUP BY CITY HAVING SUM(SALARY)>15000 ;

--20. Write a query to replace “u” with “oo” in Ename.

	SELECT REPLACE(ENAME,'U','OO') FROM EMPLOYEE;

--21. Display city with average salaries and total number of employees belongs to each city.

	SELECT CITY,AVG(SALARY),COUNT(EID) FROM EMPLOYEE GROUP BY CITY;

--22. Display total salaries paid to female employees.

	SELECT SUM(SALARY) AS 'SUM SALARY OF FEMALE' FROM EMPLOYEE WHERE GENDER = 'FEMALE';

--23. Display name of the employees and their experience in years.

	SELECT ENAME,DATEDIFF(YEAR,JOININGDATE,GETDATE()) FROM EMPLOYEE;

--24. Remove column department from employee table.

	ALTER TABLE EMPLOYEE DROP COLUMN DEPARTMENT;

--25. Update the value of city from syndey to null.

	UPDATE EMPLOYEE SET CITY = NULL WHERE CITY = 'SYDNEY';

--26. Retrieve all Employee name, Salary & Joining date.

	SELECT ENAME,SALARY,JOININGDATE FROM EMPLOYEE;

--27. Find out combine length of Ename & Gender.

	SELECT LEN(ENAME)+LEN(GENDER) FROM EMPLOYEE;

--28. Find the difference between highest & lowest salary.

	SELECT MAX(SALARY)-MIN(SALARY) AS 'DIFF SALARY' FROM EMPLOYEE;

--29. Rename a column from Ename to FirstName.

	SP_RENAME 'EMPLOYEE.ENAME','FIRSTNAME';

--30. Rename a table from Employee to EmpMaster.

	SP_RENAME 'EMPLOYEE','EMPMASTER';