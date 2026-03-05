-- q1.List departments (department_id) where the average salary is greater than 8000. Use HAVING.
select department_id,
       avg(salary) as avg_salary
from hr.employees 
group by DEPARTMENT_ID
having avg(salary)>8000;    
-- q2.List job_id values that have more than 3 employees.
select job_id,
       count(*) as emp_count
from hr.EMPLOYEES
group by JOB_ID
having count(*)>3;  
-- q3.Show department name and total salary for each department. (Join hr.employees to hr.departments and use GROUP BY with SUM(salary).)
select d.department_name,
       sum(e.salary) as total_salary
from hr.employees e inner join HR.departmentS d
on e.department_id=d.DEPARTMENT_ID
group by d.dePARTMENT_ID,D.DEPARTMENT_NAME;     
-- Q4.List departments (by id or name) where total salary is greater than 200000.
SELECT d.department_id,
       d.department_name,
       SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING SUM(e.salary) > 200000
ORDER BY total_salary DESC;
-- d5.List job_id where the minimum salary in that job is less than 3000.
select job_id,min(salary) as min_salary
from hr.EMPLOYEES
group by JOB_ID
having min(salary)<3000; 
-- q6.Use ROLLUP on department_id in a query that shows COUNT(*) and SUM(salary), and describe the extra rows ROLLUP adds.
SELECT department_id,
COUNT(*) AS num_employees,
SUM(salary) AS total_salary
FROM hr.employees
GROUP BY ROLLUP(department_id)
ORDER BY department_id NULLS LAST;
-- =====================================================
-- M1. List department_id where average salary > 8000 (HAVING AVG(salary) > 8000).
select department_id,avg(salary) as avg_salary
from hr.employees
group by department_id
having avg(salary)>8000;
-- M2. Show job_id that have more than 3 employees.
select job_id,count(*) as emp_count
from hr.employees 
group by JOB_ID
having count(*)>3;
-- M3. List department_name and total salary per department (join and GROUP BY).
select d.department_id,
       d.department_name,
       sum(e.salary) as sum_salary
from hr.employees e inner join hr.departments d
on e.department_id=d.department_id
group by d.department_id,department_name; 
-- M4. List department_id where total salary > 150000.
select department_id,sum(salary) as sum_salary
from hr.employees
group by DEPARTMENT_ID
having sum(salary)>15000;
-- M5. Show job_id where min(salary) < 4000.
select job_id,min(salary) as min_salary
from hr.employees 
group by job_id
having min(salary)<4000;
-- M6. List department_id and count() per department; only departments with more than 5 employees.
SELECT department_id,count(*) as dept_count
from hr.employees 
group by DEPARTMENT_ID
having count(*)>5;
-- M7. Show department_name and average salary per department (join, GROUP BY).
SELECT d.department_name,
       AVG(e.salary) AS avg_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;
-- M8. List job_id and total salary for jobs with more than 2 employees.
select job_id,sum(salary) as total_salary
from hr.EMPLOYEES
group by JOB_ID
having count(*)>2;
-- M9. Show department_id where max(salary) > 12000.
select department_id,max(salary) as max_salary
from hr.employees 
group by DEPARTMENT_ID
having max(salary)>12000;
-- M10. List department_name and employee count; only departments with at least 3 employees.
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 3
ORDER BY employee_count DESC;
-- M11. Show job_id and avg(salary) for jobs with total salary > 50000.
SELECT JOB_ID,SUM(SALARY) AS SUM_SALARY 
FROM HR.EMPLOYEES
GROUP BY JOB_ID
HAVING SUM(SALARY)>50000;
-- M12. List department_id where average salary is between 6000 and 10000.
SELECT DEPARTMENT_ID,AVG(SALARY) AS avg_salary
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) BETWEEN 6000 AND 10000;
-- M13. Show department_name and min(salary), max(salary) per department (join).
SELECT d.department_name,
       MIN(e.salary) AS min_salary,
       MAX(e.salary) AS max_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;
-- M14. List job_id that have exactly 2 employees.
SELECT JOB_ID,COUNT(*) AS emp_count
FROM HR.EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*)=2;
-- M15. Show department_id and sum(salary); only departments with avg(salary) < 7000.
SELECT DEPARTMENT_ID,SUM(SALARY) AS total_salary
FROM HR.EMPLOYEES 
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)<7000;
-- M16. List department_name and total salary; only departments with more than 10 employees.
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 10
ORDER BY total_salary DESC;
-- M17. Show job_id and count(*) for job_id starting with 'SA'.
SELECT JOB_ID,COUNT(*) AS emp_count
FROM HR.EMPLOYEES
WHERE JOB_ID LIKE 'SA%'
GROUP BY JOB_ID;
-- M18. List department_id where min(hire_date) is after 2005-01-01.
SELECT DEPARTMENT_ID,MIN(hire_date) AS MIN_DATE
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MIN(HIRE_DATE)>DATE '2005-01-01';
-- M19. Show department_name and employee count; only departments with total salary > 200000.
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 200000
ORDER BY employee_count DESC;
-- M20. List job_id and avg(salary) for jobs with at least 1 employee; order by avg(salary) desc.
SELECT JOB_ID,COUNT(*) AS EMP_COUNT, AVG(SALARY) AS AVG_SALARY
FROM HR.EMPLOYEES
GROUP BY JOB_ID 
HAVING COUNT(*)>=1
ORDER BY AVG(SALARY) DESC;
-- ===================================================
-- H1. Show department_id, job_id, count(*), sum(salary) with ROLLUP(department_id, job_id).
SELECT DEPARTMENT_ID,JOB_ID,COUNT(*) AS EMP_COUNT,SUM(SALARY)
FROM HR.EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID,JOB_ID);
-- H2. List department_name and total salary; only departments where average salary > 8000 and count > 3.
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 8000
   AND COUNT(e.employee_id) > 3
ORDER BY total_salary DESC;
-- H3. Show job_id and count of employees; only for department_id 50, 60, 80.
SELECT JOB_ID,COUNT(*) AS EMP_COUNT
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN(50,60,80)
GROUP BY JOB_ID;
-- H4. List department_id where total salary is in the top 3 (use subquery: HAVING SUM(salary) IN (SELECT ... ORDER BY SUM(salary) DESC FETCH FIRST 3 ROWS ONLY)).
SELECT department_id
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) IN (
    SELECT total_salary
    FROM (
        SELECT SUM(salary) AS total_salary
        FROM hr.employees
        GROUP BY department_id
        ORDER BY SUM(salary) DESC
        FETCH FIRST 3 ROWS ONLY
    )
)
ORDER BY department_id;
-- h5. Show job_id where min(salary) < 4000.
SELECT JOB_ID,MIN(SALARY) AS MIN_SALARY
FROM HR.EMPLOYEES 
GROUP BY JOB_ID HAVING MIN(SALARY)<4000;
-- h6. List department_id and count() per department; only departments with more than 5 employees.
SELECT DEPARTMENT_ID,COUNT(*) AS emp_count
FROM HR.EMPLOYEES
group BY DEPARTMENT_ID HAVING COUNT(*)>5;
-- H7. Show department_name and average salary per department (join, GROUP BY).
SELECT d.department_name,
       AG(e.salary) AS avg_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;
-- H8. List department_name and number of employees with salary > 5000 in that department (use SUM(CASE WHEN e.salary > 5000 THEN 1 ELSE 0 END)).
SELECT d.department_name,
       SUM(CASE 
               WHEN e.salary > 5000 THEN 1 
               ELSE 0 
           END) AS high_salary_count
FROM hr.departments d
LEFT JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;
-- H9. Show job_id and total salary for jobs that have at least 2 employees and total salary > 20000.
SELECT JOB_ID,SUM(SALARY) AS total_salary
FROM HR.EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*)>=2 AND SUM(SALARY)>20000;
-- H10. List department_id where the department has both at least 3 employees and average salary < 9000.
SELECT DEPARTMENT_ID,AVG(SALARY) AS avg_salary
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID 
HAVING COUNT(*)>=3 AND AVG(SALARY)<9000;
-- H11. Show department_name and avg(salary) rounded to 2 decimals; only departments with total salary > 100000.
SELECT d.department_name,
       ROUND(AVG(e.salary), 2) AS avg_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 100000
ORDER BY avg_salary DESC;
-- H12. List job_id and count() and sum(salary); only job_ids that have more than 1 employee and sum(salary) > 30000.
SELECT JOB_ID,COUNT(*) AS EMP_COUNT,SUM(SALARY) AS SUM_OF_SALARY
FROM HR.EMPLOYEES
GROUP BY JOB_ID 
HAVING COUNT(*)>1 AND SUM(SALARY)>3000;
-- H13. Show department_id, job_id, count(*) with GROUPING SETS ((department_id), (job_id)) to get two grouping levels.
SELECT department_id,
       job_id,
       COUNT(*) AS employee_count
FROM hr.employees
GROUP BY GROUPING SETS (
    (department_id),
    (job_id)
)
ORDER BY department_id, job_id;
-- H14. List department_name and total salary; exclude departments with only 1 employee.
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 1
ORDER BY total_salary DESC;
-- H15. Show department_id where min(salary) > 3000 and max(salary) < 15000.
SELECT DEPARTMENT_ID,MIN(SALARY) AS MIN_SALARY,MAX(SALARY) AS MAX_SALARY
FROM HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MIN(SALARY)>3000 AND MAX(SALARY)<15000;
-- H16. List job_id and average salary; only for employees hired after 2000.
SELECT JOB_ID,AVG(SALARY) AS AVG_SALARY
FROM HR.EMPLOYEES
WHERE HIRE_DATE>DATE'2000-12-31'
GROUP BY JOB_ID;
-- H17. Show department_name, count(), sum(salary), and avg(salary) per department; only departments with count between 2 and 10.
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       SUM(e.salary) AS total_salary,
       AVG(e.salary) AS avg_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) BETWEEN 2 AND 10
ORDER BY employee_count;
-- H18. List department_id that has the highest average salary (subquery: HAVING AVG(salary) >= ALL (SELECT AVG(salary) FROM hr.employees GROUP BY department_id)).
SELECT department_id
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) >= ALL (
    SELECT AVG(salary)
    FROM hr.employees
    GROUP BY department_id
)
ORDER BY department_id;
-- H19. Show department_id, job_id, count(*) with CUBE(department_id, job_id).
SELECT department_id,
       job_id,
       COUNT(*) AS employee_count
FROM hr.employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;
-- H20. List department_name and total salary; only departments where at least one employee has job_id 'SA_REP'.
SELECT d.department_name,
       SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e
  ON d.department_id = e.department_id
WHERE d.department_id IN (
    SELECT department_id
    FROM hr.employees
    WHERE job_id = 'SA_REP'
)
GROUP BY d.department_name
ORDER BY total_salary DESC;
