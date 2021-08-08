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
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
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
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info;