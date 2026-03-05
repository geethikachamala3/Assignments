-- q1.Create a table hr_emp_copy with columns employee_id, first_name, last_name, department_id. Add a PRIMARY KEY on employee_id and a FOREIGN KEY on department_id referencing hr.departments(department_id).
CREATE TABLE hr_emp_copy (
  employee_id   NUMBER(6),
  first_name    VARCHAR2(20),
  last_name     VARCHAR2(25),
  department_id NUMBER(4),
  PRIMARY KEY (employee_id),
  FOREIGN KEY (department_id) REFERENCES hr.departments(department_id)
);
-- q2.Add a CHECK constraint on salary so that salary must be greater than 0. (If your table has no salary column, add it first with ALTER TABLE ... ADD salary NUMBER(8,2); then add the check.)
ALTER TABLE hr_emp_copy ADD salary NUMBER(8,2);
ALTER TABLE hr_emp_copy ADD CONSTRAINT chk_salary CHECK (salary > 0);
-- q3.Find the constraint names and types for table hr.employees. Query USER_CONSTRAINTS (or ALL_CONSTRAINTS) where table_name = 'EMPLOYEES'.
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
-- M1. Create a table with PRIMARY KEY on employee_id. Hint: CREATE TABLE ... (employee_id NUMBER(6) PRIMARY KEY, ...);
CREATE TABLE emp_copy (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    salary NUMBER(10,2),
    department_id NUMBER(4),
    hire_date DATE,
    manager_id NUMBER(6)
);
-- M2. Add FOREIGN KEY (department_id) REFERENCES hr.departments(department_id). Hint: ALTER TABLE ... ADD CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES hr.departments(department_id);
ALTER TABLE emp_copy
ADD CONSTRAINT fk_dept
FOREIGN KEY (department_id)
REFERENCES hr.departments(department_id);
-- M3. Add CHECK constraint: salary > 0. Hint: ADD CONSTRAINT chk_sal CHECK (salary > 0);
ALTER TABLE emp_copy
ADD CONSTRAINT chk_sal
CHECK (salary > 0);
-- M4. Add NOT NULL to first_name. Hint: ALTER TABLE ... MODIFY first_name NOT NULL;
ALTER TABLE emp_copy
MODIFY first_name NOT NULL;
-- M5. Add UNIQUE constraint on email column. Hint: ADD CONSTRAINT uk_email UNIQUE (email);
ALTER TABLE emp_copy
ADD CONSTRAINT uk_email UNIQUE (email);
-- M6. Name the primary key constraint pk_emp_copy. Hint: CONSTRAINT pk_emp_copy PRIMARY KEY (employee_id);
ALTER TABLE emp_copy
DROP CONSTRAINT emp_copy_PK; 
ALTER TABLE emp_copy
ADD CONSTRAINT pk_emp_copy PRIMARY KEY (employee_id);
-- M7. Drop a CHECK constraint by name. Hint: ALTER TABLE ... DROP CONSTRAINT chk_salary;
ALTER TABLE emp_copy
DROP CONSTRAINT chk_sal; 
-- M8. Create table with composite PRIMARY KEY (department_id, employee_id). Hint: PRIMARY KEY (department_id, employee_id);
CREATE TABLE emp_dept (
    department_id NUMBER(4),
    employee_id NUMBER(6),
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    salary NUMBER(10,2),
    hire_date DATE,
    manager_id NUMBER(6),
    CONSTRAINT pk_emp_dept PRIMARY KEY (department_id, employee_id)
);
-- M9. Add CHECK: hire_date <= SYSDATE (no future hire). Hint: CHECK (hire_date <= SYSDATE) — or use trigger for SYSDATE at insert time.
ALTER TABLE emp_copy
ADD CONSTRAINT chk_hiredate
CHECK (hire_date <= SYSDATE);
-- M10. Add FK manager_id REFERENCES hr.employees(employee_id). Hint: FOREIGN KEY (manager_id) REFERENCES hr.employees(employee_id);
ALTER TABLE emp_copy
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES hr.employees(employee_id);
-- M11. List constraint names on hr.employees. Hint: SELECT constraint_name, constraint_type FROM user_constraints WHERE table_name = 'EMPLOYEES';
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
-- M12. Add CHECK: commission_pct BETWEEN 0 AND 1. Hint: CHECK (commission_pct BETWEEN 0 AND 1);
ALTER TABLE hr.employees
ADD CONSTRAINT chk_commission
CHECK (commission_pct BETWEEN 0 AND 1);
-- M13. Add UNIQUE (first_name, last_name) — same full name not repeated. Hint: ADD CONSTRAINT uk_name UNIQUE (first_name, last_name);
ALTER TABLE hr.employees
ADD CONSTRAINT uk_fullname UNIQUE (first_name, last_name);
-- M14. Modify column to NOT NULL. Hint: ALTER TABLE ... MODIFY column_name ... NOT NULL;
ALTER TABLE hr.employees
MODIFY last_name NOT NULL;
-- M15. Create table with PK and two FK (department_id, manager_id). Hint: Two ADD CONSTRAINT ... FOREIGN KEY ...
CREATE TABLE emp_extended (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50),
    department_id NUMBER(4),
    manager_id NUMBER(6),
    CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES hr.departments(department_id),
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES hr.employees(employee_id)
);
-- M16. Drop foreign key constraint by name. Hint: ALTER TABLE ... DROP CONSTRAINT fk_emp_dept;
ALTER TABLE hr.employees
DROP CONSTRAINT fk_emp_dept;  -- replace with actual FK constraint name
-- M17. Add CHECK: employee_id > 0. Hint: CHECK (employee_id > 0);
ALTER TABLE hr.employees
ADD CONSTRAINT chk_empid
CHECK (employee_id > 0);
-- M18. Find constraint type (P/R/U/C) for hr.departments. Hint: USER_CONSTRAINTS; P=primary, R=foreign, U=unique, C=check/not null.
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'DEPARTMENTS';
-- M19. Add DEFAULT 0 for a numeric column and add NOT NULL. Hint: DEFAULT 0 and NOT NULL in column definition or MODIFY.
ALTER TABLE hr.employees
MODIFY salary NUMBER(10,2) DEFAULT 0 NOT NULL;
-- M20. Add named CHECK constraint. Hint: ADD CONSTRAINT name CHECK (condition);
ALTER TABLE hr.employees
ADD CONSTRAINT chk_salary_positive
CHECK (salary > 0);
-- =============================================================
-- H1. Create table with PK, FK to departments, and CHECK salary > 0 and commission_pct BETWEEN 0 AND 1. Hint: All in CREATE TABLE or ADD after.
CREATE TABLE emp_advanced (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50),
    department_id NUMBER(4),
    salary NUMBER(10,2),
    commission_pct NUMBER(3,2),
    hire_date DATE,
    CONSTRAINT fk_dept FOREIGN KEY (department_id)
        REFERENCES hr.departments(department_id),
    CONSTRAINT chk_salary CHECK (salary > 0),
    CONSTRAINT chk_commission CHECK (commission_pct BETWEEN 0 AND 1)
);
-- H2. Add FK with ON DELETE SET NULL (Oracle: reference option). Hint: REFERENCES hr.departments(department_id) ON DELETE SET NULL;
ALTER TABLE emp_advanced
ADD CONSTRAINT fk_dept_setnull
FOREIGN KEY (department_id)
REFERENCES hr.departments(department_id)
ON DELETE SET NULL;
-- H3. Disable constraint, do DML, re-enable constraint. Hint: ALTER DISABLE CONSTRAINT; ...; ALTER ENABLE CONSTRAINT;
ALTER TABLE emp_advanced
DISABLE CONSTRAINT chk_salary;
UPDATE emp_advanced SET salary = -100 WHERE employee_id = 101;
ALTER TABLE emp_advanced
ENABLE CONSTRAINT chk_salary;
-- H4. Add CHECK that references two columns: salary >= commission_pct * 1000 (example). Hint: CHECK (salary >= NVL(commission_pct,0) * 1000);
ALTER TABLE emp_advanced
ADD CONSTRAINT chk_salary_commission
CHECK (salary >= NVL(commission_pct,0) * 1000);
-- H5. Create table with DEFERRABLE constraint (Oracle). Hint: CONSTRAINT ... PRIMARY KEY ... DEFERRABLE INITIALLY DEFERRED;
CREATE TABLE emp_deferrable (
    employee_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT pk_emp_def PRIMARY KEY (employee_id)
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT fk_dept_def FOREIGN KEY (department_id)
        REFERENCES hr.departments(department_id)
        DEFERRABLE INITIALLY DEFERRED
);
-- H6. List all constraints and their columns for hr.employees. Hint: Join user_constraints and user_cons_columns.
SELECT uc.constraint_name,
       uc.constraint_type,
       ucc.column_name
FROM user_constraints uc
JOIN user_cons_columns ucc
  ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'EMPLOYEES'
ORDER BY uc.constraint_name, ucc.position;
-- H7. Add FK from copy table to hr.employees(employee_id) for manager_id; handle NULL. Hint: FK allows NULL; REFERENCES hr.employees(employee_id).
ALTER TABLE emp_advanced
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES hr.employees(employee_id);
-- H8. Add CHECK: hire_date >= DATE '1990-01-01'. Hint: CHECK (hire_date >= DATE '1990-01-01');
ALTER TABLE emp_advanced
ADD CONSTRAINT chk_hiredate
CHECK (hire_date >= DATE '1990-01-01');
-- H9. Create unique constraint on (department_id, job_id) for a copy table. Hint: ADD CONSTRAINT uk_dept_job UNIQUE (department_id, job_id);
ALTER TABLE emp_advanced
ADD CONSTRAINT uk_dept_job UNIQUE (department_id, job_id);
-- H10. Drop all CHECK constraints on a table (dynamic SQL or one by one). Hint: SELECT constraint_name FROM user_constraints WHERE table_name = 'X' AND constraint_type = 'C'; then DROP for each.
SELECT constraint_name
FROM user_constraints
WHERE table_name = 'EMP_ADVANCED'
  AND constraint_type = 'C';
-- H11. Add NOT NULL to a column that has NULLs (will fail unless you update first). Hint: UPDATE ... SET col = value WHERE col IS NULL; then MODIFY col NOT NULL;
UPDATE hr.employees
SET commission_pct = 0
WHERE commission_pct IS NULL;
ALTER TABLE hr.employees
MODIFY commission_pct NOT NULL;
-- H12. Add FK to self (manager_id references employee_id). Hint: FOREIGN KEY (manager_id) REFERENCES same_table(employee_id);
ALTER TABLE hr.employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES hr.employees(employee_id);
-- H13. Create table with PK and two FKs and one CHECK. Hint: CREATE TABLE ... ( ... PRIMARY KEY ..., CONSTRAINT fk1 FOREIGN KEY ... CONSTRAINT fk2 FOREIGN KEY ... CONSTRAINT chk1 CHECK ... );
CREATE TABLE emp_complex (
    employee_id NUMBER(6),
    department_id NUMBER(4),
    manager_id NUMBER(6),
    salary NUMBER(10,2),
    CONSTRAINT pk_emp_complex PRIMARY KEY (employee_id),
    CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES hr.departments(department_id),
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES emp_complex(employee_id),
    CONSTRAINT chk_salary CHECK (salary > 0)
);
-- H14. Find tables that reference hr.departments (foreign keys). Hint: user_constraints WHERE r_constraint_name = (SELECT constraint_name FROM user_constraints WHERE table_name = 'DEPARTMENTS' AND constraint_type = 'P').
SELECT uc.table_name, uc.constraint_name
FROM user_constraints uc
WHERE uc.r_constraint_name = (
    SELECT constraint_name
    FROM user_constraints
    WHERE table_name = 'DEPARTMENTS'
      AND constraint_type = 'P'
);
-- H15. Add CHECK using a function: LENGTH(first_name) >= 2. Hint: CHECK (LENGTH(first_name) >= 2);
ALTER TABLE hr.employees
ADD CONSTRAINT chk_firstname_length
CHECK (LENGTH(first_name) >= 2);
-- H16. Enable constraint with VALIDATE (check existing data). Hint: ALTER TABLE ... ENABLE VALIDATE CONSTRAINT ...;
ALTER TABLE hr.employees
ENABLE VALIDATE CONSTRAINT chk_firstname_length;
-- H17. Create composite UNIQUE (department_id, job_id) and composite FK (department_id references departments). Hint: UNIQUE (dept, job); FK (department_id) REFERENCES departments(department_id);
ALTER TABLE emp_copy
ADD CONSTRAINT uk_dept_job UNIQUE (department_id, job_id);
ALTER TABLE emp_copy
ADD CONSTRAINT fk_dept_ref
FOREIGN KEY (department_id)
REFERENCES hr.departments(department_id);
-- H18. Add constraint that salary must be <= (SELECT MAX(salary) FROM hr.employees) — not standard CHECK; use trigger. Hint: CHECK cannot subquery; use trigger to enforce.
CREATE OR REPLACE TRIGGER trg_salary_max
BEFORE INSERT OR UPDATE ON hr.employees
FOR EACH ROW
DECLARE
    v_max_salary NUMBER;
BEGIN
    SELECT MAX(salary) INTO v_max_salary FROM hr.employees;
    IF :NEW.salary > v_max_salary THEN
        RAISE_APPLICATION_ERROR(-20002, 'Salary exceeds max allowed.');
    END IF;
END;
/
-- H19. Rename a constraint. Hint: Oracle: ALTER TABLE ... RENAME CONSTRAINT old_name TO new_name;
ALTER TABLE hr.employees
RENAME CONSTRAINT chk_firstname_length TO chk_fname_len;
-- H20. List constraint type and search_condition for CHECK constraints. Hint: user_constraints has constraint_type; search_condition in user_constraints (Oracle 12c+) or all_constraints.
SELECT constraint_name,
       constraint_type,
       search_condition
FROM user_constraints
WHERE table_name = 'EMPLOYEES'
  AND constraint_type = 'C';
