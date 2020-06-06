-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" Int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "to_date" date   NOT NULL,
    "from_date" date   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" Int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" Int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" Int   NOT NULL,
    "salary" Int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" Int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "retirement_info" (
    "emp_no" Int   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    CONSTRAINT "pk_retirement_info" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "current_emp" (
    "emp_no" Int   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_current_emp" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Ret_Emp_Title" (
    "emp_no" Int   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "salary" Int   NOT NULL,
    "to_date" date   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Ret_Emp_Title" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "emp_for_Mentorship" (
    "emp_no" Int   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "to_date" date   NOT NULL,
    "from_date" date   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_emp_for_Mentorship" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "retirement_info" ADD CONSTRAINT "fk_retirement_info_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "current_emp" ADD CONSTRAINT "fk_current_emp_emp_no_first_name_last_name" FOREIGN KEY("emp_no", "first_name", "last_name")
REFERENCES "retirement_info" ("emp_no", "first_name", "last_name");

ALTER TABLE "current_emp" ADD CONSTRAINT "fk_current_emp_to_date" FOREIGN KEY("to_date")
REFERENCES "dept_emp" ("to_date");

ALTER TABLE "Ret_Emp_Title" ADD CONSTRAINT "fk_Ret_Emp_Title_emp_no_first_name_last_name" FOREIGN KEY("emp_no", "first_name", "last_name")
REFERENCES "employees" ("emp_no", "first_name", "last_name");

ALTER TABLE "Ret_Emp_Title" ADD CONSTRAINT "fk_Ret_Emp_Title_salary" FOREIGN KEY("salary")
REFERENCES "salaries" ("salary");

ALTER TABLE "Ret_Emp_Title" ADD CONSTRAINT "fk_Ret_Emp_Title_to_date" FOREIGN KEY("to_date")
REFERENCES "dept_emp" ("to_date");

ALTER TABLE "Ret_Emp_Title" ADD CONSTRAINT "fk_Ret_Emp_Title_title" FOREIGN KEY("title")
REFERENCES "titles" ("title");

ALTER TABLE "emp_for_Mentorship" ADD CONSTRAINT "fk_emp_for_Mentorship_emp_no_first_name_last_name" FOREIGN KEY("emp_no", "first_name", "last_name")
REFERENCES "employees" ("emp_no", "first_name", "last_name");

ALTER TABLE "emp_for_Mentorship" ADD CONSTRAINT "fk_emp_for_Mentorship_to_date" FOREIGN KEY("to_date")
REFERENCES "dept_emp" ("to_date");

ALTER TABLE "emp_for_Mentorship" ADD CONSTRAINT "fk_emp_for_Mentorship_from_date" FOREIGN KEY("from_date")
REFERENCES "dept_emp" ("to_date");

ALTER TABLE "emp_for_Mentorship" ADD CONSTRAINT "fk_emp_for_Mentorship_title" FOREIGN KEY("title")
REFERENCES "titles" ("title");

