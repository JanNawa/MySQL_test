USE employees;

COMMIT;

SELECT * FROM employees WHERE emp_no = 999903;

DELETE FROM employees WHERE emp_no = 999903;

ROLLBACK;

-- Remove the department number 10 record from the “departments” table.
DELETE FROM departments WHERE dept_no = 'd010';
SELECT * FROM departments ORDER BY dept_no DESC;
