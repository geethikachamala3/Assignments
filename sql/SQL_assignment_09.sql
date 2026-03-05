-- q1.List employees who earn more than the company average salary. Use a subquery for the average.
select employee_id,first_name,last_name,salary
from hr.employees 
where salary>(select avg(salary) from hr.employees);
-- q2.List employees whose department_id exists in hr.departments (i.e. they belong to a valid department). Use IN with a subquery.
select employee_id,first_name,last_name,department_id
from hr.EMPLOYEES
where department_id in(select department_id from hr.DEPARTMENTS);
-- q3.Show department names from hr.departments along with the count of employees in that department. Use a scalar subquery in the SELECT list for the count (correlated by department_id).
select d.department_id,d.department_name,
(select count(*) from hr.employees e 
where e.department_id=d.department_id) as employee_count
from hr.departments d;
-- ================================================================
-- M1. List employees with salary > (SELECT AVG(salary) FROM hr.employees). Hint: WHERE salary > (scalar subquery).
select * from hr.employees where salary>(select avg(salary) from hr.employees);
-- M2. List employees where department_id IN (SELECT department_id FROM hr.departments). Hint: IN with subquery.
select * from hr.employees where department_id in(select department_id from hr.departments);
-- M3. Show employee_id, salary, and (SELECT AVG(salary) FROM hr.employees) AS avg_sal in SELECT. Hint: Scalar subquery in SELECT list.
select employee_id,salary,(select avg(salary) from hr.employees) as avg_sal from hr.employees order by employee_id;
-- M4. List departments where (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) > 3. Hint: Correlated scalar in WHERE.
select d.department_id,
       d.department_name
from hr.DEPARTMENTS d
where(
    select count(*) 
    from hr.employees e 
    where e.department_id=d.department_id
)>3
order by d.department_id;      
-- M5. List employees where department_id IN (SELECT department_id FROM hr.departments WHERE department_id IN (10,20,30)). Hint: IN (subquery).
select employee_id,
       first_name,
       last_name,
       department_id
from hr.employees       
where department_id IN(
    select department_id
    from hr.DEPARTMENTS
    where department_id in(10,20,30)
)
order by department_id,employee_id;   
-- M6. Show department_id, department_name, (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) FROM hr.departments d. Hint: Correlated scalar in SELECT.
select department_id,
       department_name,
       (
        select count(*)
        from hr.employees e
        where e.department_id=d.department_id
       ) as employee_count
from hr.departments d
order by d.department_id;     
-- M7. List employees with salary < (SELECT MIN(salary) FROM hr.employees WHERE department_id = 50). Hint: Scalar subquery for min in dept 50.
select employee_id,
       first_name,
       last_name,
       salary
from hr.employees 
WHERE salary<(
    select min(salary) 
    from hr.EMPLOYEES 
    where department_id=50
)
order by salary;
-- M8. Show employee_id, first_name, (SELECT department_name FROM hr.departments d WHERE d.department_id = e.department_id) FROM hr.employees e. Hint: Correlated scalar in SELECT.
select employee_id,
       first_name,
       (
            select d.department_name 
            from hr.departments d
            where d.department_id=e.department_id
       ) as department_name
from hr.employees e
order by e.employee_id;    
-- M9. List departments that have at least one employee using EXISTS         
select d.department_id,
       d.department_name
from hr.departments d
where exists(
    select 1 
    from hr.employees e
    where e.department_id=d.department_id
) 
order by d.department_id;   
-- M10. List employees where job_id IN (SELECT DISTINCT job_id FROM hr.employees WHERE department_id = 80). Hint: IN (subquery).
select * from hr.employees 
where job_id in(
    select distinct job_id
    from hr.employees
    where department_id=80
);
-- M11. Show department_id, (SELECT SUM(salary) FROM hr.employees e WHERE e.department_id = d.department_id) FROM hr.departments d. Hint: Correlated scalar in SELECT.
select department_id,
    (
        select sum(salary)
        from hr.employees e
        where e.department_id=d.department_id
    )from hr.departments d;
-- M12. List employees with salary between (SELECT MIN(salary) FROM hr.employees) and (SELECT MAX(salary) FROM hr.employees). Hint: Two scalar subqueries in BETWEEN.
select * from hr.EMPLOYEES
where salary between
    (select min(salary) from hr.employees)
 and(select max(salary) from hr.employees)
order by salary;
-- M13. List employees where department_id NOT IN (SELECT department_id FROM hr.departments WHERE department_id IS NOT NULL). Hint: NOT IN (subquery); exclude NULL in subquery to avoid logic issues.
select employee_id,
       first_name,
       last_name,
       DEPARTMENT_ID
from hr.employees 
where department_id NOT IN(
    select department_id 
    from hr.departments 
    where department_id IS NOT NULL
)
order by employee_id;    
-- M14. Show employee_id, salary, (SELECT MAX(salary) FROM hr.employees) - salary AS diff_from_max. Hint: Scalar subquery in expression.
select employee_id,
       salary,
       (
        select max(salary)
        from hr.employees
       )-salary as diff_from_max
from hr.employees;       
-- M15. List departments where (SELECT AVG(salary) FROM hr.employees e WHERE e.department_id = d.department_id) > 7000. Hint: Correlated scalar in WHERE.
select d.department_id,
       d.department_name
from hr.departments d
where(
    select avg(e.salary)
    from hr.employees e
    where e.department_id=d.department_id
)>7000
order by d.department_id;   
-- M16. From (SELECT department_id, COUNT(*) c FROM hr.employees GROUP BY department_id) sub, SELECT * WHERE c > 5. Hint: Derived table in FROM with alias.
select * from(
    select department_id,
    count(*) as emp_count
    from hr.employees 
    group by department_id
)
where emp_count>5
order by department_id;
-- M17. List employees with salary >= (SELECT AVG(salary) FROM hr.employees WHERE job_id = e.job_id). Hint: Correlated subquery comparing to job average.
select e.employee_id,
       e.first_name,
       e.last_name,
       e.job_id,
       e.salary
from hr.employees e
where e.salary>=(
    select avg(salary)
    from hr.EMPLOYEES
    where job_id=e.JOB_ID
)
order by e.job_id,e.salary desc;
-- M18. Show department_name and (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) FROM hr.departments d. Hint: Correlated count in SELECT.
SELECT d.department_name,
       (SELECT COUNT(*)
        FROM hr.employees e
        WHERE e.department_id = d.department_id) AS emp_count
FROM hr.departments d
ORDER BY d.department_name;
-- M19. List employees where EXISTS (SELECT 1 FROM hr.departments d WHERE d.department_id = e.department_id). Hint: EXISTS with correlation.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.department_id
FROM hr.employees e
WHERE EXISTS (
    SELECT 1
    FROM hr.departments d
    WHERE d.department_id = e.department_id
)
ORDER BY e.employee_id;
-- M20. From (SELECT job_id, AVG(salary) avg_sal FROM hr.employees GROUP BY job_id) sub, select job_id, avg_sal where avg_sal > 8000. Hint: Derived table, then filter.
SELECT job_id,
       avg_sal
FROM (
    SELECT job_id,
           AVG(salary) AS avg_sal
    FROM hr.employees
    GROUP BY job_id
) sub
WHERE avg_sal > 8000
ORDER BY avg_sal DESC;
-- ===========================================
-- H1. Employees whose salary is in the top 5 company-wide (salary >= (SELECT MIN(salary) FROM (SELECT salary FROM hr.employees ORDER BY salary DESC FETCH FIRST 5 ROWS ONLY))). Hint: Subquery in FROM or scalar with nested subquery.
SELECT employee_id,
       first_name,
       last_name,
       salary
FROM hr.employees
WHERE salary >= (
    SELECT MIN(salary)
    FROM (
        SELECT salary
        FROM hr.employees
        ORDER BY salary DESC
        FETCH FIRST 5 ROWS ONLY
    )
)
ORDER BY salary DESC;
-- H2. Departments where total salary > (SELECT AVG(total) FROM (SELECT SUM(salary) total FROM hr.employees GROUP BY department_id)). Hint: HAVING SUM(salary) > (scalar from derived table).
SELECT department_id,
       SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(salary) AS total
        FROM hr.employees
        GROUP BY department_id
    )
)
ORDER BY total_salary DESC;
-- H3. Employees who have the same job_id as their manager (correlated: (SELECT job_id FROM hr.employees m WHERE m.employee_id = e.manager_id) = e.job_id). Hint: Correlated scalar subquery.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.job_id,
       e.manager_id
FROM hr.employees e
WHERE e.job_id = (
    SELECT m.job_id
    FROM hr.employees m
    WHERE m.employee_id = e.manager_id
)
ORDER BY e.employee_id;
-- H4. Show employee_id, salary, and (SELECT department_name FROM hr.departments d WHERE d.department_id = e.department_id) and (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id). Hint: Two correlated scalars in SELECT.
SELECT e.employee_id,
       e.salary,
       (SELECT d.department_name
        FROM hr.departments d
        WHERE d.department_id = e.department_id) AS department_name,
       (SELECT COUNT(*)
        FROM hr.employees e2
        WHERE e2.department_id = e.department_id) AS dept_emp_count
FROM hr.employees e
ORDER BY e.employee_id;
-- H5. List departments that have more employees than (SELECT AVG(cnt) FROM (SELECT COUNT(*) cnt FROM hr.employees GROUP BY department_id)). Hint: Correlated count in HAVING vs scalar from derived table.
SELECT department_id,
       COUNT(*) AS emp_count
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM hr.employees
        GROUP BY department_id
    )
)
ORDER BY emp_count DESC;
-- H6. Employees where salary > all salaries in department 50 (salary > (SELECT MAX(salary) FROM hr.employees WHERE department_id = 50)). Hint: Use MAX in subquery for "greater than all."
SELECT employee_id,
       first_name,
       last_name,
       salary,
       department_id
FROM hr.employees
WHERE salary > (
    SELECT MAX(salary)
    FROM hr.employees
    WHERE department_id = 50
)
ORDER BY salary DESC;
-- H7. From (SELECT department_id, COUNT(*) c, SUM(salary) s FROM hr.employees GROUP BY department_id) join hr.departments on department_id; show department_name, c, s. Hint: Derived table join departments.
SELECT d.department_name,
       sub.c AS emp_count,
       sub.s AS total_salary
FROM (
    SELECT department_id,
           COUNT(*) AS c,
           SUM(salary) AS s
    FROM hr.employees
    GROUP BY department_id
) sub
JOIN hr.departments d
  ON sub.department_id = d.department_id
ORDER BY d.department_name;
-- H8. Employees whose department has exactly 3 people: WHERE (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id) = 3. Hint: Correlated count = 3.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.department_id,
       e.salary
FROM hr.employees e
WHERE (
    SELECT COUNT(*)
    FROM hr.employees e2
    WHERE e2.department_id = e.department_id
) = 3
ORDER BY e.department_id, e.employee_id;
-- H9. Departments where manager_id is in (SELECT employee_id FROM hr.employees) (department's manager exists). Hint: WHERE d.manager_id IN (SELECT employee_id FROM hr.employees).
SELECT d.department_id,
       d.department_name,
       d.manager_id
FROM hr.departments d
WHERE d.manager_id IN (
    SELECT employee_id
    FROM hr.employees
)
ORDER BY d.department_id;
-- H10. Show each employee_id and (SELECT first_name||' '||last_name FROM hr.employees m WHERE m.employee_id = e.manager_id) AS manager_name. Hint: Correlated scalar in SELECT.
SELECT e.employee_id,
       (SELECT m.first_name || ' ' || m.last_name
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id) AS manager_name
FROM hr.employees e
ORDER BY e.employee_id;
-- H11. List employees in department_id that has the highest total salary (department_id IN (SELECT department_id FROM (SELECT department_id, SUM(salary) s FROM hr.employees GROUP BY department_id ORDER BY s DESC FETCH FIRST 1 ROW ONLY))). Hint: Subquery in FROM + ORDER BY + FETCH; then IN.
SELECT employee_id,
       first_name,
       last_name,
       salary,
       department_id
FROM hr.employees
WHERE department_id IN (
    SELECT department_id
    FROM (
        SELECT department_id,
               SUM(salary) AS s
        FROM hr.employees
        GROUP BY department_id
        ORDER BY s DESC
        FETCH FIRST 1 ROW ONLY
    )
)
ORDER BY salary DESC;
-- H12. Employees where salary > (SELECT AVG(salary) FROM hr.employees e2 WHERE e2.department_id = e.department_id) * 1.1. Hint: Correlated avg * 1.1.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       e.department_id
FROM hr.employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM hr.employees e2
    WHERE e2.department_id = e.department_id
) * 1.1
ORDER BY e.department_id, e.salary DESC;
-- H13. Departments with no employees: NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id). Hint: NOT EXISTS correlated.
SELECT d.department_id,
       d.department_name
FROM hr.departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM hr.employees e
    WHERE e.department_id = d.department_id
)
ORDER BY d.department_id;
-- H14. Show department_id, department_name, (SELECT AVG(salary) FROM hr.employees e WHERE e.department_id = d.department_id), (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) FROM hr.departments d. Hint: Two correlated scalars.
SELECT d.department_id,
       d.department_name,

       /* Correlated subquery 1: Department average salary */
       (SELECT AVG(e.salary)
        FROM hr.employees e
        WHERE e.department_id = d.department_id) AS avg_salary,

       /* Correlated subquery 2: Department employee count */
       (SELECT COUNT(*)
        FROM hr.employees e
        WHERE e.department_id = d.department_id) AS emp_count

FROM hr.departments d
ORDER BY d.department_id;
-- H15. List job_id and count from hr.employees where count > (SELECT AVG(cnt) FROM (SELECT COUNT() cnt FROM hr.employees GROUP BY job_id)). Hint: GROUP BY job_id HAVING COUNT() > (scalar from derived table).
SELECT job_id,
       COUNT(*) AS emp_count
FROM hr.employees
GROUP BY job_id
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM hr.employees
        GROUP BY job_id
    )
)
ORDER BY emp_count DESC;
-- H16. Employees whose hire_date is (SELECT MIN(hire_date) FROM hr.employees WHERE department_id = e.department_id). Hint: Correlated min: e.hire_date = (SELECT MIN(hire_date)...).
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.hire_date,
       e.department_id
FROM hr.employees e
WHERE e.hire_date = (
    SELECT MIN(e2.hire_date)
    FROM hr.employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id;
-- H17. From (SELECT department_id, ROUND(AVG(salary),2) a FROM hr.employees GROUP BY department_id) sub join hr.departments d on sub.department_id = d.department_id; show d.department_name, sub.a. Hint: Derived table join.
SELECT d.department_name,
       sub.a AS avg_salary
FROM (
    SELECT department_id,
           ROUND(AVG(salary), 2) AS a
    FROM hr.employees
    GROUP BY department_id
) sub
JOIN hr.departments d
  ON sub.department_id = d.department_id
ORDER BY d.department_name;
-- H18. Employees where salary >= (SELECT MAX(salary) FROM hr.employees e2 WHERE e2.department_id = e.department_id) * 0.9. Hint: Correlated max * 0.9 (within 10% of dept max).
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       e.department_id
FROM hr.employees e
WHERE e.salary >= (
    SELECT MAX(e2.salary)
    FROM hr.employees e2
    WHERE e2.department_id = e.department_id
) * 0.9
ORDER BY e.department_id, e.salary DESC;
-- H19. Departments where (SELECT COUNT(DISTINCT job_id) FROM hr.employees e WHERE e.department_id = d.department_id) >= 2. Hint: Correlated count distinct in WHERE.
SELECT d.department_id,
       d.department_name
FROM hr.departments d
WHERE (
    SELECT COUNT(DISTINCT e.job_id)
    FROM hr.employees e
    WHERE e.department_id = d.department_id
) >= 2
ORDER BY d.department_id;
-- H20. Show employee_id, salary, (SELECT AVG(salary) FROM hr.employees), salary - (SELECT AVG(salary) FROM hr.employees) AS diff. Hint: Two uses of same scalar subquery in SELECT.
SELECT e.employee_id,
       e.salary,
       (SELECT AVG(salary) FROM hr.employees) AS avg_salary,
       e.salary - (SELECT AVG(salary) FROM hr.employees) AS diff
FROM hr.employees e
ORDER BY e.salary DESC;