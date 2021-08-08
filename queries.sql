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