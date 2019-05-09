USE employees;

-- local variable
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
BEGIN
	DECLARE v_avg_salary DECIMAL(10, 2);
    SELECT AVG(s.salary) INTO v_avg_salary
		FROM employees e
        JOIN salaries s ON e.emp_no = s.emp_no
        WHERE e.emp_no = p_emp_no;
	RETURN v_avg_salary;
END$$
DELIMITER ; 
-- can't reach local variable outside BEGIN-END block 
SELECT v_avg_salary;

-- session variable
SET @s_var1 = 3;
SELECT @s_var1; 

-- global variable
SET GLOBAL max_connections = 1000; 
SET @@global.max_connections = 100;

-- user-defined VS system defined
-- max_connections can only be GLOBAL
SET SESSION max_connections = 1000; 
-- sql_mode
SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION'; 
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION'; 
