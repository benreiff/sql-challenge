CREATE TABLE "departments" (
    "dept_no" varchar(10)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(10)   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
	"emp_no" int   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" varchar(30)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(30)   NOT NULL,
    "hire_date" varchar(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" varchar(30)   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

--ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
--REFERENCES "dept_manager" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");


-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select
	employees.emp_no
	,employees.last_name
	,employees.first_name
	,employees.gender
	,salaries.salary
from
	employees join salaries on (employees.emp_no=salaries.emp_no)
	order by employees.emp_no;

-- 2. List employees who were hired in 1986.

select 
	emp_no
	,first_name
	,last_name
	,hire_date
from 
	employees
WHERE hire_date like '%1986%';

-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select
	departments.dept_no
	,departments.dept_name
	,dept_manager.emp_no
	,employees.last_name
	,employees.first_name
	,dept_manager.from_date
	,dept_manager.to_date
from departments, dept_manager, employees
where employees.emp_no=dept_manager.emp_no and dept_manager.dept_no=departments.dept_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select
	employees.emp_no
	,employees.last_name
	,employees.first_name
	,departments.dept_name
from
	employees join dept_emp on (employees.emp_no=dept_emp.emp_no)
	join departments on (dept_emp.dept_no = departments.dept_no)
order by employees.emp_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

select
	first_name
	,last_name
from
	employees
where first_name = 'Hercules' and last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
	
select
	employees.emp_no
	,employees.last_name
	,employees.first_name
	,departments.dept_name
from departments, dept_emp, employees
where employees.emp_no=dept_emp.emp_no and dept_emp.dept_no=departments.dept_no and departments.dept_name='Sales'
order by employees.emp_no;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
	
select last_name, count(last_name)
  from employees
group by last_name
order by count desc;