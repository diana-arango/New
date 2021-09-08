# Pewlett Hackard analysis

## Overview of the analysis
The purpose of this analysis was to determine the number of employees who reach retirement age at Pewlett Hackard and identify whom of these employees were eligible to participate in a mentorship program to train newly hired personnel. For the analysis, new tables were created, different type of joins were applied and clauses such as ON(), ORDER BY(), GROUP BY() and WHERE() were also  used to filter data. Alias instead of a full table name were considered to write a clean code and statements such as DISTINCT ON were used to retrieve the first occurrence of certain entries

## Results
Four major points from the 2 analysis
Images and support when needed

### 1.	Retirement_titles:
The following chart displays the employees and their positions that will be affected when they retire from PH. Senior Engineers, Senior Staff, Engineer, Staff and Technique leaders are the five positions most affected 

https://github.com/diana-arango/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.csv

Code used:
SELECT e.emp_no,
	 e.first_name,
	 e.last_name,
	 t.title,
	 t.from_date,
	 t.to_date
	INTO retirement_titles
	FROM employees as e
	RIGHT JOIN titles as t
	 ON(e.emp_no = t.emp_no)
	 WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	 ORDER BY t.emp_no;
--Quering table: retirement_titles in the database by using SELECT statement
SELECT * FROM retirement_titles;

### 2.	Unique_titles table: 

90398 employees from above mentioned positions were found close to retirement 
Duplicates on the number of employees working on different departments were removed to accurately determine the number of employees close to retirement and their titles 
 
https://github.com/diana-arango/Pewlett-Hackard-Analysis/blob/main/Data/unique_titles.csv

Code used:
SELECT DISTINCT ON (emp_no)
	 first_name, 
	 last_name, 
	 title
	 INTO unique_titles 
	 FROM retirement_titles as rt
	 ORDER BY rt.emp_no ASC, rt.to_date DESC;
--Quering table: unique_titles in the database by using SELECT statement
SELECT * FROM unique_titles;

### 3.	Retiring_titles table:
As mentioned before, the following are the positions that will potential open when employee retires as the number of openings that need to be fulfilled 

https://github.com/diana-arango/Pewlett-Hackard-Analysis/blob/main/retiring_titles.jpg

Code used:
SELECT title,COUNT(title) as "title count"
	 INTO retiring_titles
	 FROM unique_titles as ut
	 GROUP BY ut.title
	 ORDER BY "title count" DESC;
	 --Quering table: retiring_titles in the database by using SELECT statement
SELECT * FROM retiring_titles;


### 4.	Mentorship_eligibility table:

https://github.com/diana-arango/Pewlett-Hackard-Analysis/blob/main/Data/mentorship_eligibility.csv

1549 employees are eligible to participate in the mentorship program that will secure the training of new hires on the positions affected if a massive retirement occurs 
Code used:
SELECT DISTINCT ON (emp_no)
	 	e.emp_no,
		e.first_name,
	 	e.last_name ,
	 	e.birth_date ,
	 	de.from_date,
	 	de.to_date,
	 	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_em
	 p as de
ON(e.emp_no=de.emp_no)
INNER JOIN titles as t
ON(e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;
--Quering table: mentorship_eligibility in the database by using SELECT statement
SELECT * FROM mentorship_eligibility;	

## Summary 
To conclude: 
o	90398 employees will need to be filled as the “silver tsunami” begins to make an impact 
o	Only 1549 employees are eligible to participate in the mentorship program which is not enough to train the new generation of PH employees
o	An optional query that might help to determine the ratio between employees per mentor could be by determining the number of eligible mentors per department 
o	A second optional table that might help could be one that define the titles and number of employees participating on the mentorship program to consider hiring new personnel with no internal training 

![image](https://user-images.githubusercontent.com/86804185/132427448-75b9f2f7-88ff-4d18-aa0c-1963f25ff133.png)

