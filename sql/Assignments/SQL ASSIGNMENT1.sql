--select * from hr.DEPARTMENTS;
select * from hr.EMPLOYEES;
--How many employees earn more than 8000 salary?
SELECT COUNT(*) AS EMP_COUNT FROM HR.EMPLOYEES WHERE SALARY>8000;
--How many employees were hired before 2015?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE HIRE_DATE<'31-DEC-2014';
--How many employees belong to department 50?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=50;
--How many employees have commission percentage assigned?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
--How many employees do not have a manager?
SELECT * FROM HR.EMPLOYEES WHERE MANAGER_ID IS NULL;
SELECT * FROM HR.EMPLOYEES;
--How many employees’ first name starts with ‘J’?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE FIRST_NAME LIKE 'J%';
--How many employees’ last name ends with ‘S’?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE LAST_NAME LIKE '%s';
--How many employees have salary between 4000 and 9000?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE SALARY BETWEEN 4000 AND 9000;
--How many employees earn the maximum salary?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE SALARY=(SELECT MAX(SALARY) FROM HR.EMPLOYEES);
--How many employees earn the minimum salary?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE SALARY=(SELECT MIN(SALARY) FROM HR.EMPLOYEES)
--How many employees have email containing letter ‘A’?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE EMAIL LIKE '%A%';
--How many employees have job_id starting with ‘IT’?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE JOB_ID LIKE 'IT%';
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE JOB_ID='IT_PROG';
SELECT * FROM HR.EMPLOYEES;
--How many employees were hired in 2021?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY')=2021;
--How many employees have salary less than average salary?
SELECT * FROM HR.EMPLOYEES WHERE SALARY<(SELECT AVG(SALARY) FROM HR.EMPLOYEES);
--How many employees have phone number available?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE PHONE_NUMBER IS NOT NULL;
-- How many employees do not belong to any department?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE DEPARTMENT_ID IS NULL;
-- How many employees have exactly 6 characters in first name?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE LENGTH(FIRST_NAME)=6;
-- How many employees have salary greater than 5000 and department 20?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE SALARY>5000 AND DEPARTMENT_ID=20;
-- How many employees have commission greater than 0.15?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE COMMISSION_PCT>0.15;
-- How many employees have salary not between 3000 and 7000?
SELECT COUNT(*) FROM HR.EMPLOYEES WHERE SALARY NOT BETWEEN 3000 AND 7000;
