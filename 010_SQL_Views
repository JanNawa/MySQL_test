USE employees;

SELECT * FROM dept_emp;

SELECT emp_no, from_date, to_date, COUNT(emp_no) AS num
	FROM dept_emp
    GROUP BY emp_no
    HAVING num > 1;
    
-- visualize only the period encompassing the LAST contract of each employee
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
	SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;
    
-- exercise
-- Create a view that will extract the average salary of all managers registered in the database. 
-- Round this value to the nearest cent.
CREATE OR REPLACE VIEW v_average_manager_salary AS
	SELECT ROUND(AVG(salary),2) AS manager_average_salary
    FROM salaries s JOIN dept_manager m
    ON s.emp_no = m.emp_no;
