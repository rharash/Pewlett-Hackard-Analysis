-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
	     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	
	
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp (
 emp_no INT NOT NULL,
 dept_no VARCHAR(4) NOT NULL,
 from_date DATE NOT NULL,
 to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
CREATE TABLE titles (
 emp_no INT NOT NULL,
 title VARCHAR(30) NOT NULL,
 from_date DATE NOT NULL,
 to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM dept_emp;
SELECT * FROM salaries;
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- new table created- retirement_info
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

--- Creating new retirement_info table:-
SELECT first_name, last_name, emp_no
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--check the table
SELECT * FROM retirement_info

-- Joining departments and dept_manager tables-*
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables-**
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Use Aliases for Code Readability creating the left join as above-**
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no; 

-- Use Aliases for Code Readability creating the left join as above-*-(-- Joining departments and dept_manager tables-*)
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--left join in retirement info and dept emp and depicted the result into a new table
SELECT ri.emp_no,
     ri.first_name,
     ri.last_name,
     de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- to get the total number of employees in each department
--Joining current_emp and dept_emp tables- using count and  group by function- to get the number of employees by departments 
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--NEW TABLE- Employee count by department
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_deprtment
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
------------------------
SELECT * FROM salaries
ORDER BY to_date DESC;
----------------------
SELECT * FROM dept_emp
ORDER BY to_date DESC;
----------------------
SELECT emp_no,first_name,last_name,gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
---------------------------------------------------------
-------------7.3.5- #1------3 tables are being joined here

SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
----------------------------

-- List of managers per department-----7.3.5- #2---------------
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-----------------------------------------------------------------
-- SELECT ri.emp_no,
--      ri.first_name,
--      ri.last_name,
--      de.to_date
-- INTO current_emp
-- FROM retirement_info as ri
-- LEFT JOIN dept_emp as de
-- ON ri.emp_no = de.emp_no
-- WHERE de.to_date = ('9999-01-01');
------------------------------------------------------------
-- List of Department Retirees-----7.3.5- #3---------------
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--Tailered list 7.3.6------1-T_Sales list
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO T_SALES_LIST
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = ('Sales');

--Tailered list 7.3.6------2-T_Sales_Dev list
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO T_Sales_Dev
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development')
ORDER BY dept_name DESC;
----------------------Assignment--------------------
SELECT first_name, last_name, emp_no
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

------------------------------------------------

--left join in retirement info and dept emp and depicted the result into a new table
SELECT ri.emp_no,
     ri.first_name,
     ri.last_name,
     de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
--------------------------------------------
--Table 1: Number of Retiring Employees by Title
SELECT e.emp_no,
	e.first_name,
e.last_name,
	s.salary,
	de.to_date,
	tl.title
INTO Ret_Emp_Title
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
SELECT * FROM Ret_Emp_Title;

------------------------------------------------------------------
---to remove the duplicate records
SELECT
  ret.first_name,
  ret.last_name,
  count(*)
FROM Ret_Emp_Title as ret
GROUP BY
  ret.first_name,
    ret.last_name
HAVING count(*) > 1;
---------------------------------------------
SELECT * FROM
  (SELECT *, count(*)
  OVER
    (PARTITION BY
     ret.first_name,
     ret.last_name
    ) AS count
  FROM Ret_Emp_Title as ret) tableWithCount
  WHERE tableWithCount.count > 1;
  --------------------------------
--   DELETE FROM Ret_Emp_Title as ret WHERE ret.emp_no NOT IN 
-- (SELECT emp_no FROM (
--   SELECT DISTINCT ON (ret.first_name, ret.last_name) *
--   FROM Ret_Emp_Title as ret));
--   ---------------------------------------------
--   SELECT DISTINCT * FROM Ret_Emp_Title;
--   SELECT DISTINCT ON (ret.first_name, ret.last_name) * FROM Ret_Emp_Title as ret

------------------------------------------------------
WITH new_trick AS
    (SELECT DISTINCT ON (ret.first_name, ret.last_name) * FROM Ret_Emp_Title as ret)
DELETE FROM Ret_Emp_Title as ret WHERE ret.emp_no NOT IN (SELECT emp_no FROM new_trick);
---------------------------------------------------------
SELECT
  ret.first_name,
  ret.last_name,
  string_agg(title, ' / ') AS titles
FROM Ret_Emp_Title as ret
GROUP BY
  ret.first_name,
  ret.last_name;
----------------------------------------------------------
SELECT emp_no, first_name, last_name, to_date, title FROM
  (SELECT ret.emp_no, ret.first_name, ret.last_name, ret.to_date, ret.title,
     ROW_NUMBER() OVER 
(PARTITION BY (ret.first_name, ret.last_name) ORDER BY ret.to_date DESC) rn
   FROM Ret_Emp_Title as ret
  ) tmp WHERE rn = 1;


-- -- Partition the data to show only most recent title per employee
SELECT emp_no,
first_name,
last_name,
to_date,
title
INTO Ret_Emp_Title_refined
FROM
(SELECT ret.emp_no, ret.first_name, ret.last_name, ret.to_date, ret.title, ROW_NUMBER() OVER
(PARTITION BY (emp_no)
ORDER BY to_date DESC) rn
FROM Ret_Emp_Title as ret
) tmp WHERE rn = 1
ORDER BY emp_no;
----------------------------------------------
-- SELECT retr.emp_no,
-- 	retr.first_name,
-- retr.last_name,
-- 	retr.to_date,
-- 	retr.title,
-- 	tl.from_date
-- --INTO emp_for_Mentorship
-- FROM Ret_Emp_Title_refined as retr
-- INNER JOIN titles as tl
-- ON (retr.emp_no = tl.emp_no)
-- INNER JOIN employees as e
-- ON (retr.emp_no = e.emp_no)
-- WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- -- AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- -- AND (de.to_date = '9999-01-01');

----------------------------------------------------
--Table 2: Mentorship Eligibility------correctone
SELECT e.emp_no,
	e.first_name,
e.last_name,
	de.to_date,
	de.from_date,
	tl.title
INTO emp_for_Mentorship
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
SELECT * FROM emp_for_Mentorship;
-----------------------------------------
---to remove the duplicate records
SELECT
  efm.first_name,
  efm.last_name,
  count(*)
FROM emp_for_Mentorship as efm
GROUP BY
  efm.first_name,
    efm.last_name
HAVING count(*) > 1;
----------------------------------------
SELECT * FROM
  (SELECT *, count(*)
  OVER
    (PARTITION BY
     efm.first_name,
     efm.last_name
    ) AS count
  FROM emp_for_Mentorship as efm) tableWithCount
  WHERE tableWithCount.count > 1;
  --------------------------------
WITH new_trickm AS
    (SELECT DISTINCT ON (efm.first_name, efm.last_name) * FROM emp_for_Mentorship as efm)
DELETE FROM emp_for_Mentorship as efm WHERE efm.emp_no NOT IN (SELECT emp_no FROM new_trickm)
-------------------------------------------------------------------------------------------------
SELECT
  efm.first_name,
  efm.last_name,
  string_agg(title, ' / ') AS titles
FROM emp_for_Mentorship as efm
GROUP BY
  efm.first_name,
  efm.last_name;
  -----------------------------------------------------------------------------------------
SELECT emp_no,
first_name,
last_name,
to_date,
from_date,
title
INTO emp_for_Mentorship_refined
FROM
(SELECT efm.emp_no, efm.first_name, efm.last_name, efm.to_date, efm.from_date, efm.title, ROW_NUMBER() OVER
(PARTITION BY (emp_no)
ORDER BY to_date DESC) rn
FROM emp_for_Mentorship as efm
) tmp WHERE rn = 1
ORDER BY emp_no;
