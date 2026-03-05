-- q1.Show a running total of salary ordered by hire_date (company-wide). For each row, show employee_id, hire_date, salary, and running_total_salary.
SELECT employee_id, 
       hire_date, 
       salary,
  SUM(salary) OVER (ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_salary
FROM hr.employees;
-- q2.For each employee, show previous employee salary within the same department (order by employee_id). Use LAG(salary) with PARTITION BY department_id ORDER BY employee_id.
SELECT employee_id, 
       department_id, 
       salary,
  LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_salary_in_dept
FROM hr.employees;
-- q3.Show a moving 3-row average of salary within each department. Order by employee_id; for each row, average the current row and the two preceding rows (or fewer at the start). Use AVG(salary) with ROWS BETWEEN 2 PRECEDING AND CURRENT ROW.
SELECT employee_id, 
       department_id, s
       alary,
  AVG(salary) OVER (PARTITION BY department_id ORDER BY employee_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
FROM hr.employees;
-- =====================================================
-- M1. LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id). Hint: Previous row's salary in dept.
SELECT employee_id,
       department_id,
       salary,
       LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_salary
FROM hr.employees
ORDER BY department_id, employee_id;
-- M2. LEAD(salary) OVER (PARTITION BY department_id ORDER BY employee_id). Hint: Next row's salary in dept.
SELECT employee_id,
       department_id,
       salary,
       LEAD(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS next_salary
FROM hr.employees
ORDER BY department_id, employee_id;
-- M3. SUM(salary) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total. Hint: Running total by hire_date.
SELECT employee_id,
       hire_date,
       salary,
       SUM(salary) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS running_total
FROM hr.employees
ORDER BY hire_date;
-- M4. AVG(salary) OVER (PARTITION BY department_id). Hint: Dept average per row.
SELECT employee_id,
       department_id,
       salary,
       AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM hr.employees
ORDER BY department_id, employee_id;
-- M5. LAG(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date). Hint: Previous hire date in dept.
SELECT employee_id,
       department_id,
       hire_date,
       LAG(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS prev_hire_date
FROM hr.employees
ORDER BY department_id, hire_date;
-- M6. SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING AND CURRENT ROW). Hint: Running total per dept by hire_date.
SELECT employee_id,
       department_id,
       hire_date,
       salary,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS dept_running_total
FROM hr.employees
ORDER BY department_id, hire_date;
-- M7. LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date). Hint: Next hire date in dept.
SELECT employee_id,
       department_id,
       hire_date,
       LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS next_hire_date
FROM hr.employees
ORDER BY department_id, hire_date;
-- M8. AVG(salary) OVER (PARTITION BY department_id ORDER BY employee_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW). Hint: Moving 3-row average per dept.
SELECT employee_id,
       department_id,
       salary,
       AVG(salary) OVER (
        PARTITION BY department_id 
        ORDER BY employee_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM hr.employees
ORDER BY department_id, employee_id;
-- M9. FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary). Hint: Min salary in dept.
SELECT employee_id,
       department_id,
       salary,
      FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary) AS min_salary_in_dept
FROM hr.employees
ORDER BY department_id, salary;
-- M10. LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING). Hint: Max salary in dept.
SELECT employee_id,
       department_id,
       salary,
       LAST_VALUE(salary) OVER (
           PARTITION BY department_id 
           ORDER BY salary 
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS max_salary_in_dept
FROM hr.employees
ORDER BY department_id, salary;
-- M11. LAG(salary, 2, 0) OVER (ORDER BY employee_id). Hint: Salary from 2 rows back; default 0.
SELECT employee_id,
       salary,
       LAG(salary, 2, 0) OVER (ORDER BY employee_id) AS salary_2_back
FROM hr.employees
ORDER BY employee_id;
-- M12. SUM(salary) OVER (PARTITION BY job_id ORDER BY hire_date). Hint: Running total per job.
SELECT employee_id,
       job_id,
       salary,
       SUM(salary) OVER (PARTITION BY job_id ORDER BY hire_date) AS running_total_job
FROM hr.employees
ORDER BY job_id, hire_date;
-- M13. LEAD(commission_pct) OVER (PARTITION BY department_id ORDER BY employee_id). Hint: Next row's commission_pct in dept.
SELECT employee_id,
       department_id,
       commission_pct,
       LEAD(commission_pct) OVER (PARTITION BY department_id ORDER BY employee_id) AS next_commission_pct
FROM hr.employees
ORDER BY department_id, employee_id;
-- M14. AVG(salary) OVER (ORDER BY hire_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW). Hint: Moving 5-row average.
SELECT employee_id,
       hire_date,
       salary,
       AVG(salary) OVER (
           ORDER BY hire_date
           ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
       ) AS moving_avg_5
FROM hr.employees
ORDER BY hire_date;
-- M15. LAG(first_name) OVER (PARTITION BY department_id ORDER BY employee_id). Hint: Previous employee's first name in dept.
SELECT employee_id,
       department_id,
       first_name,
       LAG(first_name) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_first_name
FROM hr.employees
ORDER BY department_id, employee_id;
-- M16. SUM(salary) OVER () AS total_company_salary (same value per row). Hint: No PARTITION/ORDER or ORDER BY with full window.
SELECT employee_id,
       salary,
       SUM(salary) OVER () AS total_company_salary
FROM hr.employees;
-- M17. FIRST_VALUE(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date). Hint: Earliest hire in dept.
SELECT employee_id,
       department_id,
       hire_date,
       FIRST_VALUE(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_hire_date
FROM hr.employees
ORDER BY department_id, hire_date;
-- M18. LAST_VALUE(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING). Hint: Latest hire in dept.
SELECT employee_id,
       department_id,
       hire_date,
       LAST_VALUE(hire_date) OVER (
           PARTITION BY department_id 
           ORDER BY hire_date
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_hire_date
FROM hr.employees
ORDER BY department_id, hire_date;
-- M19. LAG(salary) OVER (ORDER BY salary DESC). Hint: Next lower salary (order by salary desc so "previous" in that order).
SELECT employee_id,
       salary,
       LAG(salary) OVER (ORDER BY salary DESC) AS prev_lower_salary
FROM hr.employees
ORDER BY salary DESC;
-- M20. COUNT(*) OVER (PARTITION BY department_id). Hint: Count of employees in dept per row.
SELECT employee_id,
       department_id,
       COUNT(*) OVER (PARTITION BY department_id) AS dept_emp_count
FROM hr.employees
ORDER BY department_id, employee_id;
-- ===========================================================================
-- H1. Running total of salary by hire_date for whole company; also show running count (COUNT(*) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING AND CURRENT ROW)). Hint: SUM and COUNT with same frame.
SELECT employee_id,
       hire_date,
       salary,
       SUM(salary) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS running_total,
       COUNT(*) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS running_count
FROM hr.employees
ORDER BY hire_date;
-- H2. For each employee show salary, LAG(salary), and salary - LAG(salary) AS diff_from_prev (difference from previous row's salary in partition). Hint: LAG in SELECT; then expression; partition by dept order by employee_id.
SELECT employee_id,
       department_id,
       salary,
       LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_salary,
       salary - LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS diff_from_prev
FROM hr.employees
ORDER BY department_id, employee_id;
-- H3. Moving average of salary (5 rows: 2 preceding, current, 2 following) per department. Hint: ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING.
SELECT employee_id,
       department_id,
       salary,
       AVG(salary) OVER (
           PARTITION BY department_id 
           ORDER BY employee_id 
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS moving_avg_5
FROM hr.employees
ORDER BY department_id, employee_id;
-- H4. FIRST_VALUE(salary) and LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary) with correct frame for LAST_VALUE. Hint: LAST_VALUE needs RANGE UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING.
SELECT employee_id,
       department_id,
       salary,
       FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary) AS min_salary,
       LAST_VALUE(salary) OVER (
           PARTITION BY department_id 
           ORDER BY salary 
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS max_salary
FROM hr.employees
ORDER BY department_id, salary;
-- H5. Lead of hire_date (next hire in dept) and DATEDIFF or (LEAD(hire_date) - hire_date) for days between hires. Hint: LEAD(hire_date) - hire_date; Oracle date arithmetic gives days.
SELECT employee_id,
       department_id,
       hire_date,
       LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS next_hire_date,
       LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) - hire_date AS days_until_next
FROM hr.employees
ORDER BY department_id, hire_date;
-- H6. Running sum of salary partitioned by department_id, ordered by hire_date; also show row number within department by hire_date. Hint: SUM(...) OVER (PARTITION BY department_id ORDER BY hire_date); ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date).
SELECT employee_id,
       department_id,
       hire_date,
       salary,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS dept_running_total,
       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) AS dept_rn
FROM hr.employees
ORDER BY department_id, hire_date;
-- H7. LAG(salary, 1, salary) OVER (PARTITION BY department_id ORDER BY employee_id) (previous salary or self if first). Hint: Default third arg = salary for first row.
SELECT employee_id,
       department_id,
       salary,
       LAG(salary, 1, salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_or_self
FROM hr.employees
ORDER BY department_id, employee_id;
-- H8. Percent of department total: salary * 100.0 / SUM(salary) OVER (PARTITION BY department_id). Hint: Ratio to sum; no ORDER BY in SUM for full partition.
SELECT employee_id,
       department_id,
       salary,
       salary * 100.0 / SUM(salary) OVER (PARTITION BY department_id) AS pct_of_dept_total
FROM hr.employees
ORDER BY department_id, employee_id;
-- H9. Running total of salary by department and hire_date; show also cumulative percentage of department total (running_sum / SUM(salary) OVER (PARTITION BY department_id) * 100). Hint: Running sum and fixed sum per dept.
SELECT employee_id,
       department_id,
       hire_date,
       salary,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS running_total,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING) * 100.0 /
       SUM(salary) OVER (PARTITION BY department_id) AS running_pct
FROM hr.employees
ORDER BY department_id, hire_date;
-- H10. LEAD(salary, 2) OVER (PARTITION BY job_id ORDER BY salary DESC) (salary of person 2 ranks below in job). Hint: LEAD with offset 2.
SELECT employee_id,
       job_id,
       salary,
       LEAD(salary, 2) OVER (PARTITION BY job_id ORDER BY salary DESC) AS salary_2_below
FROM hr.employees
ORDER BY job_id, salary DESC;
-- H11. FIRST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY salary DESC) (name of highest-paid in dept). Hint: ORDER BY salary DESC; first value is top earner.
SELECT employee_id,
       department_id,
       salary,
       FIRST_VALUE(first_name) OVER (
           PARTITION BY department_id 
           ORDER BY salary DESC
       ) AS top_earner_name
FROM hr.employees
ORDER BY department_id, salary DESC;
-- H12. Moving 3-row median or middle value: use NTH_VALUE(salary, 2) OVER (PARTITION BY department_id ORDER BY salary ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) if available, or average of 3. Hint: Oracle: NTH_VALUE or (LAG(salary)+salary+LEAD(salary))/3 for 3-row window.
SELECT employee_id,
       department_id,
       salary,
       (LAG(salary) OVER (PARTITION BY department_id ORDER BY salary) +
        salary +
        LEAD(salary) OVER (PARTITION BY department_id ORDER BY salary)) / 3 AS moving_3row_avg
FROM hr.employees
ORDER BY department_id, salary;
-- H13. Running sum of salary per department; reset at each new department. Hint: SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_id ROWS UNBOUNDED PRECEDING AND CURRENT ROW).
SELECT employee_id,
       department_id,
       salary,
       SUM(salary) OVER (
           PARTITION BY department_id 
           ORDER BY employee_id 
           ROWS UNBOUNDED PRECEDING
       ) AS dept_running_total
FROM hr.employees
ORDER BY department_id, employee_id;
-- H14. LAG(salary) and LEAD(salary) in same SELECT; show salary, prev, next. Hint: Both LAG and LEAD with same PARTITION/ORDER.
SELECT employee_id,
       department_id,
       salary,
       LAG(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS prev_salary,
       LEAD(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS next_salary
FROM hr.employees
ORDER BY department_id, employee_id;
-- H15. LAST_VALUE(employee_id) OVER (PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) (employee_id of last hired in dept). Hint: LAST_VALUE with full frame.
SELECT employee_id,
       department_id,
       hire_date,
       LAST_VALUE(employee_id) OVER (
           PARTITION BY department_id 
           ORDER BY hire_date 
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_hired_id
FROM hr.employees
ORDER BY department_id, hire_date;
-- H16. Running average (not sum) of salary over hire_date: AVG(salary) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING AND CURRENT ROW). Hint: AVG with same frame as running sum.
SELECT employee_id,
       hire_date,
       salary,
       AVG(salary) OVER (
           ORDER BY hire_date 
           ROWS UNBOUNDED PRECEDING
       ) AS running_avg
FROM hr.employees
ORDER BY hire_date;
-- H17. Difference from department average: salary - AVG(salary) OVER (PARTITION BY department_id). Hint: No ORDER BY in AVG for partition average.
SELECT employee_id,
       department_id,
       salary,
       salary - AVG(salary) OVER (PARTITION BY department_id) AS diff_from_dept_avg
FROM hr.employees
ORDER BY department_id, employee_id;
-- H18. LAG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) and compare to current (salary - LAG(salary)). Hint: LAG by hire_date; then diff.
SELECT employee_id,
       department_id,
       hire_date,
       salary,
       LAG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS prev_salary,
       salary - LAG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS diff_from_prev
FROM hr.employees
ORDER BY department_id, hire_date;
-- H19. COUNT(*) OVER (PARTITION BY department_id ORDER BY hire_date ROWS UNBOUNDED PRECEDING AND CURRENT ROW) (running count of employees in dept by hire order). Hint: Running count with same frame.
SELECT employee_id,
       department_id,
       hire_date,
       COUNT(*) OVER (
           PARTITION BY department_id 
           ORDER BY hire_date 
           ROWS UNBOUNDED PRECEDING
       ) AS running_count
FROM hr.employees
ORDER BY department_id, hire_date;
-- H20. FIRST_VALUE and LAST_VALUE of salary OVER (PARTITION BY job_id ORDER BY salary); show job_id, salary, min_sal, max_sal. Hint: FIRST_VALUE and LAST_VALUE with full frame for LAST_VALUE.
SELECT employee_id,
       job_id,
       salary,
       FIRST_VALUE(salary) OVER (PARTITION BY job_id ORDER BY salary) AS min_salary,
       LAST_VALUE(salary) OVER (
           PARTITION BY job_id 
           ORDER BY salary 
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS max_salary
FROM hr.employees
ORDER BY job_id, salary;