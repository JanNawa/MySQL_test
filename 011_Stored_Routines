USE employees;

-- S T O R E   P R O C E D U R E
-- NON-PARAMETERIZED 
DROP PROCEDURE IF EXISTS select_employees;
-- return the first 1,000 rows from 'employees' table
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
	LIMIT 1000;
END$$
DELIMITER ;
-- call the stored procedure
CALL select_employees();

-- exercise
-- Create a procedure that will provide the average salary of all employees.
DELIMITER $$
CREATE PROCEDURE average_salary()
	BEGIN
		SELECT AVG(salary) FROM salaries s;
    END$$
DELIMITER ;
-- Then, call the procedure. 
CALL average_salary();

-- remove procedure 
DROP PROCEDURE select_employees;

-- INPUT PARAMETERIZED
-- get all contract from input employee 
DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
	BEGIN
		SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
        FROM employees e
        JOIN salaries s ON e.emp_no = s.emp_no
        WHERE e.emp_no = p_emp_no;
	END$$
DELIMITER ;

-- get avergae salary from all contract from input employee 
DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
	BEGIN
		SELECT e.first_name, e.last_name, AVG(s.salary)
        FROM employees e
        JOIN salaries s ON e.emp_no = s.emp_no
        WHERE e.emp_no = p_emp_no;
	END$$
DELIMITER ;

-- INPUT & OUTPUT PARAMETERIZED
DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
	BEGIN
		SELECT AVG(s.salary) INTO p_avg_salary
			FROM employees e
            JOIN salaries s ON e.emp_no = s.emp_no
            WHERE e.emp_no = p_emp_no;
    END$$
DELIMITER ;

-- exercise
-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, 
-- and returns their employee number.
DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(14), IN p_last_name VARCHAR(16), OUT p_emp_no INTEGER)
	BEGIN
		SELECT e.emp_no INTO p_emp_no
			FROM employees e
            WHERE p_first_name = e.first_name AND p_last_name = e.last_name;
    END$$
DELIMITER ;

-- SQL variable
-- 1. create variable (using SET @v_name) 
SET @v_avg_salary = 0;
-- 2. extract value that will be assigned to newly created variable (call procedure)
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
-- 3. ask software to DISPLAY the output of procedure
SELECT @v_avg_salary;

-- exercise
-- Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
SET @v_emp_no = 0;
-- Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.
CALL emp_info('Aruna', 'Journel', @v_emp_no);
-- Finally, select the obtained output. 
SELECT @v_emp_no;

-- User-Defined Functions in MySQL
DROP FUNCTION IF EXISTS f_emp_avg_salary;
-- create function
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_avg_salary DECIMAL(10,2);
	SELECT AVG(s.salary) INTO v_avg_salary
		FROM employees e
		JOIN salaries s ON e.emp_no = s.emp_no
		WHERE e.emp_no = p_emp_no;
	RETURN v_avg_salary;
END$$
DELIMITER ;
-- call function
SELECT f_emp_avg_salary(11300);

-- exercise
-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
-- and returns the salary from the newest contract of that employee.
DELIMITER $$
CREATE FUNCTION f_emp_info (p_first_name VARCHAR(14), p_last_name VARCHAR(16)) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_max_from_date DATE;
    DECLARE v_salary DECIMAL(10,2);
    SELECT MAX(from_date) INTO v_max_from_date FROM salaries s
		JOIN employees e ON e.emp_no = s.emp_no
        WHERE p_first_name = e.first_name AND p_last_name = e.last_name;
    SELECT salary INTO v_salary FROM salaries s 
		JOIN employees e ON e.emp_no = s.emp_no
        WHERE p_first_name = e.first_name AND p_last_name = e.last_name AND from_date = v_max_from_date;
    RETURN v_salary;
END$$
DELIMITER ;
-- Finally, select this function. 
SELECT f_emp_info('Aruna', 'Journel');

-- include function in query
SET @v_emp_no = 11300;
SELECT emp_no, first_name, last_name, f_emp_avg_salary(@v_emp_no) AS avg_salary
	FROM employees
    WHERE emp_no = @v_emp_no;
