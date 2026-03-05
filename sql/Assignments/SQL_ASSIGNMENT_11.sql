-- q1.List job_id values that appear in employees in department 50 UNION job_id values that appear in employees in department 60. (Each SELECT returns one column job_id.)
select job_id
from hr.EMPLOYEES
where department_id=50
union
select job_id 
from hr.employees 
where department_id=60;
-- q2.List department_id values that appear in both hr.employees and hr.departments (departments that have at least one employee and are in the departments table). Use INTERSECT.
select department_id 
from hr.EMPLOYEES
INTERSECT
select department_id 
from hr.departments;
-- q3.List department_id values that are in hr.departments but have no employees in hr.employees. Use MINUS.
select department_id
from hr.DEPARTMENTS
MINUS
select department_id 
from hr.EMPLOYEES;
-- q4.Use UNION to combine two queries: employees with salary in range 3000–6000 and employees with salary in range 5000–8000. Show employee_id and salary. Observe how UNION removes duplicates.
select employee_id,salary
from hr.EMPLOYEES
where salary between 3000 and 6000
UNION
select employee_id,salary
from hr.EMPLOYEES
where salary between 5000 and 8000;
-- q5.Use INTERSECT to find manager_id values that appear in both hr.employees (as manager_id) and in hr.employees (as employee_id)—i.e. managers who are themselves employees.
select manager_id
from hr.EMPLOYEES
where manager_id is not null
INTERSECT
select EMPLOYEE_ID
from hr.employees;
-- ===========================================================
-- M1. UNION job_id from department 50 and job_id from department 60. Hint: Two SELECTs with same one column, UNION.
select job_id from hr.employees where DEPARTMENT_ID=50
UNION
select job_id from hr.employees where DEPARTMENT_ID=60;
-- M2. UNION ALL employee_id, first_name from department 50 and from department 80. Hint: Same columns, UNION ALL.
select employee_id,first_name from hr.EMPLOYEES where department_id=50
union all
select employee_id,first_name from hr.EMPLOYEES where department_id=80;
-- M3. INTERSECT department_id from hr.employees and department_id from hr.departments. Hint: Returns dept_ids in both.
select department_id from hr.employees 
INTERSECT
select department_id from hr.departments;
-- M4. MINUS: department_id from hr.departments MINUS department_id from hr.employees (depts with no employees). Hint: First query minus second.select department_id from hr.departments;
select department_id from hr.departments
minus
select department_id from hr.employees;
-- M5. UNION ALL first_name, last_name from employees where salary > 10000 and first_name, last_name from employees where department_id = 90. Hint: Two columns, UNION ALL.
select first_name,last_name from hr.employees where salary>10000
union all
select first_name,last_name from hr.employees where department_id=90;
-- M6. INTERSECT job_id from employees where department_id = 50 and job_id from employees where department_id = 80. Hint: Jobs in both depts.
select job_id from hr.EMPLOYEES where department_id=50
INTERSECT
select job_id from hr.EMPLOYEES where department_id=80;
-- M7. MINUS: employee_id from employees MINUS employee_id from (select manager_id from employees where manager_id is not null). Hint: Employees who are not managers (if manager_id list is from employees).
select employee_id from hr.employees
minus
select manager_id from hr.employees where manager_id is not null;
-- M8. UNION department_id from employees and department_id from departments; ORDER BY 1. Hint: UNION then ORDER BY 1 at end.
select department_id from hr.employees
UNION
select DEPARTMENT_ID FROM HR.DEPARTMENTS
ORDER BY 1; 
-- M9. UNION ALL select 10, 'Dept10' from dual and select 20, 'Dept20' from dual (two columns). Hint: Literals; use dual; same number of columns.
SELECT 10 AS dept_id, 'Dept10' AS dept_name FROM dual
UNION ALL
SELECT 20 AS dept_id, 'Dept20' AS dept_name FROM dual;
-- M10. INTERSECT manager_id from employees (where not null) and employee_id from employees. Hint: People who are managers (appear as manager_id and as employee_id).
SELECT MANAGER_ID FROM HR.EMPLOYEES
INTERSECT
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES;
-- M11. MINUS: job_id from employees where department_id = 80 MINUS job_id from employees where department_id = 50. Hint: Jobs in 80 but not in 50.
SELECT JOB_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=80
MINUS
SELECT JOB_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50;
-- M12. UNION salary (as one column) from employees where department_id = 50 and salary from employees where department_id = 60; show distinct salaries. Hint: One column, UNION.
SELECT SALARY FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50
UNION
SELECT SALARY FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=60;
-- M13. INTERSECT department_id from departments and department_id from employees (same as depts that have employees). Hint: INTERSECT two single-column queries.
SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS 
INTERSECT
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES;
-- M14. UNION ALL employee_id, salary from employees where salary < 5000 and employee_id, salary from employees where salary > 15000. Hint: Two columns, UNION ALL.
SELECT EMPLOYEE_ID,SALARY FROM HR.EMPLOYEES WHERE SALARY<5000
UNION ALL
SELECT EMPLOYEE_ID,SALARY FROM HR.EMPLOYEES WHERE SALARY>15000;
-- M15. MINUS: department_id from employees MINUS department_id from departments (employees' dept_ids not in departments table—usually empty). Hint: First minus second.
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES 
MINUS
SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS;
-- M16. UNION first_name from employees where job_id = 'SA_REP' and first_name from employees where job_id = 'SA_MAN'. Hint: One column, UNION.
SELECT FIRST_NAME FROM HR.EMPLOYEES WHERE JOB_ID='SA_REP'
UNION
SELECT FIRST_NAME FROM HR.EMPLOYEES WHERE JOB_ID='SA_MAN';
-- M17. INTERSECT job_id from employees and job_id from (SELECT job_id FROM hr.employees WHERE department_id = 90). Hint: INTERSECT with subquery (all jobs vs jobs in 90).
SELECT JOB_ID FROM HR.EMPLOYEES 
INTERSECT
SELECT JOB_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50;
-- M18. UNION ALL select department_id, department_name from departments where department_id = 10 and select department_id, department_name from departments where department_id = 20. Hint: Two columns from same table, different filter.
SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID=10
UNION ALL
SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID=20;
-- M19. MINUS: employee_id from employees where department_id = 50 MINUS employee_id from employees where salary > 7000. Hint: In dept 50 but not in high-salary set (interpret: IDs in first set not in second).
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50
MINUS
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE SALARY>7000;
-- M20. UNION (no ALL) department_id from employees and department_id from departments. Hint: Distinct department_ids from both tables.
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES
UNION
SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS;
-- ======================================================
-- H1. UNION of three queries: department_id from employees where salary < 3000, where salary between 3000 and 8000, and where salary > 8000 (one column). Hint: Three SELECTs, UNION.
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE SALARY<3000
UNION
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE SALARY BETWEEN 3000 AND 8000
UNION
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE SALARY>8000;
-- H2. INTERSECT of manager_id from employees and employee_id from employees (managers who are employees). Hint: INTERSECT; use WHERE manager_id IS NOT NULL in first if needed.
SELECT MANAGER_ID FROM HR.EMPLOYEES 
INTERSECT
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES;
-- H3. MINUS: departments.department_id MINUS employees.department_id; then join result to departments to show department_name. Hint: Use subquery: SELECT d.department_id, d.department_name FROM hr.departments d WHERE d.department_id IN (SELECT department_id FROM hr.departments MINUS SELECT department_id FROM hr.employees).
SELECT d.department_id, d.department_name
FROM hr.departments d
WHERE d.department_id IN (
    SELECT department_id
    FROM hr.departments
MINUS
SELECT department_id FROM hr.employees
);
-- H4. UNION ALL of (employee_id, first_name, last_name, 'A' as flag) from employees where salary > 10000 and same columns with 'B' from employees where salary <= 10000. Hint: Add literal flag column to each SELECT; same 4 columns.
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME FROM HR.EMPLOYEES WHERE SALARY>10000
UNION ALL
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME FROM HR.EMPLOYEES WHERE SALARY<=10000;
-- H5. INTERSECT job_id from employees where department_id IN (10,20) and job_id from employees where department_id IN (50,60). Hint: Jobs that appear in both sets of departments.
SELECT JOB_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID IN(10,20)
INTERSECT
SELECT JOB_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID IN(50,60);
-- H6. MINUS: (SELECT employee_id FROM hr.employees) MINUS (SELECT manager_id FROM hr.employees WHERE manager_id IS NOT NULL). Hint: Employees who are not anyone's manager.
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES
minus
SELECT MANAGER_ID FROM HR.EMPLOYEES WHERE MANAGER_ID IS NOT NULL;
-- H7. UNION of department_id, COUNT(*) from employees group by department_id and department_id, 0 from departments (show all depts with count or 0). Hint: Need same columns: dept_id and number; second from departments with literal 0; then union with first grouped query—but column types/count must match (grouped gives 2 cols; second query 2 cols).
SELECT DEPARTMENT_ID,COUNT(*) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID
UNION
SELECT DEPARTMENT_ID,0 AS EMP_COUNT FROM HR.DEPARTMENTS;
-- H8. INTERSECT (department_id, job_id) from employees where salary > 5000 and (department_id, job_id) from employees where commission_pct is not null. Hint: Two columns in each SELECT; INTERSECT (dept,job) pairs.
SELECT DEPARTMENT_ID,JOB_ID FROM HR.EMPLOYEES WHERE SALARY>5000
INTERSECT
SELECT DEPARTMENT_ID,JOB_ID FROM HR.EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
-- H9. MINUS: (employee_id, manager_id) from employees where manager_id is not null MINUS (employee_id, manager_id) from employees where department_id = 50. Hint: Pairs in first set not in second (two columns).
SELECT EMPLOYEE_ID,MANAGER_ID FROM HR.EMPLOYEES WHERE MANAGER_ID IS NOT NULL
MINUS
SELECT EMPLOYEE_ID,MANAGER_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50;
-- H10. UNION ALL list of department_id from employees and department_id from departments; then use this in a query to count how many times each department_id appears. Hint: SELECT department_id, COUNT(*) FROM (SELECT department_id FROM hr.employees UNION ALL SELECT department_id FROM hr.departments) sub GROUP BY department_id.
SELECT department_id, COUNT(*) AS dept_count
FROM (
    SELECT department_id FROM hr.employees
UNION ALL
 SELECT department_id FROM hr.departments
) sub
GROUP BY department_id
ORDER BY department_id;
-- H11. INTERSECT (first_name, last_name) from employees where department_id = 50 and (first_name, last_name) from employees where department_id = 80. Hint: Same name in both departments (two columns).
SELECT FIRST_NAME,LAST_NAME FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50
INTERSECT
SELECT FIRST_NAME,LAST_NAME FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=80;
-- H12. MINUS: job_id from employees MINUS job_id from employees where hire_date >= DATE '2005-01-01'. Hint: Jobs that have no one hired in 2005 or later (jobs only in older hires).
SELECT JOB_ID FROM HR.EMPLOYEES 
MINUS
SELECT JOB_ID FROM HR.EMPLOYEES WHERE hire_date>=DATE '2005-01-01';
-- H13. UNION (SELECT department_id, SUM(salary) FROM hr.employees GROUP BY department_id) and (SELECT NULL, SUM(salary) FROM hr.employees) for grand total. Hint: Two columns; second row is NULL, total; types must match (NUMBER, NUMBER).
SELECT DEPARTMENT_ID,SUM(SALARY) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID
UNION
SELECT NULL AS DEPARTMENT_ID,SUM(SALARY) FROM HR.EMPLOYEES;
-- H14. INTERSECT department_id from employees where job_id = 'SA_REP' and department_id from employees where job_id = 'SA_MAN'. Hint: Departments that have both SA_REP and SA_MAN.
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE JOB_ID='SA_REP'
INTERSECT
SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE JOB_ID='SA_MAN';
-- H15. MINUS: (SELECT manager_id FROM hr.employees WHERE manager_id IS NOT NULL) MINUS (SELECT employee_id FROM hr.employees WHERE department_id = 90). Hint: Managers who are not in department 90.
SELECT MANAGER_ID FROM HR.EMPLOYEES WHERE MANAGER_ID IS NOT NULL
MINUS
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=90;
-- H16. UNION of employee_id, first_name, last_name, department_id from employees where salary > (SELECT AVG(salary) FROM hr.employees) and same from employees where salary < (SELECT AVG(salary) FROM hr.employees). Hint: Two scalar subqueries; same 4 columns.
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_ID FROM HR.EMPLOYEES 
WHERE SALARY>(SELECT AVG(SALARY) FROM HR.EMPLOYEES)
UNION
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_ID FROM HR,EMPLOYEES 
WHERE SALARY<(SELECT AVG(SALARY) FROM HR.EMPLOYEES);
-- H17. INTERSECT (department_id, job_id) from employees and (department_id, job_id) from (SELECT department_id, job_id FROM hr.employees GROUP BY department_id, job_id). Hint: Same (dept, job) pairs (INTERSECT with self is same set).
SELECT DEPARTMENT_ID,JOB_ID FROM HR.EMPLOYEES
INTERSECT
SELECT DEPARTMENT_ID,JOB_ID FROM(
    SELECT DEPARTMENT_ID,JOB_ID FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID,JOB_ID
);
-- H18. MINUS: employee_id from employees where department_id = 80 MINUS employee_id from employees where salary > 10000. Hint: In dept 80 but salary <= 10000 (IDs in first not in second).
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=80
MINUS
SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE SALARY>10000;
-- H19. UNION ALL (SELECT 1, department_id, COUNT() FROM hr.employees GROUP BY department_id) and (SELECT 2, NULL, COUNT() FROM hr.employees). Hint: Add level column 1 for dept rows, 2 for total; NULL for department_id in total row.
SELECT 1 AS level_num, department_id, COUNT(*) AS emp_count
FROM hr.employees
GROUP BY department_id
UNION ALL
SELECT 2 AS level_num, NULL AS department_id, COUNT(*) AS emp_count
FROM hr.employees;
-- H20. INTERSECT job_id from employees where department_id IN (SELECT department_id FROM hr.departments) and job_id from employees. Hint: INTERSECT with subquery (all jobs in valid depts vs all jobs—result is jobs in valid depts).
SELECT job_id
FROM hr.employees
WHERE department_id IN (SELECT department_id FROM hr.departments)
INTERSECT

SELECT job_id FROM hr.employees;
