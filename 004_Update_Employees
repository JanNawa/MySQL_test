Use employees;

SELECT * FROM employees WHERE emp_no = 999901;

UPDATE employees
	SET first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
    WHERE emp_no = 999901;

SELECT * FROM employees ORDER BY emp_no DESC LIMIT 10;

-- COMMIT & ROLLBACK
SELECT * FROM departments_dup ORDER BY dept_no; 

COMMIT;

UPDATE departments_dup
	SET dept_no = 'd011',
    dept_name = 'Quality Control';
    
SELECT * FROM departments_dup ORDER BY dept_no; 
ROLLBACK;
COMMIT;

-- EXERCISE
-- Change the “Business Analysis” department name to “Data Analysis”.
-- Hint: To solve this exercise, use the “departments” table. 
SELECT * FROM departments ORDER BY dept_no; 
UPDATE departments
	SET dept_name = 'Data Analysis'
    WHERE dept_no = 'd010';
