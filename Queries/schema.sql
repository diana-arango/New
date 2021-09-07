--Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL, 
	PRIMARY KEY(dept_no),
	UNIQUE (dept_name)
);
--Creating the employees table. Unique variable wasn't included
CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL, 
	first_name VARCHAR NOT NULL, 
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL, 
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);	
--Create dept manager table that includes a 2 foreign keys
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL, 
	emp_no INT NOT NULL, 
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
PRIMARY KEY(emp_no, dept_no)
);
--Create salaries table includes 1 foreign key
CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no)
);
--Create dept employees table
CREATE TABLE dept_emp (
	emp_no INT NOT NULL, 
	dept_no VARCHAR(4) NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);
--Create titles table
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title INT NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no)
);
--Quering table: deparments in the database by using SELECT statement
SELECT * FROM departments;
--Check if importing data from Department.csv was successful
SELECT * FROM departments;
--Check if data from salary.csv imported successfully
SELECT * FROM salaries;
--Check if data from dept_emp.csv imported successfully
SELECT * FROM dept_emp;
--Check if data from dept_manager.csv imported successfully
SELECT * FROM dept_manager;
--Drop salaries table
DROP TABLE salaries CASCADE;
--Recreate salaries table after droping the old one. Missing a column 
CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no)
);
--Check if data from salaries.csv imported successfully
SELECT * FROM salaries;
--Drop titles table. Enter the wrong type of data on titles
DROP TABLE titles CASCADE;
--recreate titles table after changing the data type for tiles to varchar
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no)
);
--Drop titles table. Enter the wrong type of data on titles
DROP TABLE titles CASCADE;
--recreate titles table after adding, title and from_date as primary keys also
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no,title,from_date)
);
--Determine retirement eligibility for anyone born between 1952 and 1955
SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
--Determine how many employees were born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--Determine how many employees were born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--Determine how many employees were born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--Determine how many employees were born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
--Determine retirement eligibility for anyone born between 1952 and 1955 and hire between 1985 to 1988
SELECT first_name,last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--Count how many employees are born between 1952 and 1955 and hire between 1985 to 1988. Use COUNT function
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--Create a new table. Use 'SELECT INTO' function to generate a list of results
SELECT first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date retirement_info;
--We're going to adjust retirement_info table. Will need to drop the table first
DROP TABLE retirement_info;
-- Create new retirement_info table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
--Use left join to capture retirement_info table
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;
--Use Left Join for retirement_info and dept_emp tables.Creating a new table named 'current_emp'
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-- Employee count by department number. Organize the table, using ORDER BY function
SELECT COUNT(ce.emp_no), de.dept_no
INTO retired_by_deparment
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--List 1 Employee information. Organize first by date
SELECT * FROM salaries
ORDER BY to_date DESC;
--List 1 Employee information.Reuse code, add gender
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON(e.emp_no=s.emp_no)
INNER JOIN dept_emp as de
ON(e.emp_no=de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
--Departments retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);
--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no,first_name,last_name
FROM employees
--Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title,from_date,to_date
FROM titles
--Create a new table using the INTO clause
SELECT emp_no, first_name,last_name
INTO retirement_titles 
FROM employees as e


--Join both tables on the primary key.
SELECT rt.emp_no, rt.first_name, rt.last_name, t.title, t.from_date, t.to_date
FROM retirement_titles as rt
INNER JOIN titles as t
ON(rt.emp_no=t.emp_no)

-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number
SELECT * FROM employees
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;

-- Drop retirement_titles table, missed a statement
DROP TABLE retirement_titles

--Recreate a new table using the INTO clause
SELECT emp_no, first_name,last_name
INTO retirement_titles 
FROM employees as e
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;

--Re-join both tables on the primary key.
SELECT rt.emp_no, rt.first_name, rt.last_name, t.title, t.from_date, t.to_date
FROM retirement_titles as rt
INNER JOIN titles as t
ON(rt.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;

-- Drop retirement_titles 
DROP TABLE retirement_titles CASCADE; 

 -- Drop retirement_table
DROP TABLE retirement_table;

-- How many folks will be leaving from sales department 
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');

--Quering table: sales_info in the database by using SELECT statement
SELECT * FROM sales_info;
	 
-- How many folks will be leaving from Sales and Develpment departments: 
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO mentoring_program
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development');

--Quering table: mentoring_program in the database by using SELECT statement
SELECT * FROM mentoring_program;
	 
