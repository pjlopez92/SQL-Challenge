
CREATE TABLE  departments
(
	dept_No VARCHAR PRIMARY KEY,
	dept_name TEXT
);

CREATE TABLE employees
(
	emp_No VARCHAR PRIMARY KEY,
	birth_date DATE,
	first_name TEXT,
	last_name TEXT,
	gender VARCHAR,
	hire_date DATE
);

CREATE TABLE dept_emp
(
	emp_No VARCHAR,
	dept_No VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_No) REFERENCES departments(dept_No),
	FOREIGN KEY (emp_No) REFERENCES employees(emp_No)
	
);

CREATE TABLE dept_manager
(
	dept_No VARCHAR,
	emp_No VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_No) REFERENCES departments(dept_No),
	FOREIGN KEY (emp_No) REFERENCES employees(emp_No)
);

CREATE TABLE titles
(
	emp_No VARCHAR,
	title VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_No) REFERENCES employees(emp_No)
);

CREATE TABLE salaries
(
	emp_No VARCHAR,
	salary BIGINT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_No) REFERENCES employees(emp_No)
);

SELECT e.emp_No, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
JOIN salaries AS s
ON e.emp_No = s.emp_No;

SELECT e.emp_No, e.last_name, e.first_name, e.hire_date
FROM employees e
WHERE e.hire_date >= '1/1/1986' AND e.hire_date <='12/31/1986';

SELECT dm.dept_No, d.dept_name, dm.emp_No, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager dm
JOIN departments AS d
ON dm.dept_No = d.dept_No
JOIN employees AS e
ON dm.emp_No = e.emp_No;

SELECT de.emp_No, de.dept_No, d.dept_name
INTO dept_emp_dname
FROM dept_emp de
LEFT JOIN departments d
ON de.dept_No = d.dept_No;

SELECT ded.emp_No, e.last_name, e.first_name, ded.dept_name
FROM dept_emp_dname ded
JOIN employees AS e
ON ded.emp_No = e.emp_No;

SELECT e.emp_No, e.First_name, e.last_name
FROM employees e 
WHERE e.first_name = 'Hercules'
AND e.last_name LIKE 'B%';

SELECT ded.emp_No, e.last_name, e.first_name, ded.dept_name
FROM employees e
JOIN dept_emp_dname AS ded
ON ded.emp_No = e.emp_No
WHERE ded.dept_name = 'Sales';

SELECT ded.emp_No, e.last_name, e.first_name, ded.dept_name
FROM employees e
JOIN dept_emp_dname AS ded
ON ded.emp_No = e.emp_No
WHERE ded.dept_name = 'Sales' OR ded.dept_name = 'Development';

SELECT e.last_name, COUNT(*) last_name_count
FROM employees e
GROUP BY last_name
ORDER BY last_name_count DESC;