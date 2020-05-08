USE employees;

-- case (version 1) 
SELECT emp_no, first_name, last_name,
	CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- case (version 2)
SELECT emp_no, first_name, last_name,
	CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- case with IS NOT NULL (work)
SELECT e.emp_no, e.first_name, e.last_name,
	CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM employees e 
	LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

-- case with IS NOT NULL (not work --> IS NULL & IS NOT NULL can't used to compare) 
SELECT e.emp_no, e.first_name, e.last_name,
	CASE dm.emp_no
		WHEN  NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM employees e 
	LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

-- IF (can only have 1 condition) 
SELECT emp_no, first_name, last_name,
	IF (gender = 'M', 'Male', 'Female') AS gender
FROM employees;

-- CASE with multiple conditions (can't substitute by IF) 
SELECT dm.emp_no,
	e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by > $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
	END AS salary_increase
FROM dept_manager dm
	JOIN employees e ON e.emp_no = dm.emp_no
    JOIN salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;
        
-- exercise 1
-- Obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
-- Create a fourth column in the query, indicating whether this employee is also a manager, 
-- according to the data provided in the dept_manager table, or a regular employee.  
-- option 1 with IF 
SELECT e.emp_no, e.first_name, e.last_name,
	IF(dm.emp_no IS NOT NULL, 'Yes', 'No') AS is_manager
FROM employees e
	LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990;

-- option 2 with CASE
SELECT e.emp_no, e.first_name, e.last_name,
	CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Yes'
        ELSE 'No' 
	END AS is_manager
FROM employees e
	LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990;

-- exercise 2
-- Extract a dataset containing the following information about the managers: 
-- employee number, first name, and last name. 
-- Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
-- and another one saying whether this salary raise was higher than $30,000 or NOT.
-- option 1 with IF
SELECT e.emp_no, e.first_name, e.last_name,
	MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF (MAX(s.salary) - MIN(s.salary) > 30000, 'Raised more than $30,000', 'Raised less than $30,000') AS salary_raised
FROM employees e
	JOIN dept_manager dm ON e.emp_no = dm.emp_no
    JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;
    
-- option 2 with CASE  
SELECT e.emp_no, e.first_name, e.last_name,
	MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Raised more than $30,000'
        ELSE 'Raised less than $30,000'
    END AS salary_raised
FROM employees e
	JOIN dept_manager dm ON e.emp_no = dm.emp_no
    JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;

-- exercise 3
-- Extract the employee number, first name, and last name of the first 100 employees, 
-- and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, 
-- or “Not an employee anymore” if they aren’t.
-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.  
SELECT e.emp_no, e.first_name, e.last_name, de.to_date,
	IF(MAX(de.to_date) > SYSDATE(), 'Is still employed', 'Not an employee anymore') AS current_employee
FROM employees e
	JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100;
