USE employees;
COMMIT;

-- before INSERT
DELIMITER $$
CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$
DELIMITER ;

-- Check the values of the “Salaries” table for employee 10001.
SELECT * FROM salaries
	WHERE emp_no = '10001';
    
-- Insert a new entry for employee 10001, whose salary will be a negative number.
INSERT INTO salaries 
	VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

-- Run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.
SELECT * FROM salaries
	WHERE emp_no = '10001';
    
-- before UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;

-- Run the following UPDATE statement, with which we will modify the salary value of employee 10001 with another positive value.
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
-- Execute the following SELECT statement to see that the record has been successfully updated.
SELECT * FROM salaries
	WHERE emp_no = '10001' AND from_date = '2010-06-22';
        
-- Run another UPDATE statement, with which we will try to modify the salary earned by 10001 with a negative value, minus 50,000.
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
-- SYSTEM FUNCTION
-- SYSDATE() delivers the date and time of the moment at which you have invoked this function. 
SELECT SYSDATE(); 

-- Another frequently employed function, “Date Format”, assigns a specific format to a given date. For instance, the following query 
-- could extract the current date, quoting the year, the month, and the day. 
SELECT DATE_FORMAT(SYSDATE(), '%Y-%m-%d') as today;

-- As an exercise, try to understand the following query. 
-- Technically, it regards the creation of a more complex trigger.
DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

-- After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%Y-%m-%d'), '9999-01-01');

-- SELECT the record of employee number 111534 in the ‘dept_manager’ table, and then in the ‘salaries’ table to see how the output was affected. 
SELECT * FROM dept_manager
	WHERE emp_no = 111534;

SELECT * FROM salaries
	WHERE emp_no = 111534;

-- Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee 
-- who was just promoted as a manager. 
-- Moreover, it set the start date of her new contract to be the day on which you executed the insert statement.

-- Finally, to restore the data in the database to the state from the beginning of this lecture, execute the following ROLLBACK statement. 
ROLLBACK;

-- exercise
-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
DELIMITER $$
CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees FOR EACH ROW
	BEGIN
		IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN
			SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%m-%d');
		END IF;
	END$$
DELIMITER ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT * FROM employees
	ORDER BY emp_no DESC;
