USE employees;

-- people who are hired after 1st January, 2000 
SELECT * FROM employees
	WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

-- composite index
SELECT * FROM employees
	WHERE first_name = 'Georgi' AND last_name = 'Facello';

CREATE INDEX i_composite_name ON employees(first_name, last_name);

-- list the index
SHOW INDEX FROM employees FROM employees; 
SHOW INDEX FROM salaries FROM employees; 

-- exercise 1
-- Drop the ‘i_hire_date’ index. 
ALTER TABLE employees DROP INDEX i_hire_date ;

-- exercise 2
-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
SELECT * FROM salaries 
	WHERE salary > 89000;
-- Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement. 
CREATE INDEX i_salary ON salaries(salary);
