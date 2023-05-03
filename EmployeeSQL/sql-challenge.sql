CREATE TABLE departments (
	dept_no VARCHAR(4) Primary Key,
	dept_name VARCHAR(30)
);
-- DROP TABLE departments;

CREATE TABLE employees (
	emp_no INT NOT NULL Primary Key,
	emp_title_id VARCHAR(5),
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex VARCHAR(1),
	hire_date DATE
);
-- DROP TABLE employees;

CREATE TABLE salaries (
	emp_no INT NOT NULL Primary Key,
	salary INT,
	Foreign Key (emp_no) References employees(emp_no)
);
-- DROP TABLE salaries;

CREATE TABLE titles (
	title_id VARCHAR(5) NOT NULL Primary Key,
	title VARCHAR(50)
);
-- DROP TABLE titles;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	Primary Key (dept_no, emp_no),
	Foreign Key (dept_no) References departments(dept_no),
	Foreign Key (emp_no) References employees(emp_no)
);
-- DROP TABLE dept_emp;

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	Primary Key (dept_no, emp_no),
	Foreign Key (dept_no) References departments(dept_no),
	Foreign Key (emp_no) References employees(emp_no)
);
-- DROP TABLE dept_manager;

-- Import the data from CSVs
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- 1. List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, last_name, first_name, sex, salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986
ORDER BY hire_date;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT dm.dept_no, dept_name, dm.emp_no, last_name, first_name
FROM dept_manager dm
JOIN departments d
ON dm.dept_no = d.dept_no
JOIN employees e
ON dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee's employee number, last name, first name, and department number
SELECT de.dept_no, de.emp_no, last_name, first_name, dept_name
FROM dept_emp de
JOIN departments d
ON de.dept_no = d.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
ORDER BY dept_no, emp_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, last_name, first_name
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
WHERE dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no, last_name, first_name, dept_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE dept_name IN ('Sales', 'Development');

-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC;
