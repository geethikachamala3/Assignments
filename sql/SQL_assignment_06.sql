-- q1.List all departments and the count of employees in each. Include departments that have zero employees.
select d.department_id,
       d.department_name,
       count(e.employee_id) as employee_count
from hr.departments d left join hr.employees e 
on e.department_id=d.DEPARTMENT_ID
group by d.department_id,d.DEPARTMENT_NAME; 
-- q2.For each employee, show the employee’s first and last name and the manager’s first and last name (self-join on manager_id).
select e.first_name as emp_first_name,
       e.last_name as emp_last_name,
       m.first_name as mgr_first_name,
       m.last_name as mgr_last_name
from hr.employees e left join hr.employees m 
on  e.manager_id=m.employee_id;    
-- q3.List employees who have no department (department_id is NULL in hr.employees). Use a left join to departments and filter where department is missing.
select e.employee_id,
       e.first_name,
       e.last_name,
       e.DEPARTMENT_ID
from hr.employees e left join hr.departments d
on e.department_id=d.department_id
where d.department_id is NULL;       
-- q1.Using a self-join, show two levels of hierarchy: employee → manager → manager’s manager (if exists).
select e.employee_id,
       e.first_name as employee_first_name,
       e.last_name as employee_last_name,
       m.employee_id as manager_id,
       m.first_name as manager_first_name,
       m.last_name as manager_last_name,
       mm.employee_id as manager_manager_id,
       mm.first_name as manager_manager_first_name,
       mm.last_name as manager_manager_last_name
from hr.employees e left join hr.employees m 
on e.manager_id=m.employee_id
left join hr.employees mm 
on e.manager_id=m.employee_id
order by e.employee_id;
-- q2.List departments that have no employees (use RIGHT JOIN or a subquery / NOT EXISTS from departments).
select d.department_id,
       d.DEPARTMENT_NAME
from hr.departments d left join hr.employees e
on d.department_id=e.department_id
where e.employee_id is null
order by d.department_id;       
-- =============================================
-- M1. List all employees (employee_id, first_name, last_name) and department_name; include employees with no department (LEFT JOIN).
select e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name
from hr.employees e left join hr.departments d
on e.department_id=d.department_id;   
-- M2. For each employee show first_name, last_name, and manager's first_name and last_name (self-join).
select e.first_name as employee_first_name,
       e.last_name as employee_last_name,
       m.first_name as manager_first_name,
       m.last_name as manager_last_name
from hr.employees e left join hr.EMPLOYEES m
on e.manager_id=m.employee_id;     
-- M3. List all departments (department_id, department_name) and count of employees; include departments with 0 employees.
select d.department_id,
       d.department_name,
       count(e.employee_id) as employee_count
from hr.departments d left join hr.employees e  
on d.department_id=e.DEPARTMENT_ID
group by d.DEPARTMENT_ID,d.department_name;      
-- M4. Show employees who have no department (LEFT JOIN to departments, WHERE d.department_id IS NULL).
select e.employee_id,
       e.first_name,
       e.last_name
from hr.employees e left join hr.departments d
on e.department_id=d.DEPARTMENT_ID
where d.department_id IS NULL
order by e.employee_id;       
-- M5. List employee first_name, last_name, and department_name; use COALESCE(d.department_name, 'No Dept').
select e.first_name,
       e.last_name,
       d.department_name,
       COALESCE(department_name, 'NO Dept')
from hr.employees e left join hr.departments d
on e.department_id=d.DEPARTMENT_ID;   
-- M6. Show all departments and total salary in each (include departments with 0 salary).
select d.department_id,
       d.department_name,
       nvl(sum(e.salary),0) as total_salary
from hr.DEPARTMENTS d left join hr.employees e
on d.department_id=e.DEPARTMENT_ID
group by d.department_id,d.department_name
order by d.department_id;
select * from hr.EMPLOYEES;
select * from hr.departments;
-- M7. For each employee show name and manager name; use LEFT JOIN so employees without manager appear.
select e.first_name as emp_first_name,
       e.last_name as emp_last_name,
       m.first_name as manager_first_name,
       m.last_name as manager_last_name
from hr.employees e left join hr.employees m   
on e.manager_id=m.employee_id
order by e.employee_id;    
-- M8. List departments (department_name) that have no employees (RIGHT JOIN from employees to departments then WHERE e.employee_id IS NULL, or NOT EXISTS).
select d.department_name
from hr.employees e right join hr.departments d
on e.department_id=d.DEPARTMENT_ID
where e.employee_id is null;
-- M9. Show employee_id, first_name, department_id, department_name; include employees with null department_id.
select e.employee_id,
       e.first_name,
       d.department_id,
       d.department_name
from hr.employees e left join hr.departments d
on e.department_id=d.DEPARTMENT_ID 
order by e.employee_id;    
-- M10. List all departments and the number of employees; show 0 for departments with no employees.
select d.department_id,
       count(e.employee_id)
from hr.employees e left join hr.departments d
on e.department_id=d.DEPARTMENT_ID 
group by d.department_id,d.DEPARTMENT_NAME      
order by d.department_id;
-- M11. Show employee name and manager name; alias manager columns as mgr_first_name, mgr_last_name.
SELECT e.first_name,
       e.last_name,
       m.first_name AS mgr_first_name,
       m.last_name  AS mgr_last_name
FROM hr.employees e
LEFT JOIN hr.employees m
ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- M12. List employees (first_name, last_name) and department_name; include employees whose department_id is not in hr.departments (LEFT JOIN, they get NULL).
select e.first_name,
       e.last_name,
       d.department_name
from hr.employees e left join hr.departments d  
on e.department_id=d.department_id
order by e.first_name;     
-- M13. Show department_id, department_name, and employee count; include departments with 0 employees.
select d.department_id,
       d.department_name,
       count(e.employee_id) as emp_count
from hr.departments d left join hr.employees e
on d.department_id=e.DEPARTMENT_ID       
group by d.department_id,d.department_name;
-- M14. For each employee show employee_id, salary, department_name; use NVL(d.department_name, 'Unassigned').
select e.employee_id,
       e.salary,
       d.department_name,
       nvl(d.department_name, 'Unassigned')
from hr.departments d left join hr.employees e
on d.department_id=e.DEPARTMENT_ID;
-- M15. List employees with their manager's employee_id and manager's last_name (self-join).
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       m.employee_id AS manager_employee_id,
       m.last_name   AS manager_last_name
FROM hr.employees e
LEFT JOIN hr.employees m
ON e.manager_id = m.employee_id
ORDER BY e.employee_id; 
-- M16. Show all departments (department_name) and min salary in that department (NULL for no employees).
select d.department_name,
       min(e.salary) as min_salary
from hr.departments d left join hr.employees e
on d.department_id=e.DEPARTMENT_ID
group by d.DEPARTMENT_NAME;    
-- M17. List employees who have a manager (manager_id IS NOT NULL) and show manager's first_name.
SELECT e.employee_id,
       e.first_name AS employee_first_name,
       e.last_name  AS employee_last_name,
       m.first_name AS manager_first_name
FROM hr.employees e
JOIN hr.employees m
ON e.manager_id = m.employee_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id;
-- M18. Show employee_id, first_name, department_name; include employees with no department (LEFT JOIN).
select e.employee_id,
       e.first_name,
       e.last_name,
       d.DEPARTMENT_NAME
from hr.employees e left join hr.departments d
on e.department_id=d.department_id;  
-- M19. List departments (department_id, department_name) and average salary; include departments with no employees (avg NULL or 0).
select d.department_id,
       d.department_name,
       avg(e.salary) as avg_salary
from hr.employees e left join hr.departments d
on e.department_id=d.department_id
group by d.department_id,d.DEPARTMENT_NAME;    
-- M20. For each employee show name and department_name; if no department show 'N/A'.
select e.first_name,
       e.last_name,
       coalesce(d.department_name, 'N/A') as department_name
from hr.employees e left join hr.departments d
on e.department_id=d.department_id;     
-- ====================================================== 
-- H1. Show two-level hierarchy: employee name, manager name, and manager's manager name (self-join e to m, m to m2 on m.manager_id = m2.employee_id).
SELECT e.employee_id,
       e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       m.employee_id AS manager_id,
       m.first_name  AS manager_first_name,
       m.last_name   AS manager_last_name,
       m2.employee_id AS mgr_mgr_id,
       m2.first_name  AS mgr_mgr_first_name,
       m2.last_name   AS mgr_mgr_last_name
FROM hr.employees e
LEFT JOIN hr.employees m
       ON e.manager_id = m.employee_id
LEFT JOIN hr.employees m2
       ON m.manager_id = m2.employee_id
ORDER BY e.employee_id;
-- H2. List departments that have no employees using NOT EXISTS.
select * from hr.departments d where not exists(
    select 1 from hr.employees e where e.DEPARTMENT_ID=d.department_id
);
-- H3. Show all employees and all departments in one result (FULL OUTER JOIN): employee_id, first_name, department_id, department_name.
select e.employee_id,
       e.first_name,
       e.department_id,
       d.department_name
from hr.employees e full outer join hr.departments d  
on e.department_id=d.department_id;     
-- H4. For each employee show name, department_name, and manager's department_name (join e to d, e to m, m to dm).
SELECT e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       d.department_name  AS employee_department,
       dm.department_name AS manager_department
FROM hr.employees e
LEFT JOIN hr.departments d
       ON e.department_id = d.department_id
LEFT JOIN hr.employees m
       ON e.manager_id = m.employee_id
LEFT JOIN hr.departments dm
       ON m.department_id = dm.department_id
ORDER BY e.employee_id;
-- H5. List employees (name, salary, department_name) who earn more than their manager (self-join, compare e.salary > m.salary).
SELECT e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       e.salary,
       d.department_name
FROM hr.employees e
JOIN hr.employees m
  ON e.manager_id = m.employee_id
JOIN hr.departments d
  ON e.department_id = d.department_id
WHERE e.salary > m.salary
ORDER BY e.salary DESC;
-- H6. Show all departments and count of employees; also show count of employees with commission_pct not null per department (use conditional COUNT).
select d.department_id,
       d.department_name,
       count(e.employee_id) as emp_count,
       count(case 
                when e.commission_pct is not null then 1
            end) as emp_with_commission
FROM hr.departments d
LEFT JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;          
-- H7. List employees who have the same manager as employee_id 104 (self-join or subquery: manager_id = (SELECT manager_id FROM hr.employees WHERE employee_id = 104)).
select e.employee_id,
       e.first_name,
       e.last_name,
       e.manager_id
from hr.employees e 
WHERE e.manager_id=(
    select manager_id from hr.employees where employee_id=104
)order by e.employee_id;
-- H8. Show employee name, department_name, and manager name; include employees with no department and no manager.
SELECT e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       NVL(d.department_name, 'N/A') AS department_name,
       NVL(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM hr.employees e
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
LEFT JOIN hr.employees m
  ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- H9. List departments (department_name) where the department's manager (d.manager_id) is not in hr.employees or has no row (LEFT JOIN employees to d.manager_id).
SELECT d.department_id,
       d.department_name,
       d.manager_id
FROM hr.departments d
LEFT JOIN hr.employees m
  ON d.manager_id = m.employee_id
WHERE m.employee_id IS NULL;
-- H10. Show employee_id, first_name, last_name, department_name, and manager's last_name; use LEFT JOINs so employees without department or manager appear.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       NVL(d.department_name, 'N/A') AS department_name,
       NVL(m.last_name, 'No Manager') AS manager_last_name
FROM hr.employees e
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
LEFT JOIN hr.employees m
  ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- H11. List employees (name, salary) whose salary is greater than their manager's salary (self-join e, m).
SELECT e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       e.salary,
       m.first_name  AS manager_first_name,
       m.last_name   AS manager_last_name,
       m.salary      AS manager_salary
FROM hr.employees e
JOIN hr.employees m
  ON e.manager_id = m.employee_id
WHERE e.salary > m.salary
ORDER BY e.salary DESC;
-- H12. Show all departments and total salary; include departments with 0 employees (total 0 or NULL).
SELECT d.department_id,
       d.department_name,
       NVL(SUM(e.salary), 0) AS total_salary
FROM hr.departments d
LEFT JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
-- H13. For each employee show name, department_name, and number of employees in that department (join to aggregated subquery or use COUNT() OVER (PARTITION BY e.department_id)).
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       COUNT(*) OVER (PARTITION BY e.department_id) AS dept_employee_count
FROM hr.employees e
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
ORDER BY d.department_name, e.employee_id;
-- H14. List employees who are managers (employee_id in (SELECT manager_id FROM hr.employees)) and show how many people they manage.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       COUNT(sub.employee_id) AS num_of_subordinates
FROM hr.employees e
JOIN hr.employees sub
  ON e.employee_id = sub.manager_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY num_of_subordinates DESC, e.employee_id;
-- H15. Show employee name, department_name, manager name; include employees with no department (department_name NULL) and no manager (manager name NULL).
SELECT e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       d.department_name,
       m.first_name || ' ' || m.last_name AS manager_name
FROM hr.employees e
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
LEFT JOIN hr.employees m
  ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- H16. List departments (department_name) that have at least one employee with salary > 10000 (JOIN and EXISTS or IN).
SELECT DISTINCT d.department_name
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
WHERE e.salary > 10000
ORDER BY d.department_name;
-- H17. Show employee_id, first_name, last_name, department_name, and manager's first_name; use COALESCE for manager first_name to 'No Manager'.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       COALESCE(m.first_name, 'No Manager') AS manager_first_name
FROM hr.employees e
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
LEFT JOIN hr.employees m
  ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- H18. List all employees (employee_id, first_name) and all departments (department_id, department_name) in one result with FULL OUTER JOIN; show which side each row came from (e.g. CASE WHEN e.employee_id IS NOT NULL THEN 'Emp' ELSE 'Dept' END).
SELECT e.employee_id,
       e.first_name,
       d.department_id,
       d.department_name,
       CASE 
           WHEN e.employee_id IS NOT NULL AND d.department_id IS NOT NULL THEN 'Both'
           WHEN e.employee_id IS NOT NULL THEN 'Emp'
           ELSE 'Dept'
       END AS row_source
FROM hr.employees e
FULL OUTER JOIN hr.departments d
  ON e.department_id = d.department_id
ORDER BY e.employee_id, d.department_id;
H19. For each department show department_name and the name of the employee with the highest salary in that department (join to (SELECT department_id, employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) rn FROM hr.employees) WHERE rn = 1).
SELECT d.department_name,
       e.first_name AS employee_first_name,
       e.last_name  AS employee_last_name,
       e.salary
FROM hr.departments d
LEFT JOIN (
    SELECT employee_id,
           department_id,
           first_name,
           last_name,
           salary,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM hr.employees
) e
ON d.department_id = e.department_id AND e.rn = 1
ORDER BY d.department_name;
-- H20. List employees (name, department_name) who were hired before their manager (compare e.hire_date < m.hire_date with self-join).
SELECT e.employee_id,
       e.first_name  AS employee_first_name,
       e.last_name   AS employee_last_name,
       d.department_name,
       m.first_name  AS manager_first_name,
       m.last_name   AS manager_last_name,
       e.hire_date,
       m.hire_date   AS manager_hire_date
FROM hr.employees e
JOIN hr.employees m
  ON e.manager_id = m.employee_id
LEFT JOIN hr.departments d
  ON e.department_id = d.department_id
WHERE e.hire_date < m.hire_date
ORDER BY e.hire_date;