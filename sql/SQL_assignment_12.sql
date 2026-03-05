-- q1.Rank employees by salary within each department. Show employee_id, first_name, department_id, salary, and rank. Use RANK() with PARTITION BY department_id ORDER BY salary DESC.
SELECT employee_id, 
       first_name, 
       department_id, 
       salary,
  RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM hr.employees;
-- q2.Get the top earner per department (one row per department). Use ROW_NUMBER() in a subquery/CTE, then filter WHERE rn = 1.
SELECT employee_id, 
       first_name, 
       department_id, 
       salary
FROM (
  SELECT employee_id, first_name, department_id, salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
  FROM hr.employees
) sub
WHERE rn = 1;
-- q3.Assign DENSE_RANK by hire_date within each job_id. Show job_id, employee_id, hire_date, and dense_rank. Oldest hire in the job gets 1.
SELECT job_id, 
       employee_id, 
       hire_date,
  DENSE_RANK() OVER (PARTITION BY job_id ORDER BY hire_date) AS hire_rank
FROM hr.employees;
-- M1. ROW_NUMBER() OVER (ORDER BY salary DESC) for each employee. Hint: Add ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn.
SELECT employee_id,
       first_name,
       last_name,
       salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
FROM hr.employees
ORDER BY rn;
-- M2. RANK() OVER (PARTITION BY department_id ORDER BY salary DESC). Hint: Rank by salary within department.
SELECT employee_id,
       first_name,
       last_name,
       department_id,
       salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM hr.employees
ORDER BY department_id, dept_rank;
-- M3. DENSE_RANK() OVER (ORDER BY hire_date) for tenure order. Hint: DENSE_RANK() OVER (ORDER BY hire_date).
SELECT employee_id,
       first_name,
       last_name,
       hire_date,
       DENSE_RANK() OVER (ORDER BY hire_date) AS tenure_rank
FROM hr.employees
ORDER BY tenure_rank;
-- M4. NTILE(4) OVER (ORDER BY salary) for salary quartiles. Hint: NTILE(4) OVER (ORDER BY salary) AS quartile.
SELECT employee_id,
       first_name,
       last_name,
       salary,
       NTILE(4) OVER (ORDER BY salary) AS quartile
FROM hr.employees
ORDER BY quartile, salary;
-- M5. Top 1 per department by salary: use ROW_NUMBER() in subquery, then WHERE rn = 1. Hint: Subquery with ROW_NUMBER() PARTITION BY department_id ORDER BY salary DESC; outer WHERE rn = 1.
SELECT * FROM (SELECT employee_id,
                      first_name,
                      last_name,
                      department_id,
                      salary,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM hr.employees
) sub
WHERE rn = 1
ORDER BY department_id;
-- M6. RANK() OVER (ORDER BY salary DESC NULLS LAST). Hint: NULLS LAST in ORDER BY.
SELECT employee_id,
       first_name,
       last_name,
       salary,
       RANK() OVER (ORDER BY salary DESC NULLS LAST) AS salary_rank
FROM hr.employees
ORDER BY salary_rank;
-- M7. ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY hire_date). Hint: Row number by hire date within job.
SELECT employee_id,
       first_name,
       last_name,
       job_id,
       hire_date,
       ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY hire_date) AS hire_rn
FROM hr.employees
ORDER BY job_id, hire_rn;
-- M8. DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary). Hint: Dense rank by salary within dept.
SELECT employee_id,
       first_name,
       last_name,
       department_id,
       salary,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary) AS dept_salary_rank
FROM hr.employees
ORDER BY department_id, dept_salary_rank;
-- M9. NTILE(5) OVER (ORDER BY salary) for quintiles. Hint: NTILE(5).
SELECT employee_id,
       first_name,
       last_name,
       salary,
       NTILE(5) OVER (ORDER BY salary) AS quintile
FROM hr.employees
ORDER BY quintile, salary;
-- M10. RANK() OVER (PARTITION BY department_id ORDER BY hire_date DESC) (newest first = 1). Hint: Rank by hire_date DESC per dept.
SELECT employee_id,
       first_name,
       last_name,
       department_id,
       hire_date,
       RANK() OVER (PARTITION BY department_id ORDER BY hire_date DESC) AS newest_rank
FROM hr.employees
ORDER BY department_id, newest_rank;
-- M11. Show employee_id, salary, and ROW_NUMBER() OVER (ORDER BY employee_id). Hint: Simple row number by employee_id.
SELECT employee_id,
       salary,
       ROW_NUMBER() OVER (ORDER BY employee_id) AS rn
FROM hr.employees
ORDER BY rn;
-- M12. DENSE_RANK() OVER (ORDER BY commission_pct DESC NULLS LAST). Hint: Rank commission; NULLS LAST.
SELECT employee_id,
       commission_pct,
       DENSE_RANK() OVER (ORDER BY commission_pct DESC NULLS LAST) AS commission_rank
FROM hr.employees
ORDER BY commission_rank;
-- M13. ROW_NUMBER() OVER (PARTITION BY department_id, job_id ORDER BY salary DESC). Hint: Partition by dept and job.
SELECT employee_id,
       department_id,
       job_id,
       salary,
       ROW_NUMBER() OVER (PARTITION BY department_id, job_id ORDER BY salary DESC) AS rn
FROM hr.employees
ORDER BY department_id, job_id, rn;
-- M14. NTILE(10) OVER (ORDER BY salary) for deciles. Hint: NTILE(10).
SELECT employee_id,
       salary,
       NTILE(10) OVER (ORDER BY salary) AS decile
FROM hr.employees
ORDER BY decile, salary;
-- M15. RANK() OVER (ORDER BY salary) for ascending rank (lowest salary = 1). Hint: ORDER BY salary ASC.
SELECT employee_id,
       salary,
       RANK() OVER (ORDER BY salary ASC) AS salary_rank
FROM hr.employees
ORDER BY salary_rank;
-- M16. Top 3 per job_id by salary: ROW_NUMBER() PARTITION BY job_id ORDER BY salary DESC, then filter rn <= 3. Hint: Subquery with rn; WHERE rn <= 3.
SELECT *FROM (
    SELECT employee_id,
        job_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY salary DESC) AS rn
    FROM hr.employees
) sub
WHERE rn <= 3
ORDER BY job_id, rn;
-- M17. DENSE_RANK() OVER (PARTITION BY job_id ORDER BY hire_date). Hint: Dense rank by hire date per job.
SELECT employee_id,
       job_id,
       hire_date,
       DENSE_RANK() OVER (PARTITION BY job_id ORDER BY hire_date) AS hire_rank
FROM hr.employees
ORDER BY job_id, hire_rank;
-- M18. RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) and filter rank = 1 (highest per dept). Hint: In subquery; WHERE rank = 1.
SELECT * FROM (
    SELECT employee_id,
        department_id,
        salary,
        RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
    FROM hr.employees
) sub
WHERE dept_rank = 1
ORDER BY department_id;
-- M19. NTILE(3) OVER (PARTITION BY department_id ORDER BY salary). Hint: Tertiles within each department.
SELECT employee_id,
       department_id,
       salary,
       NTILE(3) OVER (PARTITION BY department_id ORDER BY salary) AS tertile
FROM hr.employees
ORDER BY department_id, tertile;
-- M20. ROW_NUMBER() OVER (PARTITION BY manager_id ORDER BY salary DESC) (rank among direct reports). Hint: Partition by manager_id.
SELECT employee_id,
       manager_id,
       salary,
       ROW_NUMBER() OVER (PARTITION BY manager_id ORDER BY salary DESC) AS report_rank
FROM hr.employees
ORDER BY manager_id, report_rank;
-- ==============================================================
-- H1. Top 2 earners per department: ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC), filter rn <= 2. Hint: Subquery, WHERE rn <= 2.
SELECT * FROM (
    SELECT employee_id,
           department_id,
           salary,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM hr.employees
) sub
WHERE rn <= 2
ORDER BY department_id, rn;
-- H2. Rank employees by salary within department; show only those with rank <= 3 (top 3 per dept). Hint: RANK() or ROW_NUMBER(); filter rank/rn <= 3.
SELECT * FROM (
    SELECT employee_id,
           department_id,
           salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
    FROM hr.employees
) sub
WHERE dept_rank <= 3
ORDER BY department_id, dept_rank;
-- H3. DENSE_RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) and also show job_id and count of people in that job (use COUNT() OVER (PARTITION BY job_id)). Hint: Two window functions: DENSE_RANK and COUNT() OVER (PARTITION BY job_id).
SELECT employee_id,
       job_id,
       salary,
       DENSE_RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) AS salary_rank,
       COUNT(*) OVER (PARTITION BY job_id) AS job_count
FROM hr.employees
ORDER BY job_id, salary_rank;
-- H4. NTILE(4) OVER (ORDER BY salary) and then group by quartile to show min(salary), max(salary) per quartile. Hint: Subquery with NTILE; outer query GROUP BY quartile.
SELECT quartile, MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM (
    SELECT employee_id,
           salary,
           NTILE(4) OVER (ORDER BY salary) AS quartile
    FROM hr.employees
) sub
GROUP BY quartile
ORDER BY quartile;
-- H5. ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) to get "first hired" per department (rn=1). Hint: ORDER BY hire_date; WHERE rn = 1.
SELECT *FROM (
    SELECT employee_id,
           department_id,
           hire_date,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) AS rn
    FROM hr.employees
) sub
WHERE rn = 1
ORDER BY department_id;
-- H6. Rank by salary within department; show only employees with rank 1 or 2 (two highest per dept). Hint: RANK() or DENSE_RANK(); WHERE rank IN (1,2).
SELECT * FROM (
    SELECT employee_id,
           department_id,
           salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
    FROM hr.employees
) sub
WHERE dept_rank IN (1,2)
ORDER BY department_id, dept_rank;
-- H7. RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) and RANK() OVER (PARTITION BY job_id ORDER BY hire_date). Hint: Two different RANK() in same SELECT.
SELECT  employee_id,
        job_id,
        salary,
        hire_date,
        RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) AS salary_rank,
        RANK() OVER (PARTITION BY job_id ORDER BY hire_date) AS hire_rank
FROM hr.employees
ORDER BY job_id, salary_rank;
-- H8. NTILE(4) OVER (PARTITION BY department_id ORDER BY salary) (quartiles within dept). Hint: NTILE(4) with PARTITION BY department_id.
SELECT employee_id,
       department_id,
       salary,
       NTILE(4) OVER (PARTITION BY department_id ORDER BY salary) AS dept_quartile
FROM hr.employees
ORDER BY department_id, dept_quartile;
-- H9. DENSE_RANK() OVER (ORDER BY salary DESC) and filter where dense_rank = 5 (5th highest salary). Hint: Subquery; WHERE dense_rank = 5.
SELECT * FROM (
    SELECT employee_id,
           salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
    FROM hr.employees
) sub
WHERE dense_rank = 5
ORDER BY salary DESC;
-- H10. ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC, employee_id) to break ties. Hint: Add employee_id to ORDER BY for deterministic order.
SELECT * FROM (
    SELECT employee_id,
           department_id,
           salary,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC, employee_id) AS rn
    FROM hr.employees
) sub
WHERE rn = 1
ORDER BY department_id;
-- H11. Top 1 employee per department by tenure (earliest hire): ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date), rn=1. Hint: ORDER BY hire_date ASC; rn=1.
SELECT * FROM (
    SELECT 
        employee_id,
        department_id,
        hire_date,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date ASC) AS rn
    FROM hr.employees
) sub
WHERE rn = 1
ORDER BY department_id;
-- H12. RANK() OVER (PARTITION BY job_id ORDER BY salary) and show only rank 1 (lowest salary per job). Hint: Subquery; WHERE rank = 1.
SELECT * FROM (
    SELECT employee_id,
           job_id,
           salary,
           RANK() OVER (PARTITION BY job_id ORDER BY salary ASC) AS job_rank
    FROM hr.employees
) sub
WHERE job_rank = 1
ORDER BY job_id;
-- H13. NTILE(2) OVER (PARTITION BY department_id ORDER BY salary) (median split per dept). Hint: NTILE(2) per department_id.
SELECT employee_id,
       department_id,
       salary,
       NTILE(2) OVER (PARTITION BY department_id ORDER BY salary) AS median_split
FROM hr.employees
ORDER BY department_id, median_split;
-- H14. DENSE_RANK() OVER (PARTITION BY department_id ORDER BY hire_date DESC) and filter rank = 1 (most recently hired per dept). Hint: ORDER BY hire_date DESC; rank=1.
SELECT * FROM (
    SELECT employee_id,
           department_id,
           hire_date,
           DENSE_RANK() OVER (PARTITION BY department_id ORDER BY hire_date DESC) AS recent_rank
    FROM hr.employees
) sub
WHERE recent_rank = 1
ORDER BY department_id;
-- H15. ROW_NUMBER() OVER (ORDER BY salary DESC) and filter row number between 5 and 10 (5th to 10th highest salary). Hint: WHERE rn BETWEEN 5 AND 10.
SELECT * FROM (
    SELECT employee_id,
           salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM hr.employees
) sub
WHERE rn BETWEEN 5 AND 10
ORDER BY rn;
-- H16. Rank employees by salary within department; show department_id, employee_id, salary, rank; include only departments with at least 3 employees. Hint: Use subquery with RANK(); outer WHERE department_id IN (SELECT department_id FROM hr.employees GROUP BY department_id HAVING COUNT() >= 3) or use COUNT() OVER.
SELECT * FROM (
    SELECT employee_id,
           department_id,
           salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank,
          COUNT(*) OVER (PARTITION BY department_id) AS dept_count
    FROM hr.employees
) sub
WHERE dept_count >= 3
ORDER BY department_id, dept_rank;
-- H17. NTILE(4) OVER (ORDER BY salary) and ROUND(AVG(salary) OVER (), 2) in same SELECT. Hint: NTILE + AVG(salary) OVER () for company avg.
SELECT employee_id,
       salary,
       NTILE(4) OVER (ORDER BY salary) AS quartile,
       ROUND(AVG(salary) OVER (), 2) AS company_avg_salary
FROM hr.employees
ORDER BY quartile, salary;
-- H18. RANK() OVER (PARTITION BY manager_id ORDER BY salary DESC) (rank among direct reports per manager). Hint: Partition by manager_id.
SELECT employee_id,
       manager_id,
       salary,
       RANK() OVER (PARTITION BY manager_id ORDER BY salary DESC) AS report_rank
FROM hr.employees
ORDER BY manager_id, report_rank;
-- H19. Top 3 jobs by total salary: from (SELECT job_id, SUM(salary) s FROM hr.employees GROUP BY job_id ORDER BY s DESC FETCH FIRST 3 ROWS ONLY) or use RANK() over grouped data. Hint: Subquery with GROUP BY and RANK() OVER (ORDER BY SUM(salary) DESC) or FETCH.
SELECT job_id, 
       total_salary
FROM (
    SELECT 
        job_id,
        SUM(salary) AS total_salary,
        RANK() OVER (ORDER BY SUM(salary) DESC) AS rank_total
    FROM hr.employees
    GROUP BY job_id
) sub
WHERE rank_total <= 3
ORDER BY rank_total;
-- H20. DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) and also show (SELECT department_name FROM hr.departments d WHERE d.department_id = e.department_id). Hint: Join departments or scalar subquery for name; DENSE_RANK in SELECT.
SELECT 
    e.employee_id,
    e.salary,
    DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS dept_rank,
    (SELECT d.department_name 
     FROM hr.departments d 
     WHERE d.department_id = e.department_id) AS department_name
FROM hr.employees e
ORDER BY e.department_id, dept_rank;