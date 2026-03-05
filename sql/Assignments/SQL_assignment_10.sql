-- q1.List employees whose salary is above their department average. Use a correlated subquery that computes AVG(salary) for the same department_id.
select e.employee_id,
       e.first_name,
       e.salary,
       e.department_id
from hr.employees e 
where e.salary>(
    select avg(salary) 
    from hr.employees 
    where department_id=e.department_id);
-- q2.List departments that have no employees. Use NOT EXISTS with a correlated subquery.
select d.department_id,
       d.department_name 
       from hr.departments d
where not exists(select 1 from hr.employees e 
                 where e.department_id=d.department_id);   
-- q3.List employees whose salary is in the top 3 within their department. Use a correlated subquery that counts how many employees in the same department have a higher salary; keep only rows where that count is less than 3.
SELECT e.employee_id, 
       e.first_name, 
       e.salary, 
       e.department_id
FROM hr.employees e
WHERE (
  SELECT COUNT(DISTINCT salary) FROM hr.employees e2
  WHERE e2.department_id = e.department_id AND e2.salary > e.salary
) < 3;
-- ==========================================================
-- M1. Employees whose salary > department average (correlated: AVG(salary) WHERE department_id = e.department_id). Hint: WHERE e.salary > (SELECT AVG(salary) FROM hr.employees WHERE department_id = e.department_id).
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM hr.employees e
WHERE e.salary > (
        SELECT AVG(salary)
        FROM hr.employees
        WHERE department_id = e.department_id
    )
ORDER BY e.department_id;
-- M2. Departments with at least one employee: EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id). Hint: EXISTS correlated.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
    )
ORDER BY d.department_id;
-- M3. Departments with no employees: NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id). Hint: NOT EXISTS correlated.
select d.department_id,
       d.department_name
from hr.departments d
where not exists(
    select 1 from hr.employees e
    where e.department_id=d.department_id
)    
order by d.department_id; 
-- M4. Employees who earn more than their manager (correlated: salary > (SELECT salary FROM hr.employees m WHERE m.employee_id = e.manager_id)). Hint: Correlated scalar for manager salary.
select e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       e.manager_id
from hr.employees e     
where e.manager_id is not null and e.salary>(
    select m.salary
    from hr.employees m
    where m.employee_id=e.manager_id
) order by e.manager_id; 
-- M5. Departments where (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) = 0. Hint: Correlated count = 0; or use NOT EXISTS.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (SELECT COUNT(*) 
     FROM hr.employees e 
     WHERE e.department_id = d.department_id
    ) = 0
ORDER BY d.department_id;
-- M6. Employees where hire_date > (SELECT hire_date FROM hr.employees m WHERE m.employee_id = e.manager_id). Hint: Hired after manager (correlated).
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.hire_date,
    e.manager_id
FROM hr.employees e
WHERE e.manager_id IS NOT NULL
    AND e.hire_date > (
        SELECT m.hire_date
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.manager_id;
-- M7. Departments where (SELECT AVG(salary) FROM hr.employees e WHERE e.department_id = d.department_id) BETWEEN 5000 AND 10000. Hint: Correlated AVG in WHERE.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (SELECT AVG(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) BETWEEN 5000 AND 10000
ORDER BY d.department_id;
-- M8. Employees in department that has more than 5 people: (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id) > 5. Hint: Correlated count > 5.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM hr.employees e
WHERE (SELECT COUNT(*) 
     FROM hr.employees e2
     WHERE e2.department_id = e.department_id
    ) > 5
ORDER BY e.department_id;
-- M9. List departments d where EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id AND e.salary > 10000). Hint: EXISTS with extra condition.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
          AND e.salary > 10000
    )
ORDER BY d.department_id;
-- M10. Employees where (SELECT MIN(salary) FROM hr.employees e2 WHERE e2.department_id = e.department_id) = e.salary (lowest in dept). Hint: Correlated MIN = e.salary.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM hr.employees e
WHERE e.salary = (
        SELECT MIN(salary)
        FROM hr.employees e2
        WHERE e2.department_id = e.department_id
    )
ORDER BY e.department_id;
-- M11. Departments where (SELECT MAX(salary) FROM hr.employees e WHERE e.department_id = d.department_id) < 15000. Hint: Correlated MAX < 15000.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (SELECT MAX(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) < 15000
ORDER BY d.department_id;
-- M12. Employees whose manager_id is not in hr.employees (manager left): NOT EXISTS (SELECT 1 FROM hr.employees m WHERE m.employee_id = e.manager_id) AND e.manager_id IS NOT NULL. Hint: NOT EXISTS for manager; or manager_id NOT IN (SELECT employee_id FROM hr.employees).
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.manager_id
FROM  hr.employees e
WHERE e.manager_id IS NOT NULL
    AND NOT EXISTS (
        SELECT 1
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.manager_id;
-- M13. Employees where (SELECT job_id FROM hr.employees m WHERE m.employee_id = e.manager_id) = e.job_id (same job as manager). Hint: Correlated scalar job_id.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_id,
    e.manager_id
FROM hr.employees e
WHERE e.manager_id IS NOT NULL
    AND e.job_id = (
        SELECT m.job_id
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.manager_id;
-- M14. Departments where (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id AND e.commission_pct IS NOT NULL) > 0. Hint: Correlated count of commissioned > 0.
SELECT 
    d.department_id,
    d.department_name
FROM  hr.departments d
WHERE (SELECT COUNT(*) 
     FROM hr.employees e
     WHERE e.department_id = d.department_id
       AND e.commission_pct IS NOT NULL
    ) > 0
ORDER BY d.department_id;
-- M15. Employees where salary >= (SELECT MAX(salary) FROM hr.employees e2 WHERE e2.department_id = e.department_id) * 0.8. Hint: Within 80% of dept max.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM hr.employees e
WHERE e.salary >= (
        SELECT MAX(salary)
        FROM hr.employees e2
        WHERE e2.department_id = e.department_id
    ) * 0.8
ORDER BY e.department_id, e.salary DESC;
-- M16. List departments d where NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id AND e.hire_date < DATE '2000-01-01'). Hint: No employee hired before 2000 in dept.
SELECT 
    d.department_id,
    d.department_name
FROM  hr.departments d
WHERE NOT EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
          AND e.hire_date < DATE '2000-01-01'
    )
ORDER BY d.department_id;
-- M17. Employees where (SELECT department_name FROM hr.departments d WHERE d.department_id = e.department_id) = 'Sales'. Hint: Correlated department_name = 'Sales'.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id
FROM hr.employees e
WHERE (SELECT d.department_name
     FROM hr.departments d
     WHERE d.department_id = e.department_id
    ) = 'Sales'
ORDER BY e.employee_id;
-- M18. Departments where (SELECT SUM(salary) FROM hr.employees e WHERE e.department_id = d.department_id) > 100000. Hint: Correlated SUM > 100000.
SELECT 
    d.department_id,
    d.department_name
FROM  hr.departments d
WHERE (SELECT SUM(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) > 100000
ORDER BY d.department_id;
-- M19. Employees who are the only one in their department: (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id) = 1. Hint: Correlated count = 1.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id
FROM hr.employees e
WHERE (SELECT COUNT(*) 
     FROM hr.employees e2
     WHERE e2.department_id = e.department_id
    ) = 1
ORDER BY e.department_id;
-- M20. Departments d where EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id AND e.manager_id IS NULL). Hint: At least one employee in dept has no manager.
SELECT 
    d.department_id,
    d.department_name
FROM  hr.departments d
WHERE EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
          AND e.manager_id IS NULL
    )
ORDER BY d.department_id;
-- =============================================================
-- H1. Employees hired after their manager: e.hire_date > (SELECT hire_date FROM hr.employees m WHERE m.employee_id = e.manager_id). Hint: Correlated hire_date comparison.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.hire_date,
    e.manager_id
FROM  hr.employees e
WHERE e.manager_id IS NOT NULL
    AND e.hire_date > (
        SELECT m.hire_date
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.manager_id;
-- H2. Departments where every employee has commission_pct: NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id AND e.commission_pct IS NULL). Hint: No employee in dept with NULL commission.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE NOT EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
          AND e.commission_pct IS NULL
    )
ORDER BY d.department_id;
-- H3. Employees whose salary is second-highest in department (correlated: count how many have higher salary in dept = 1). Hint: (SELECT COUNT(DISTINCT e2.salary) FROM hr.employees e2 WHERE e2.department_id = e.department_id AND e2.salary > e.salary) = 1.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM  hr.employees e
WHERE (SELECT COUNT(DISTINCT e2.salary)
     FROM hr.employees e2
     WHERE e2.department_id = e.department_id
       AND e2.salary > e.salary
    ) = 1
ORDER BY e.department_id, e.salary DESC;
-- H4. Departments where (SELECT AVG(salary) FROM hr.employees e WHERE e.department_id = d.department_id) > (SELECT AVG(salary) FROM hr.employees). Hint: Dept avg > company avg.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (SELECT AVG(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) > (
        SELECT AVG(salary)
        FROM hr.employees
    )
ORDER BY d.department_id;
-- H5. Employees who have the same salary as their manager: e.salary = (SELECT salary FROM hr.employees m WHERE m.employee_id = e.manager_id). Hint: Correlated salary = manager salary.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.manager_id
FROM  hr.employees e
WHERE  e.manager_id IS NOT NULL
    AND e.salary = (
        SELECT m.salary
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.manager_id;
-- H6. List departments that have at least 2 employees with salary > 8000: (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id AND e.salary > 8000) >= 2. Hint: Correlated count with condition.
SELECT 
    d.department_id,
    d.department_name
FROM  hr.departments d
WHERE (SELECT COUNT(*) 
     FROM hr.employees e
     WHERE e.department_id = d.department_id
       AND e.salary > 8000
    ) >= 2
ORDER BY d.department_id;
-- /H7. Employees whose department has the highest total salary (dept in (SELECT department_id FROM (SELECT department_id, SUM(salary) s FROM hr.employees GROUP BY department_id ORDER BY s DESC FETCH FIRST 1 ROW ONLY))). Hint: Subquery in FROM + FETCH; then e.department_id IN.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM hr.employees e
WHERE e.department_id IN (
        SELECT department_id
        FROM (
            SELECT department_id, SUM(salary) AS s
            FROM hr.employees
            GROUP BY department_id
            ORDER BY s DESC
            FETCH FIRST 1 ROW ONLY
        )
    )
ORDER BY e.department_id;
-- H8. Departments where (SELECT COUNT(DISTINCT job_id) FROM hr.employees e WHERE e.department_id = d.department_id) >= 3. Hint: At least 3 distinct jobs in dept.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (SELECT COUNT(DISTINCT e.job_id)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) >= 3
ORDER BY d.department_id;
-- H9. Employees where (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id AND e2.salary > e.salary) <= 2 (top 3 salary in dept). Hint: At most 2 people earn more in dept.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM hr.employees e
WHERE (SELECT COUNT(*)
     FROM hr.employees e2
     WHERE e2.department_id = e.department_id
       AND e2.salary > e.salary
    ) <= 2
ORDER BY e.department_id, e.salary DESC;
-- H10. Departments d where NOT EXISTS (SELECT 1 FROM hr.employees e WHERE e.department_id = d.department_id) (no employees). Hint: NOT EXISTS.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE NOT EXISTS (
        SELECT 1
        FROM hr.employees e
        WHERE e.department_id = d.department_id
    )
ORDER BY d.department_id;
-- H11. Employees whose manager is in a different department: (SELECT department_id FROM hr.employees m WHERE m.employee_id = e.manager_id) <> e.department_id AND e.manager_id IS NOT NULL. Hint: Correlated manager department_id <> e.department_id.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.manager_id
FROM hr.employees e
WHERE e.manager_id IS NOT NULL
    AND e.department_id <> (
        SELECT m.department_id
        FROM hr.employees m
        WHERE m.employee_id = e.manager_id
    )
ORDER BY e.department_id;
-- H12. Departments where (SELECT MIN(salary) FROM hr.employees e WHERE e.department_id = d.department_id) > 4000. Hint: Correlated MIN > 4000.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (
    SELECT MIN(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) > 4000
ORDER BY d.department_id;
-- H13. Employees where (SELECT COUNT(*) FROM hr.employees e2 WHERE e2.department_id = e.department_id AND e2.hire_date < e.hire_date) = 0 (earliest hire in dept). Hint: No one hired before them in dept.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.hire_date,
    e.department_id
FROM hr.employees e
WHERE (
    SELECT COUNT(*)
     FROM hr.employees e2
     WHERE e2.department_id = e.department_id
       AND e2.hire_date < e.hire_date
    ) = 0
ORDER BY e.department_id;
-- H14. List departments that have exactly 5 employees: (SELECT COUNT(*) FROM hr.employees e WHERE e.department_id = d.department_id) = 5. Hint: Correlated count = 5.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (
    SELECT COUNT(*)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) = 5
ORDER BY d.department_id;
-- H15. Employees where salary > (SELECT AVG(salary) FROM hr.employees e2 WHERE e2.job_id = e.job_id). Hint: Above job average (correlated by job_id).
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.job_id
FROM hr.employees e
WHERE e.salary > (
        SELECT AVG(salary)
        FROM hr.employees e2
        WHERE e2.job_id = e.job_id
    )
ORDER BY e.job_id, e.salary DESC;
-- H16. Departments where (SELECT MAX(hire_date) FROM hr.employees e WHERE e.department_id = d.department_id) >= DATE '2005-01-01'. Hint: At least one hire in dept from 2005 onward.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (
    SELECT MAX(hire_date)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) >= DATE '2005-01-01'
ORDER BY d.department_id;
-- H17. Employees who are managers and have more than 2 direct reports: e.employee_id IN (SELECT manager_id FROM hr.employees WHERE manager_id IS NOT NULL GROUP BY manager_id HAVING COUNT(*) > 2). Hint: Subquery: manager_id with COUNT > 2.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_id
FROM hr.employees e
WHERE  e.employee_id IN (
        SELECT manager_id
        FROM hr.employees
        WHERE manager_id IS NOT NULL
        GROUP BY manager_id
        HAVING COUNT(*) > 2
    )
ORDER BY e.employee_id;
-- H18. Departments d where (SELECT SUM(salary) FROM hr.employees e WHERE e.department_id = d.department_id) = (SELECT MAX(s) FROM (SELECT SUM(salary) s FROM hr.employees GROUP BY department_id)). Hint: Dept total = max of all dept totals.
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (
    SELECT SUM(salary)
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    ) = (
        SELECT MAX(s)
        FROM (
            SELECT SUM(salary) AS s
            FROM hr.employees
            GROUP BY department_id
        )
    )
ORDER BY d.department_id;
-- H19. Employees where (SELECT department_name FROM hr.departments d WHERE d.department_id = e.department_id) IN ('Sales','IT'). Hint: Correlated department_name IN list.
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id
FROM  hr.employees e
WHERE (
    SELECT d.department_name
     FROM hr.departments d
     WHERE d.department_id = e.department_id
    ) IN ('Sales', 'IT')
ORDER BY e.department_id;
-- H20. Departments where (SELECT COUNT() FROM hr.employees e WHERE e.department_id = d.department_id AND e.commission_pct IS NOT NULL) = (SELECT COUNT() FROM hr.employees e WHERE e.department_id = d.department_id) and count > 0. Hint: All employees in dept have commission (and at least one employee).
SELECT 
    d.department_id,
    d.department_name
FROM hr.departments d
WHERE (
    SELECT COUNT(*) 
     FROM hr.employees e
     WHERE e.department_id = d.department_id
       AND e.commission_pct IS NOT NULL
    ) = 
    (SELECT COUNT(*) 
     FROM hr.employees e
     WHERE e.department_id = d.department_id
    )
    AND (SELECT COUNT(*) 
         FROM hr.employees e
         WHERE e.department_id = d.department_id
    ) > 0
ORDER BY d.department_id;
