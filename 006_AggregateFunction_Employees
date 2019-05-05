USE employees;

-- C O U N T
SELECT * FROM salaries
	ORDER BY salary DESC
    LIMIT 10;
SELECT COUNT(salary) FROM salaries;
SELECT COUNT(from_date) FROM salaries;
SELECT COUNT(DISTINCT from_date) FROM salaries;
SELECT COUNT(*) FROM salaries;
-- excercise
-- How many departments are there in the “employees” database? 
-- Use the ‘dept_emp’ table to answer the question. 
SELECT COUNT(DISTINCT dept_no) AS dept_count FROM dept_emp;

-- S U M
SELECT SUM(salary) FROM salaries;
-- exercise
-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997? 
SELECT SUM(salary) FROM salaries WHERE from_date > '1997-01-01';

-- M I N   &   M A X
SELECT MAX(salary) FROM salaries; 
SELECT MIN(salary) FROM salaries; 
-- exercise
-- 1. Which is the lowest employee number in the database?
SELECT MIN(emp_no) FROM employees;
-- 2. Which is the highest employee number in the database? 
SELECT MAX(emp_no) FROM employees;

-- A V G
SELECT AVG(salary) FROM salaries;
-- exercise
-- What is the average annual salary paid to employees who started after the 1st of January 1997?  
SELECT AVG(salary) FROM salaries WHERE from_date > '1997-01-01';

-- R O U N D 
SELECT ROUND(AVG(salary)) FROM salaries;
SELECT ROUND(AVG(salary), 2) FROM salaries;
-- exercise
-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 
-- to a precision of cents.
SELECT ROUND(AVG(salary), 2) FROM salaries WHERE from_date > '1997-01-01';

-- COALESDE
-- code preparation 
SELECT * FROM departments_dup;
ALTER TABLE departments_dup 
	CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;
INSERT INTO departments_dup(dept_no) VALUES('d001'), ('d002');
ALTER TABLE employees.departments_dup
	ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;
SELECT dept_no, IFNULL(dept_name, 'Department name not provided') FROM departments_dup;
SELECT dept_no, IFNULL(dept_name, 'Department name not provided') AS dept_name FROM departments_dup;
SELECT dept_no, dept_name, COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
	FROM departments_dup
    ORDER BY dept_no ASC;
SELECT dept_no, dept_name, COALESCE('dept manager name') AS fake_col FROM departments_dup;
-- exercise 1
-- Select the department number and name from the ‘departments_dup’ table and 
-- add a third column where you name the department number (‘dept_no’) as ‘dept_info’. 
-- If ‘dept_no’ does not have a value, use ‘dept_name’.
SELECT dept_no, dept_name, COALESCE(dept_no, dept_name) AS 'dept_info' FROM departments_dup;
-- exercise 2
-- Modify the code obtained from the previous exercise in the following way. 
-- Apply the IFNULL() function to the values from the first and second column, 
-- so that ‘N/A’ is displayed whenever a department number has no value, 
-- and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
SELECT IFNULL(dept_no,'N/A') AS dept_no, 
	IFNULL(dept_name,'Department name not provided') AS dept_name, 
    COALESCE(dept_no, dept_name) AS 'dept_info' 
    FROM departments_dup;
