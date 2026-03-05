--question1 :List employees in department_id 50.
select * from hr.DEPARTMENTS where DEPARTMENT_ID=50;
--question 2List employees whose salary is between 5000 and 10000 
select * from hr.EMPLOYEES where salary between 5000 and 10000;
--question 3:List employees whose last name starts with 'K'
select * from hr.EMPLOYEES where lower(LAST_NAME) like 'k%';
select * from hr.employees;
--question 4:List the top 5 highest-paid employees (employee_id, first_name, salary)
select * from hr.employees order by salary desc fetch first 5 rows only;
select * from hr.employees order by salary desc;
--question1:List employees who have no commission_pct (NULL).
select * from hr.EMPLOYEES where COMMISSION_PCT is null;
--question 2:List employees whose job_id contains the string 'MAN'.
select * from hr.employees where lower(JOB_ID) like '%man%';
==================================
--question 1:List employees in department_id 80 with salary greater than 8000.
select * from hr.employees where department_id=80 and salary>8000;
--question 2: Find employees whose last_name ends with 'n'.
select * from hr.employees where last_name like '%n';
--quetion 3:List employees hired after January 1, 2005.
select * from hr.employees where hire_date>=date '2005-01-01';
--question 4:Get employees whose job_id is either 'SA_REP' or 'SA_MAN'.
select * from hr.employees where JOB_ID='SA_REP' OR JOB_ID='SA_MAN';
SELECT * FROM HR.EMPLOYEES WHERE JOB_ID IN('SA_REP','SA_MAN');
--question 5:List employees with salary between 4000 and 7000 (inclusive).
select * from hr.employees WHERE salary between 4000 and 7000;
--question 6: Find employees who have a manager (manager_id is not null).
select * from hr.employees where manager_id is not null;
--question 7:List departments with department_id 10, 20, or 30 from hr.departments.
select * from hr.employees where department_id in(10,20,30);
--question 8:Get the top 3 employees by hire_date (oldest first).
select * from hr.employees order by hire_date fetch first 3 rows only; 
--question 9:List employees in department 50, ordered by last_name ascending.
select * from hr.employees where department_id=50 order by last_name;
--question 10:Find employees whose first_name starts with 'J'.
select * from hr.employees where lower(first_name) like 'j%';
--question 11:List employees with salary not in the range 5000 to 10000
select * from hr.employees where salary not between 5000 and 10000;
select * from hr.employees where salary<5000 or salary>10000;
--question 12: Get employees whose job_id contains 'CLERK'.
select * from hr.employees where lower(job_id) like '%clerk%';
--question 13:List employees with commission_pct greater than 0.2.
select * from hr.employees where commission_pct>0.2;
--question 14:Find the 10 most recently hired employees.
select * from hr.employees order by hire_date desc fetch first 10 rows only;
--question 15: List employees in departments 50 or 60, ordered by department_id then salary descending.
select * from hr.employees WHERE department_id in(50,60) order by department_id,salary desc;
--question 16: Get employees whose last_name has exactly 5 characters.
select * from hr.employees where last_name like '_____';
--question 17:List departments where manager_id is not null from hr.departments.
select * from hr.departments where manager_id is not null;
--question 18: Find employees with salary >= 10000, ordered by salary ascending.
select * from hr.employees where salary>=10000 order by salary;
--question 19:List employees whose email ends with '.com' or contains 'example' (if applicable; otherwise use a pattern that exists).
select * from hr.employees where email like '%.com';
select * from hr.employees;
--question 20:Get distinct job_id values from employees in department 50.
select distinct job_id from hr.employees where department_id=50;
===============================
--question 1:List employees in department 80 with salary > 7000 OR job_id = 'SA_MAN', ordered by salary DESC.
select * from hr.employees where (department_id=80 and salary>7000) or job_id='SA_MAN' order by salary desc;
--question 2:Find employees hired between Jan 1, 2000 and Dec 31, 2005.
SELECT * FROM HR.EMPLOYEES WHERE hire_date BETWEEN DATE '2000-01-01' AND DATE '2005-12-31';
--QUESTION 3:List employees whose last_name is 4 characters and starts with 'K'.
SELECT * FROM HR.EMPLOYEES WHERE LAST_NAME LIKE 'K____';
--QUESTION 4: Get top 5 highest-paid employees in department 50 only.
SELECT * FROM HR.EMPLOYEES ORDER BY SALARY DESC FETCH FIRST 5 ROWS ONLY;
--QUESTION 5: List employees with no manager and salary > 5000.
SELECT * FROM HR.EMPLOYEES WHERE manager_id IS NULL AND SALARY>5000;
--QUESTION 6:Find employees whose first_name has an 'a' as the second character.
SELECT * FROM HR.EMPLOYEES WHERE FIRST_NAME LIKE '_a%'
--QUESTION 7:List departments (hr.departments) with department_id between 40 and 90.
SELECT * FROM HR.EMPLOYEES WHERE DEPARTMENT_ID BETWEEN 40 AND 90; 
--QUESTION 8: Get employees with salary < 3000 or salary > 15000, ordered by salary.
SELECT * FROM HR.EMPLOYEES WHERE SALARY>3000 AND SALARY<15000 ORDER BY SALARY;
--QUESTION 9:List employees in department 60 with job_id 'IT_PROG', or in department 100 with job_id like 'FI%'.
SELECT * FROM HR.EMPLOYEES WHERE (DEPARTMENT_ID=60 AND JOB_ID='IT_PROG')
                                OR (DEPARTMENT_ID=100 AND JOB_ID LIKE 'FI%');
SELECT * FROM HR.EMPLOYEES;
--QUESTION 10:Find employees whose hire_date is in the year 2003.
SELECT * FROM HR.EMPLOYEES WHERE TO_CHAR(hire_date,'YYYY')='2003';
SELECT * FROM HR.EMPLOYEES WHERE EXTRACT(YEAR FROM HIRE_DATE)=2003;
--QUESTION 11: List employees with commission_pct NULL and job_id starting with 'SA'.
SELECT * FROM HR.EMPLOYEES WHERE COMMISSION_PCT IS NULL AND JOB_ID LIKE 'SA%';
--QUESTION 12:Get the 3 oldest employees (earliest hire_date) in department 90.
SELECT * FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=90 
                                ORDER BY HIRE_DATE FETCH FIRST 3 ROWS ONLY;
--QUESTION 13: List employees whose last_name does not start with 'A', 'B', or 'C
SELECT * FROM HR.EMPLOYEES WHERE LAST_NAME NOT LIKE 'A%' AND LAST_NAME NOT LIKE 'B%' AND LAST_NAME NOT LIKE 'C%';
SELECT * FROM HR.EMPLOYEES WHERE SUBSTR(LAST_NAME,1,1) NOT IN ('A','B','C');
--QUESTION 14:Find employees with salary in (5000, 6000, 7000, 8000).
SELECT * FROM HR.EMPLOYEES WHERE SALARY IN(5000,6000,7000,8000);
--QUESTION 15:List employees ordered by department_id ASC, then by hire_date DESC within each department.
SELECT * FROM HR.EMPLOYEES ORDER BY DEPARTMENT_ID,HIRE_DATE DESC;
--QUESTION 16:Get employees whose first_name and last_name both start with the same letter 
SELECT * FROM HR.EMPLOYEES WHERE SUBSTR(FIRST_NAME,1,1)=SUBSTR(LAST_NAME,1,1);
--QUESTION 17:List employees with manager_id not null and department_id in (50, 80, 100).
SELECT * FROM HR.EMPLOYEES WHERE manager_id IS NOT NULL AND DEPARTMENT_ID IN(50,80,100);
--QUESTION 18:Find employees with salary between 3000 and 5000 and job_id containing 'REP'
SELECT * FROM HR.EMPLOYEES WHERE SALARY BETWEEN 3000 AND 5000 AND JOB_ID LIKE '%REP%';
SELECT * FROM HR.EMPLOYEES WHERE SALARY>3000 AND SALARY>5000 AND JOB_ID LIKE '%REP%';
--QUESTION 19:List departments (hr.departments) ordered by department_name descending.
SELECT * FROM HR.DEPARTMENTS ORDER BY DEPARTMENT_ID DESC;
--QUESTION 20: Get employees with hire_date not in 2004 (all years except 2004).
SELECT * FROM HR.EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY')!='2004';
SELECT * FROM HR.EMPLOYEES WHERE EXTRACT(YEAR FROM HIRE_DATE)<>2004;

