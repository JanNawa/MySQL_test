-- join preparation
-- exercise 1
USE Employees;
ALTER TABLE departments_dup 
	DROP COLUMN dept_manager;
SELECT * FROM departments_dup 	
	ORDER BY dept_no;
SELECT * FROM departments 
	ORDER BY dept_no;
ALTER TABLE departments_dup 
	MODIFY dept_no VARCHAR(4) NULL;
ALTER TABLE departments_dup 
	MODIFY dept_name VARCHAR(40) NULL;
TRUNCATE TABLE departments_dup;
INSERT INTO departments_dup(dept_no, dept_name)
	SELECT dept_no, dept_name
    FROM departments;
INSERT INTO departments_dup(dept_name) VALUES('Public Relations');
INSERT INTO departments_dup(dept_no) VALUES('d010'),('d011');
DELETE FROM departments_dup WHERE dept_no = 'd002';

-- exercise 2
DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);
INSERT INTO dept_manager_dup 
	SELECT * FROM dept_manager;
INSERT INTO dept_manager_dup(emp_no, from_date)
	VALUES (999904, '2017-01-01'),
    (999905, '2017-01-01'),
    (999906, '2017-01-01'),
    (999907, '2017-01-01');
DELETE FROM dept_manager_dup
	WHERE dept_no = 'd001';
INSERT INTO departments_dup(dept_name)
	VALUES ('Public Relations');
DELETE FROM departments_dup
	WHERE dept_no = 'd002';
    
-- INNER JOIN 
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    INNER JOIN departments_dup d
    ON m.dept_no = d.dept_no;
-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
	FROM dept_manager m
    INNER JOIN employees e
    ON m.emp_no = e.emp_no;

-- DUPLICATE RECORDS
-- CREATE DUPLICATE RECORDS
INSERT INTO dept_manager_dup
	VALUES('110228', 'd003', '1992-03-21', '9999-01-01');
INSERT INTO departments_dup
	VALUES('d009', 'Customer Service');
-- CHECK TABLE
SELECT * FROM dept_manager_dup
	ORDER BY dept_no ASC;
SELECT * FROM departments_dup
	ORDER BY dept_no ASC;
-- use GROUP BY to solve duplicate records
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    JOIN departments_dup d
    ON m.dept_no = d.dept_no
    GROUP BY m.emp_no
    ORDER BY dept_no;
    
-- left join preparation
-- remove the duplicates from 2 tables
DELETE FROM dept_manager_dup WHERE emp_no = '110228';
DELETE FROM departments_dup WHERE dept_no = 'd009';
-- add back initial records
INSERT INTO dept_manager_dup
	VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');
INSERT INTO departments_dup
	VALUES ('d009', 'Customer Service');
-- LEFT JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    LEFT JOIN departments_dup d
    ON 	m.dept_no = d.dept_no
    GROUP BY m.emp_no
    ORDER BY m.dept_no;
SELECT d.dept_no, m.emp_no, d.dept_name
	FROM departments_dup d
    LEFT JOIN dept_manager_dup m
    ON m.dept_no = d.dept_no
    ORDER BY d.dept_no;
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    LEFT JOIN departments_dup d
    ON m.dept_no  = d.dept_no
    WHERE dept_name IS NULL
    ORDER BY m.dept_no;
-- exercise
-- Join the 'employees' and the 'dept_manager' tables 
-- to return a subset of all the employees whose last name is Markovitch. 
-- See if the output contains a manager with that name.  
-- Hint: Create an output containing information corresponding to the following fields: 
-- ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. 
-- Order by 'dept_no' descending, and then by 'emp_no'.
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
	FROM employees e
    LEFT JOIN dept_manager m
    ON e.emp_no = m.emp_no
    WHERE e.last_name = 'Markovitch'
    ORDER BY m.dept_no DESC, e.emp_no;
    
-- RIGHT JOIN
SELECT d.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    RIGHT JOIN departments_dup d
    ON m.dept_no = d.dept_no
    ORDER BY dept_no;
    
-- new and old join syntax
-- JOIN (new syntax)
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m
    INNER JOIN departments_dup d ON m.dept_no = d.dept_no
    ORDER BY m.dept_no;
-- WHERE (old syntax)
SELECT m.dept_no, m.emp_no, d.dept_name
	FROM dept_manager_dup m, departments_dup d
    WHERE m.dept_no = d.dept_no
    ORDER BY m.dept_no;
-- exercise
-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
-- Old Syntax
SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
	FROM dept_manager m, employees e
    WHERE m.emp_no = e.emp_no;
-- New Syntax
SELECT m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
	FROM dept_manager m
    JOIN employees e ON m.emp_no = e.emp_no;
    
-- JOIN + WHERE
SELECT e.emp_no, e.first_name, e.last_name, s.salary
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE s.salary > 145000;
-- execise
-- Select the first and last name, the hire date, and the job title of all employees 
-- whose first name is “Margareta” and have the last name “Markovitch”.
SELECT e.first_name, e.last_name, e.hire_date, t.title
	FROM employees e
    JOIN titles t ON e.emp_no = t.emp_no
    WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch'
    ORDER BY e.emp_no;
    
-- CROSS JOIN
-- cross join 'dept_manager' and 'departments' version 1
SELECT dm.*, d.*
	FROM dept_manager dm
    CROSS JOIN departments d
    ORDER BY dm.emp_no, d.dept_no;
-- cross join 'dept_manager' and 'departments' version 2
SELECT dm.*, d.*
	FROM dept_manager dm, departments d
    ORDER BY dm.emp_no, d.dept_no;
-- cross join 'dept_manager' and 'departments' version 3
SELECT dm.*, d.*
	FROM dept_manager dm
    JOIN departments d
    ORDER BY dm.emp_no, d.dept_no;
-- display all department except the one manager is on
SELECT dm.*, d.*
	FROM departments d
    CROSS JOIN dept_manager dm
    WHERE d.dept_no <> dm.dept_no
    ORDER BY dm.emp_no, d.dept_no;
-- display the department that the manager is on
SELECT dm.*, d.*
	FROM departments d
    CROSS JOIN dept_manager dm
    WHERE d.dept_no = dm.dept_no
    ORDER BY dm.emp_no, d.dept_no;
-- display 'dept_manager' on 'employee' and 'departments' detail
SELECT e.*, d.*
	FROM departments d 
    CROSS JOIN dept_manager dm
    JOIN employees e ON dm.emp_no = e.emp_no
    WHERE d.dept_no = dm.dept_no
    ORDER BY dm.emp_no, d.dept_no;
-- exercise 1
-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
SELECT m.*, d.*
	FROM dept_manager m
    CROSS JOIN departments d
    WHERE d.dept_no = 'd009'
    ORDER BY m.emp_no;
SELECT dm.*, d.*
	FROM departments d
	CROSS JOIN dept_manager dm
	WHERE d.dept_no = 'd009'
	ORDER BY d.dept_name;
-- exercise 2
-- Return a list with the first 10 employees with all the departments they can be assigned to.
-- Hint: Don’t use LIMIT; use a WHERE clause.
SELECT e.*, d.*
	FROM employees e
    CROSS JOIN departments d
    WHERE e.emp_no < 10011
	ORDER BY e.emp_no, d.dept_no;
    
-- aggregate function with JOINi
-- find average salaries of men and women in the company 
 SELECT e.gender, AVG(s.salary) AS average_salary
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    GROUP BY gender;
    
-- JOIN more than 2 tables (in SQL)
SELECT e.first_name,
	e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
    FROM employees e
    JOIN dept_manager m ON e.emp_no = m.emp_no
    JOIN departments d ON m.dept_no = d.dept_no;
-- exercise
-- Select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
	FROM employees e
    JOIN titles t ON e.emp_no = t.emp_no
    JOIN dept_manager m ON e.emp_no = m.emp_no
    JOIN departments d ON m.dept_no = d.dept_no
    WHERE t.title = 'Manager'
    ORDER BY e.emp_no;

-- Tips for JOIN
-- display average for each department
SELECT d.dept_name, AVG(salary) AS average_salary
	FROM departments d
    JOIN dept_manager m ON d.dept_no = m.dept_no
    JOIN salaries s ON m.emp_no = s.emp_no
    GROUP BY d.dept_name
    ORDER BY average_salary DESC;
-- display average for each department that higher than 60,000
SELECT d.dept_name, AVG(salary) AS average_salary
	FROM departments d
    JOIN dept_manager m ON d.dept_no = m.dept_no
    JOIN salaries s ON m.emp_no = s.emp_no
    GROUP BY d.dept_name
    HAVING average_salary > 60000
    ORDER BY average_salary DESC;
-- exercise
-- How many male and how many female managers do we have in the ‘employees’ database? 
SELECT e.gender, COUNT(e.emp_no) AS gender_count
	FROM employees e
    JOIN dept_manager m on e.emp_no = m.emp_no
    GROUP BY gender;

-- UNION preparation
-- create employees_dup
DROP TABLE IF EXISTS employees_dup;
CREATE TABLE employees_dup (
	emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);
-- duplicate the data to 'employees_dup' (20 records)
INSERT INTO employees_dup
	SELECT e.* 
	FROM employees e 
	LIMIT 20;
SELECT * FROM employees_dup;
-- insert duplicate record
INSERT INTO employees_dup 
	VALUES ('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
-- UNION VS UNION ALL
-- UNION ALL
SELECT 
	e.emp_no,
	e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
    FROM employees_dup e
    WHERE e.emp_no = 10001
    UNION ALL SELECT
		NULL AS emp_no,
        NULL AS first_name,
        NULL AS last_name,
        m.dept_no,
        m.from_date
	FROM dept_manager m;
 -- UNION
 SELECT 
	e.emp_no,
	e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
    FROM employees_dup e
    WHERE e.emp_no = 10001
    UNION SELECT
		NULL AS emp_no,
        NULL AS first_name,
        NULL AS last_name,
        m.dept_no,
        m.from_date
	FROM dept_manager m;
-- exercise
SELECT * FROM (SELECT
	e.emp_no,
    e.first_name,
	e.last_name,
	NULL AS dept_no,
	NULL AS from_date
FROM employees e
WHERE last_name = 'Denis' 
UNION SELECT
	NULL AS emp_no,
	NULL AS first_name,
	NULL AS last_name,
	dm.dept_no,
	dm.from_date
FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;
