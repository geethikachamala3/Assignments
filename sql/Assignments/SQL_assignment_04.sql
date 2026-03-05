-- q1.List employees hired in the year 2005.
select * from hr.employees where to_char(hire_date,'YYYY')=2005;
select * from hr.employees where extract(year from hire_date)=2005;
--q2.For each employee, show tenure in years using MONTHS_BETWEEN (and divide by 12). Use alias tenure_years, rounded to 1 decimal.
select employee_id,first_name,last_name,hire_date,round(months_between(sysdate,hire_date)/12,1) as tenure_years from hr.employees;
-- q3.Add a column salary_band using CASE: Low (salary < 5000), Medium (5000–11999), High (>= 12000). Show employee_id, first_name, salary, salary_band.
select employee_id, first_name, salary,
    CASE
        when salary<5000 then 'low'
        when salary<12000 then 'medium'
        else 'high'
    end as salary_band
from hr.employees;        
-- 1.Show the first 3 characters of last_name for each employee (use SUBSTR).
select first_name, last_name, substr(last_name,1,3) from hr.employees;
-- 2.List employees with tenure greater than 15 years (use MONTHS_BETWEEN as above).
select employee_id,first_name,last_name,round(months_between(sysdate, hire_date)/12,2) as tenure_year from hr.employees where months_between(sysdate, hire_date)>(15*12);
-- 3.In the SELECT list, use NVL(commission_pct, 0) in an expression that computes something like total compensation (e.g. salary + salary * commission). Give the expression an alias.
select employee_id,first_name,last_name,commission_pct,nvl(commission_pct,0), salary+(salary*nvl(commission_pct,0))as total_salary from hr.employees;
-- ================================================
-- M1. Show employee_id, first_name, and LENGTH(last_name) as last_name_length.
select employee_id,first_name, length(last_name) as last_name_length from hr.employees;
-- M2. List employees hired in 2004 using EXTRACT(YEAR FROM hire_date).
select hire_date,to_char(hire_date,'yyyy') as hire_year from hr.employees;
select hire_date,extract(year from hire_date)=2004 from hr.employees;
-- M3. Add a column job_type: 'Sales' if job_id like 'SA%', else 'Other'. Use CASE.
select job_id,
        case
            when job_id like 'SA%' then 'SAles'
            else 'other'
        end as job_type
from hr.employees;         
-- M4. Show first_name, last_name, and tenure in months (MONTHS_BETWEEN(SYSDATE, hire_date)).
select first_name, last_name, months_between(sysdate,hire_date) as tenure_months from hr.employees;
-- M5. List employees with salary between 4000 and 8000 and department_id 50 or 60. Use parentheses.
select * from hr.employees where salary between 4000 and 8000 and(department_id=50 or department_id=60);
-- M6. Display employee_id, salary, and salary_level: 'Tier1' if salary < 5000, 'Tier2' if < 10000, else 'Tier3'.
select employee_id,salary,
        CASE
            when salary<5000 then 'Tier1'
            when salary<10000 then 'Tier2'
            else 'tier3'
        end as salary_level
from hr.employees;        
-- M7. Show last_name and INITCAP(last_name).
select last_name,INITCAP(last_name) from hr.employees;
-- M8. List employees where department_id is in the set (10, 20, 30) from hr.departments (use subquery IN).
select department_id from hr.DEPARTMENTS where department_id in(select department_id from hr.departments where department_id in (10,20,30));
-- M9. Add column hire_month as EXTRACT(MONTH FROM hire_date).
select first_name, last_name, to_char(hire_date,'month') as hire_month from hr.EMPLOYEES;
-- M10. Show phone_number and COALESCE(phone_number, 'No Phone').
select * from hr.employees;
select phone_number,coalesce(phone_number, 'No_phone') as contact from hr.employees;
-- M11. List employees with (department_id = 50 AND salary > 5000) OR (department_id = 60).
select * from hr.employees where (department_id=50 and salary>5000) or (department_id=60);
-- M12. Display hire_date and ADD_MONTHS(hire_date, 12) as one_year_later.
select hire_date, add_months(hire_date,12) as one_year_later from hr.employees;
-- M13. Show first_name, last_name, and SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) as initials.
select first_name,last_name,substr(first_name,1,1)||substr(last_name,1,1) as initials from hr.employees;
-- M14. List employees hired after 2006-01-01.
select * from hr.employees where hire_date>date '2006-01-01';
-- M15. Add column has_commission: 'Yes' if commission_pct is not null, 'No' otherwise. Use NVL2 or CASE.
select first_name,last_name,nvl2(commission_pct,'Yes','No') as has_commission from hr.employees;
-- M16. Show salary and ROUND(salary, -2) (rounded to nearest hundred).
select salary,round(salary,-2) as rounded_salary from hr.employees;
-- M17. List employees where job_id is SA_REP or SA_MAN and salary > 8000.
select * from hr.employees where lower(job_id) in('sa_rep','sa_man') and salary>8000;
-- M18. Display employee_id, hire_date, and TRUNC(hire_date) (same day at midnight).
select employee_id,hire_date,TRUNC(hire_date) as hire_day from hr.employees;
-- M19. Show last_name and LOWER(last_name).
select last_name,lower(last_name) from hr.employees;
-- M20. List employees with tenure (MONTHS_BETWEEN/12) >= 10 years.
select * from hr.employees where months_between(sysdate,hire_date)/12>=10;
-- H1. Show employee_id, salary, and a band: 'A' if salary in top 25%, 'B' if next 25%, etc. Use NTILE(4) over salary order or CASE with subquery for percentiles.
select employee_id,
        salary,
        case NTILe(4) over(order by salary desc)
            when 1 then 'A'
            when 2 then 'B'
            when 3 then 'C'
            when 4 then 'D'
        end as salary_band
from hr.employees;         
-- H2. List employees whose hire_date is in the same year as their manager's hire_date (need self-join on manager_id; compare EXTRACT(YEAR FROM e.hire_date) = EXTRACT(YEAR FROM m.hire_date)).
select e.employee_id,
       e.first_name,
       e.hire_date as emp_hire_date,
       m.employee_id as manager_id,
       m.hire_date as mgr_hire_date
from hr.employees e
join hr.employees m
    on e.manager_id=m.MANAGER_ID
where extract(year from e.hire_date)=extract(year from m.hire_date);  
-- H3. Add column salary_vs_avg: (salary - (SELECT AVG(salary) FROM hr.employees)). Round to 2 decimals.
select salary,round(salary-(select avg(salary) from hr.employees),2) as salary_avg from hr.employees;
-- H4. List employees with exactly 5 characters in first_name.
select first_name from hr.employees where length(first_name)=5;
--H5. Show first_name, last_name, and full_name with last_name first: last_name || ', ' || first_name.
select first_name,last_name,first_name||' '||last_name as full_name from hr.employees;
-- H6. For each employee show hire_date and the day of week (use TO_CHAR(hire_date, 'Day') or similar).
select hire_date,to_char(hire_date,'Day') as day_of_week from hr.employees;
-- H7. List employees where department_id is in (SELECT department_id FROM hr.departments).
select * from hr.employees where department_id in(select department_id from hr.employees);
-- H8. Add column years_until_10: years until 10 years tenure (10 - tenure_years), only for people with < 10 years.
select first_name,
       last_name,
       hire_date,
       CASE
        when months_between(sysdate, hire_date)/12<10 then round(10-months_between(sysdate,hire_date)/12,1)
       end as remaining_tenure_years
from hr.employees;      
-- H9. Show salary and commission_pct and total_comp as salary + salary*NVL(commission_pct,0), rounded to 2 decimals.
select salary,commission_pct,round(salary*(1+nvl(commission_pct,0)),2) as total_comp from hr.employees;
-- H10. List employees hired on the first day of any month (EXTRACT(DAY FROM hire_date) = 1).
select first_name,hire_date from hr.employees where to_char(hire_date,'D')=1;
select * from hr.employees;
select employee_id, first_name,hire_date from hr.employees where extract(day from hire_date)=1;
-- H11. Display employee_id, salary, and salary rank within department (use RANK() OVER (PARTITION BY department_id ORDER BY salary DESC)).
select employee_id,
       salary,
       rank() over(partition by department_id order by salary desc) as sal_rank 
from hr.employees;
-- H12. List employees whose last_name contains the letter 'a' at least twice.
select * from hr.employees where (length(last_name)-length(replace(lower(last_name),'a','')))>=2;
-- H13. Show hire_date and LAST_DAY(hire_date) (last day of that month).
select hire_date,last_day(hire_date) as month_end from hr.employees;
-- H14. Add column comp_category: 'Salary only' if commission_pct is null, 'Salary+Commission' otherwise.
select employee_id,salary,commission_pct,
        CASE
            when commission_pct is null then 'Salary only'
            else 'salary+commission'
        end as comp_category 
from hr.employees;   
-- H15. List employees with tenure (years) between 5 and 15.
select * from hr.employees where months_between(sysdate,hire_date)/12 between 5 and 15;
-- H16. Show first_name reversed (use REVERSE or loop in PL/SQL; in Oracle no REVERSE—use SUBSTR in a custom way or simple: list as-is and add a note). For Oracle use: list first_name and perhaps SUBSTR from end.
select first_name,reverse(first_name) from hr.employees;
-- H17. List employees where department_id exists in hr.departments and salary > (SELECT AVG(salary) FROM hr.employees).
select * from hr.EMPLOYEES where department_id in(select department_id from hr.departments) and salary>(select avg(salary) from hr.employees);
-- H18. Display salary and salary with 15% bonus: salary * 1.15.
select salary,salary*1.15 as salary_with_bonus from hr.employees;
-- H19. Add column hire_decade: '2000s' if hire_date in 2000-2009, '1990s' if 1990-1999, else 'Other'.
select employee_id,
       first_name,
       CASE
        when extract(year from hire_date) between 2000 and 2009 then '2000s'
        when extract(year from hire_date) between 1990 and 1999 then '1990s'
        else 'other'
       end as hire_decade
from hr.employees;    
-- H20. List employees with first_name starting with 'A' or 'B' and salary > 6000.
select * from hr.employees where (first_name like 'A%' or first_name like 'B%') and salary>6000;
