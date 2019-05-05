USE employees;

INSERT INTO employees(emp_no, birth_date, first_name, last_name, gender, hire_date) 
	VALUES (999901, '1986-04-21', 'John', 'Smith', 'M', '2011-01-01');
    
SELECT * FROM employees
	ORDER BY emp_no DEsc
    LIMIT 10;
    
INSERT INTO employees VALUES (999902, '1986-04-21', 'Jane', 'Smith', 'F', '2011-01-01');
    
SELECT * FROM employees
	ORDER BY emp_no DEsc
    LIMIT 10;

INSERT INTO employees VALUES (999903, '1986-04-21', 'Joe', 'Smith', 'M', '2011-01-01');
    
SELECT * FROM employees
	ORDER BY emp_no DEsc
    LIMIT 10;
    
-- exercise 1
-- Select ten records from the “titles” table to get a better idea about its content.
SELECT * FROM titles LIMIT 10;
-- Then, in the same table, insert information about employee number 999903.
-- State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.
-- At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
INSERT INTO titles(emp_no, title, from_date) 
	VALUES (999903, 'Senior Engineer', '1997-10-01');
SELECT * FROM titles ORDER BY emp_no DESC LIMIT 10;

-- exercise 2
-- Insert information about the individual with employee number 999903 into the “dept_emp” table. 
-- He/She is working for department number 5, and has started work on  October 1st, 1997; 
-- her/his contract is for an indefinite period of time.
-- Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period.
SELECT * FROM dept_emp;
INSERT INTO dept_emp VALUES (999903, 'd005', '1997-10-01', '9999-01-01');
SELECT * FROM dept_emp ORDER BY emp_no DESC;

-- insert date INTO new table 
SELECT * FROM departments LIMIT 10;
CREATE TABLE departments_dup (
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);
SELECT * FROM departments_dup;
INSERT INTO departments_dup (dept_no, dept_name)
	SELECT * FROM departments;
SELECT * FROM departments_dup;

-- exercise
-- Create a new department called “Business Analysis”. Register it under number ‘d010’.
-- Hint: To solve this exercise, use the “departments” table. 
INSERT INTO departments VALUES ('d010', 'Business Analysis');
SELECT * FROM departments;
