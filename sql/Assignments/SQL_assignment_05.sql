-- q1.List each employee’s first name, last name, and department name (join hr.employees and hr.departments).
select e.first_name,
       e.last_name,
       d.department_name 
       from hr.employees e inner join hr.DEPARTMENTS d 
       on e.DEPARTMENT_ID=d.department_id;
--q2.List employees who work in the 'Sales' department (use the department name from hr.departments).
select e.first_name,
       e.last_name,
       d.department_name
from hr.employees e inner join hr.DEPARTMENTS d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID       
where d.department_name='Sales';       
-- q3.Count how many employees work in each department and show the department name. (Join and use GROUP BY with COUNT.)
select d.department_id,
       count(e.employee_id) as employee_count
       from hr.employees e
       inner join hr.departments d on e.department_id=d.DEPARTMENT_ID
       group by d.department_id,d.department_name;
--q4.Join hr.employees to hr.departments and also show the employee’s manager_id. Then join again to hr.employees (self-join) to show the manager’s first and last name.
select * from hr.employees;
select * from hr.DEPARTMENTS;

select e.employee_id,
       e.first_name as emp_first_name,
       e.last_name as emp_last_name,
       d.department_name,
       e.manager_id,
       m.first_name as mgr_first_name,
       m.last_name as mgr_last_name
from hr.employees e
join hr.departments d
    on e.department_id=d.DEPARTMENT_ID
LEFT JOIN hr.employees m
    on e.manager_id=m.employee_id;  

--q2.List department_id and department_name for the department named 'IT' (or similar). Use hr.departments only, or join if you want to verify with employee count.
select department_id,
       department_name
from hr.departments where department_name='IT';      
===================================================
-- M1. List employee_id, first_name, last_name, and department_name (join employees and departments).
select e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name
from hr.employees e
inner join hr.departments d
on e.department_id=d.department_id;    
-- M2. Show employees in department 'IT' (filter by d.department_name = 'IT' after join).
select * from hr.departments where department_name='IT';
-- M3. Count employees per department and show department_name.
select d.department_name,
    count(e.employee_id) as employee_count
from hr.departments d
left join hr.employees e
on d.department_id-e.department_id
group by d.department_name
order by employee_count desc;   
-- M4. List first_name, last_name, department_id, department_name for department_id 50.
select e.first_name,
       e.last_name,
       d.department_id,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where d.department_id=50;
-- M5. Show employee_id, salary, and department_name.
select e.employee_id,
       e.salary,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id;  
-- M6. List departments (department_id, department_name) that have at least one employee (use JOIN and DISTINCT or GROUP BY).
--using join,distinct
select distinct d.department_id,
       d.department_name
from hr.departments d
inner join hr.employees e
on d.department_id=e.department_id;       
--using group by
select d.department_id,
       d.department_name
from hr.departments d
inner join hr.employees e
on d.department_id=e.department_id
group by d.department_id,d.department_name;     
-- M7. Show first_name, last_name, department_name for employees with salary > 8000.
select e.first_name,
       e.last_name,
       e.salary,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id     
where salary>8000;  
-- M8. List employee_id, job_id, department_name.
select e.employee_id,
       e.job_id,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id;       
-- M9. Count employees per department_name (one row per department).
select d.department_name,
       count(e.employee_id) as employee_count
from hr.departments d left join hr.employees e
on d.department_id=e.department_id
group by d.department_name
order by d.department_name;       
-- M10. Show employees (name, salary) in department 'Sales'.
select e.employee_id,
       e.salary,
       d.department_name
from hr.departments d inner join hr.employees e
on d.department_id=e.department_id
where d.department_name='Sales';       
-- M11. List department_id, department_name, and total salary (SUM(e.salary)) for that department.
select d.department_id,
       d.department_name,
       sum(e.salary) as total_salary
from hr.departments d LEFT join hr.employees e
on d.department_id=e.department_id
group by d.department_id, d.department_name
order by d.department_id;
-- M12. Show employee_id, hire_date, department_name.
select e.employee_id,
       e.hire_date,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id;       
-- M13. List employees (first_name, last_name) and their department_name, ordered by department_name then last_name.
select e.first_name,
       e.last_name,
       d.department_name
from hr.employees e inner join hr.departments d       
on e.department_id=d.department_id
order by d.department_name,e.last_name;
-- M14. Show department_name and average salary (AVG(e.salary)) for that department.
select d.department_id,
       d.department_name,
       (avg(e.salary)) as avg_salary
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
group by d.department_id,d.department_name; 
-- M15. List employee_id, first_name, department_id, department_name for job_id 'SA_REP'.
select e.employee_id,
       e.first_name,
       d.department_id,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where job_id='SA_REP';       
-- M16. Show departments (department_name) and min salary in that department.
select d.department_name,
       min(e.salary) as min_salary
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
group by d.department_name
order by min_salary;   
-- M17. List first_name, last_name, department_name where department_id is 80 or 90.
select e.first_name,
       e.last_name,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where e.department_id in(80,90);     
-- M18. Show employee_id, salary, department_name for the 5 highest-paid employees (join then ORDER BY salary DESC FETCH FIRST 5).
select e.employee_id,
       e.salary,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
order by e.salary desc
FETCH FIRST 5 ROWS ONLY; 
-- M19. List department_name and number of employees (COUNT) for departments with more than 5 employees.
SELECT D.DEPARTMENT_NAME,
       COUNT(E.EMPLOYEE_ID) AS EMP_COUNT
FROM HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME  
HAVING COUNT(E.EMPLOYEE_ID)>5;    
-- M20. Show first_name, last_name, department_name, hire_date.
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_NAME,
       E.HIRE_DATE
FROM HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS D    
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID;  
==================================================
-- H1. List employee_id, first_name, last_name, department_name, and manager's first_name and last_name (self-join employees to manager, and join to departments).
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME AS EMP_FIRST_NAME,
       E.LAST_NAME AS EMP_LAST_NAME,
       D.DEPARTMENT_NAME,
       M.FIRST_NAME AS MANAGER_FIRST_NAME,
       M.LAST_NAME AS MANAGER_LAST_NAME
FROM HR.EMPLOYEES E LEFT JOIN HR.EMPLOYEES m
ON E.MANAGER_ID=M.MANAGER_ID
LEFT JOIN HR.DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID;    
-- H2. Show department_name and total salary for departments where total salary > 100000.
SELECT D.DEPARTMENT_NAME,
       (SUM(E.SALARY)) AS total_salary
FROM HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.department_name
HAVING SUM(E.SALARY)>100000;    
-- H3. List employees (name, salary, department_name) who earn more than the average salary of their department.
SELECT E.FIRST_NAME,
       E.LAST_NAME,
       E.SALARY,
       D.DEPARTMENT_NAME
FROM HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS d
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.SALARY>(
    SELECT AVG(E2.SALARY)
    FROM HR.EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID=E.DEPARTMENT_ID
);       
-- H4. Show each department_name and the name of the employee with the highest salary in that department (use ROW_NUMBER or MAX(salary) join).
SELECT D.DEPARTMENT_NAME,
       E.FIRST_NAME,
       E.LAST_NAME,
       E.salary
FROM HR.EMPLOYEES E JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.SALARY=(
    SELECT MAX(E2.SALARY)
    FROM HR.EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID=E.DEPARTMENT_ID
);    
-- H5. List department_id, department_name, and count of employees, only for departments in (10, 20, 30, 40).
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       COUNT(E.EMPLOYEE_ID) AS employee_count
FROM HR.DEPARTMENTS d
LEFT JOIN HR.EMPLOYEES E
ON D.DEPARTMENT_ID=E.department_id
WHERE D.DEPARTMENT_ID IN(10,20,30,40)
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME
ORDER BY D.DEPARTMENT_ID;       
-- H6. Show employee first_name, last_name, department_name, and manager's department_name (employee's dept and manager's dept).
SELECT E.FIRST_NAME AS EMP_FIRST_NAME,
       E.LAST_NAME AS EMP_LAST_NAME,
       D1.DEPARTMENT_NAME AS EMPLOYEE_DEPARTMENT,
       D2.DEPARTMENT_NAME AS MANAGER_DEPARTMENT
FROM HR.EMPLOYEES E LEFT JOIN HR.DEPARTMENTS D1
ON E.DEPARTMENT_ID=D1.DEPARTMENT_ID
LEFT JOIN HR.EMPLOYEES M ON E.MANAGER_ID=M.MANAGER_ID
LEFT JOIN HR.DEPARTMENTS DS ON M.DEPARTMENT_ID=D2.DEPARTMENT_ID;       
-- H7. List department_name and average salary, ordered by average salary descending.
select d.department_name,
       e.salary,
       (avg(e.salary)) as avg_salary
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
group by d.department_name,d.department_id,e.salary;      
-- H8. Show employees (name, salary, department_name) whose salary is above the company average.
select e.first_name,
       e.last_name,
       e.salary,
       d.department_name
from hr.employees e inner join hr.departments D
on e.department_id=d.department_id
where e.salary>(
    select avg(salary) from hr.employees
    )
order by e.salary desc;           
-- H9. List departments (department_name) that have at least one employee with commission_pct not null.
select distinct d.department_name,
       e.commission_pct
from hr.employees e inner join hr.departments D
on e.department_id=d.department_id
where e.commission_pct is not null;   
-- H10. Show employee_id, first_name, last_name, department_name, and department's manager_id (from departments).
select e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       d.manager_id as department_manager_id
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id; 
-- H11. List department_name and max salary in that department, only for departments with max salary > 12000.
select d.department_id,
       d.department_name,
       max(e.salary) as max_salary
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
group by d.department_id,d.department_name
having max(e.salary)>12000
order by max_salary desc;       
-- H12. Show first_name, last_name, department_name for employees hired after 2005.
select e.first_name,
       e.last_name,
       d.department_name,
       e.HIRE_DATE
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where e.hire_date>date '2005-12-31'
order by e.hire_date;        
-- H13. List departments (department_name) and count of employees with job_id 'SA_REP' in that department.
select d.department_id,
       d.department_name,
       count(e.employee_id) as emp_count
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where e.job_id='SA_REP'
group by d.department_id,d.department_name;   
-- H14. Show employee name, department_name, and salary rank within that department (RANK() OVER (PARTITION BY department_id ORDER BY salary DESC)).
select e.first_name,
       e.last_name,
       d.department_name,
       e.salary,
       rank() over (
        partition by e.department_id
        order by e.salary desc
       )as salary_rank
from hr.employees e join hr.departments D
on e.department_id=d.department_id
order by d.department_name;       
-- H15. List department_name and total number of employees, including departments with 0 employees (use LEFT JOIN from departments to employees).
select d.department_name,
       count(e.employee_id) as employee_count
from hr.employees e join hr.departments D
on e.department_id=d.department_id
group by d.department_name
order by d.department_name;       
-- H16. Show employees (name, salary, department_name) in departments 50, 60, 70, ordered by department_name then salary desc.
select e.first_name,
       e.last_name,
       e.salary,
       d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
where e.department_id in(50,60,70)
order by d.department_name,e.salary desc;    
-- H17. List department_name and average tenure (years) of employees in that department (MONTHS_BETWEEN/12).
select d.department_name,
       round(avg(MONTHS_BETWEEN(sysdate, e.hire_date)/12),2) as avg_tenure_years
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id   
group by d.department_name
order by d.department_name;   
-- H18. Show employee_id, first_name, last_name, department_name, and number of employees in that department (same count repeated per employee in dept).
select e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       count(*) over (partition by e.department_id) as dept_employee_count
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id  
order by d.department_name;      
-- H19. List departments (department_name) that have more than 2 employees with salary > 5000.
select d.department_name
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id 
where e.salary>5000
group by d.DEPARTMENT_NAME
having count(e.employee_id)>2
order by d.department_name;      
-- H20. Show first_name, last_name, department_name, and salary as percentage of department total (salary * 100.0 / SUM(salary) OVER (PARTITION BY e.department_id)).
select e.first_name,
       e.last_name,
       d.department_name,
       e.salary,
       round(
        e.salary*100/sum(e.salary) over (partition by e.department_id),
        2
       )as salary_percentage
from hr.employees e join hr.DEPARTMENTS d
on e.department_id=d.department_id
order by d.department_id,e.salary desc;
