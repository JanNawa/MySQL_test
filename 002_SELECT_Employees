USE employees;

SELECT first_name, last_name FROM employees;
SELECT * FROM employees;

SELECT dept_no FROM departments;
SELECT * FROM departments;

SELECT * FROM employees 
  WHERE first_name = 'Elvis';

SELECT * FROM employees 
  WHERE first_name = 'Kellie' AND gender = 'F';

SELECT * FROM employees 
  WHERE first_name = 'Kellie' OR first_name = 'Aruna';

SELECT * FROM employees 
  WHERE gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');

SELECT * FROM employees 
  WHERE first_name IN ('Elvis', 'Denis');
SELECT * FROM employees 
  WHERE first_name NOT IN ('John', 'Mark', 'Jacob');

SELECT * FROM employees 
  WHERE first_name LIKE ('Mark%');
SELECT * FROM employees 
  WHERE YEAR(hire_date) = 2000;
SELECT * FROM employees 
  WHERE emp_no LIKE ('1000_');

SELECT * FROM employees 
  WHERE first_name LIKE ('%Jack%');
SELECT * FROM employees 
  WHERE first_name NOT LIKE ('%Jack%');

SELECT * FROM employees 
  WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';
SELECT * FROM employees 
  WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM salaries 
  WHERE salary BETWEEN 66000 AND 70000;
SELECT * FROM employees 
  WHERE emp_no NOT BETWEEN 10004 AND 10012;
SELECT dept_name FROM departments 
  WHERE dept_no BETWEEN 'd003' AND 'd006';

SELECT dept_name FROM departments 
  WHERE dept_no IS NOT NULL;

SELECT * FROM employees 
  WHERE first_name <> 'Mark';
SELECT * FROM employees 
  WHERE first_name != 'Mark';
SELECT * FROM employees   
  WHERE hire_date > '2000-01-01';
SELECT * FROM employees 
  WHERE hire_date <= '1985-02-01';

SELECT * FROM employees 
  WHERE gender = 'F' AND hire_date >= '2000-01-01';
SELECT * FROM salaries 
  WHERE salary > 150000;

SELECT DISTINCT gender FROM employees;
SELECT DISTINCT hire_date FROM employees;

SELECT COUNT(emp_no) FROM employees;
SELECT COUNT(DISTINCT first_name) FROM employees;

SELECT COUNT(*) FROM salaries 
  WHERE salary >= 100000;
SELECT COUNT(*) FROM dept_manager;

SELECT * FROM employees 
  ORDER BY first_name DESC;
SELECT * FROM employees 
  ORDER BY first_name, last_name;

SELECT * FROM employees 
  ORDER BY hire_date DESC;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name;
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

SELECT 
    emp_no, AVG(salary) AS average_salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
-- compare # 1 
SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;
-- compare # 2 
SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
SELECT emp_no, COUNT(emp_no) AS contract_count
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;

-- Select the first 100 rows from the ‘dept_emp’ table. 
SELECT * FROM dept_emp LIMIT 100;
