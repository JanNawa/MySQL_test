USE employees;
-- IN nested in WHERE
-- display 'first_name' and 'last_name' of manager
SELECT e.first_name, e.last_name
	FROM employees e
    WHERE e.emp_no IN 
		(SELECT m.emp_no FROM dept_manager m);
-- exercise
-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995. 
SELECT * FROM employees e
	WHERE e.emp_no IN 
		(SELECT m.emp_no FROM dept_manager m
			WHERE m.from_date > '1990-01-01' AND m.to_date < '1995-01-01');
SELECT * FROM dept_manager
	WHERE emp_no IN 
		(SELECT emp_no FROM employees
			WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
-- EXISTS & NOT EXISTS
SELECT e.first_name, e.last_name
	FROM employees e
    WHERE EXISTS
		(SELECT * FROM dept_manager dm WHERE dm.emp_no = e.emp_no);

-- ORDER BY in outer query
SELECT e.first_name, e.last_name 
	FROM employees e
    WHERE EXISTS (SELECT * FROM dept_manager dm
		WHERE dm.emp_no = e.emp_no)
	ORDER BY emp_no;
    
-- exercise
-- Select the entire information for all employees whose job title is “Assistant Engineer”. 
-- Hint: To solve this exercise, use the 'employees' table.
SELECT * FROM employees e
	WHERE EXISTS (SELECT * FROM titles t
		WHERE e.emp_no = t.emp_no AND title = 'Assistant Engineer');

-- subquery : SELECT - FROM
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
-- exercise
-- create a table called “emp_manager” (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);
-- Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Insert INTO emp_manager SELECT U.*
FROM 
	(SELECT A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U;
    SELECT * FROM emp_manager;
