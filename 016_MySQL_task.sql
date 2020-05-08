USE employees_mod;

-- Task 1
-- Create a visualization that provides a breakdown between the male and female employees
-- working in the company each year, starting from 1990 
SELECT YEAR(d.from_date) AS calendar_year,
	e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM t_employees e
	JOIN t_dept_emp d ON e.emp_no = d.emp_no
GROUP BY calendar_year, gender 
HAVING calendar_year >= 1990
ORDER BY calendar_year;

-- Task 2
-- Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990. 
SELECT d.dept_name, 
	e.gender, 
	m.emp_no, 
    m.from_date, 
    m.to_date, 
	y.calendar_year, 
    CASE
		WHEN YEAR(m.from_date) <= y.calendar_year AND YEAR(m.to_date) >= y.calendar_year
			THEN 1
		ELSE 0
    END AS active
FROM (SELECT YEAR(hire_date) AS calendar_year 
		FROM t_employees GROUP BY calendar_year) y
	CROSS JOIN t_dept_manager m
    JOIN t_departments d ON d.dept_no = m.dept_no
    JOIN t_employees e ON e.emp_no = m.emp_no
WHERE YEAR(e.hire_date) >= 1990
ORDER BY m.emp_no, calendar_year;

-- Task 3
-- Compare the average salary of female versus male employees in the entire company until year 2002, 
-- and add a filter allowing you to see that per each department. 
SELECT e.gender,
	d.dept_name,
    ROUND(AVG(s.salary), 2) AS avg_salary,
    YEAR(de.from_date) AS calendar_year
FROM t_employees e
    JOIN t_salaries s ON s.emp_no = e.emp_no
    JOIN t_dept_emp de ON de.emp_no = e.emp_no
    JOIN t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no, e.gender, calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

-- Task 4
-- Create an SQL stored procedure that will allow you to obtain the average male and female salary per department 
-- within a certain salary range. 
-- Let this range be defined by two values the user can insert when calling the procedure.
SELECT MIN(salary) FROM t_salaries;
SELECT MAX(salary) FROM t_salaries;

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary(IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
	SELECT e.gender, d.dept_name , ROUND(AVG(s.salary), 2) AS avg_salary
    FROM t_employees e
		JOIN t_salaries s ON s.emp_no = e.emp_no
		JOIN t_dept_emp de ON de.emp_no = e.emp_no
		JOIN t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
    GROUP BY d.dept_no, e.gender;
END$$
DELIMITER ;

CALL filter_salary(50000,90000);
