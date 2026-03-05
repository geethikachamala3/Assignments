--joins
select *from employee;
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(15) NOT NULL,
    salary NUMBER(10,2),
    city VARCHAR2(10),
    joining_date DATE,
    dept varchar(10)
);
desc employees;
INSERT INTO employees  VALUES (1,'Charan', 75000, 'Bangalore', date '2023-01-15', 'develop');
INSERT INTO employees  VALUES (2,'Vikas', 68000, 'Hyderabad', DATE '2023-02-10', 'develop');
INSERT INTO employees  VALUES (3,'Sai', 72000, 'Chennai', DATE '2023-03-05', 'test');
INSERT INTO employees  VALUES (4,'Ravi', 65000, 'Mumbai', DATE '2023-04-12', 'test');
INSERT INTO employees  VALUES (5,'Anil', 80000, 'Pune', DATE '2023-05-20', 'support');

INSERT INTO employees  VALUES (6,'Kiran', 55000, 'Delhi', DATE '2023-06-18', 'develop');
INSERT INTO employees  VALUES (7,'Manoj', 60000, 'Kolkata', DATE '2023-07-22', 'test');
INSERT INTO employees  VALUES (8,'Suresh', 90000, 'Bangalore', DATE '2023-08-14', 'hr');
INSERT INTO employees  VALUES (9,'Mahesh', 85000, 'Hyderabad', DATE '2023-09-09', 'develop');
INSERT INTO employees  VALUES (10,'Naresh', 50000, 'Chennai', DATE '2023-10-01', 'test');

INSERT INTO employees  VALUES (11,'Pavan', 70000, 'Pune', DATE '2023-11-11', 'hr');
INSERT INTO employees  VALUES (12,'Arjun', 95000, 'Delhi', DATE '2023-12-25', 'hr');
INSERT INTO employees  VALUES (13,'Ramesh', 40000, 'Mumbai', DATE '2024-01-17', 'finance');
INSERT INTO employees  VALUES (14,'Krishna', 72000, 'Bangalore', DATE '2024-02-03', 'finance');
INSERT INTO employees  VALUES (15,'Ajay', 88000, 'Hyderabad', DATE '2024-03-19', 'marketing');

INSERT INTO employees  VALUES (16,'Deepak', 76000, 'Chennai', DATE '2024-04-28', 'marketing');
INSERT INTO employees  VALUES (17,'Vijay', 54000, 'Kolkata', DATE '2024-05-16', 'develop');
INSERT INTO employees  VALUES (18,'Rahul', 82000, 'Pune', DATE '2024-06-07', 'develop');
INSERT INTO employees  VALUES (19,'Surya', 91000, 'Delhi', DATE '2024-07-30', 'test');
INSERT INTO employees  VALUES (20,'Naveen', 63000, 'Mumbai', DATE '2024-08-21', 'test');

select * from employees;
--display emp count ,total_salary on deptwise from employees table where dept has more than 3 employees
select dept,
    count(emp_name) as emp_count,
    sum(salary) as total_salary
    from employees 
    group by dept 
    having count(emp_name)>3;
    
--=======================
--types of join
--inner
--left
--right
--full
--cross
--==========================
create table table1(id1 number(2));
desc table1;
select * from table1;
insert into table1 values(1);
insert into table1 values(2);
insert into table1 values(3);
insert into table1 values(4);
select * from table1;
create table table2(id2 number);
desc table2;
insert into table2 values(1);
insert into table2 values(2);
insert into table2 values(4);
select * from table1;
select * from table1 inner join table2 on table1.id1=table2.id2;
select * from table1 left join table2 on table1.id1=table2.id2;
select * from table1 right join table2 on table1.id1=table2.id2;
delete from table2 where id2=1;
select * from table1;
select * from table2;
insert into table2 values(5);
select * from table2;
select * from table1 inner join table2 on table1.id1=table2.id2;
select * from table1 left join table2 on table1.id1=table2.id2;
select * from table1 right join table2 on table1.id1=table2.id2;
select * from table1 full join table2 on table1.id1=table2.id2;
select * from table1 cross join table2;
--====================================
create table emp_details(emp_id number, emp_name varchar(15));
desc emp_details;
insert into emp_details values(1, 'charan');
insert into emp_details values(2, 'hari');
insert into emp_details values(3, 'rahul');
select * from emp_details;
create table emp_salary( emp_id number, emp_salary number(10,2) );
desc emp_salary;
insert into emp_salary values(1, 50000);
insert into emp_salary values(2, 40000);
insert into emp_salary values(4, 50000);
select * from emp_salary;
--display emp_id,emo_name,empsalary from emp database
select ed.emp_id,
       ed.emp_name,
       es.emp_salary
       from emp_details ed left join emp_salary es on ed.emp_id=es.emp_id;
select ed.emp_id, 
    ed.emp_name, 
    es.emp_salary
    from emp_details ed join emp_salary es on ed.emp_id = es.emp_id;    
select es.emp_id, 
    ed.emp_name, 
    es.emp_salary
    from emp_details ed right join emp_salary es on ed.emp_id = es.emp_id; 
select * from emp_salary;
create table table3( id1 number);
insert into table3 values(1); 
insert into table3 values(3); 
insert into table3 values(1); 
insert into table3 values(2); 
insert into table3 values(3); 
insert into table3 values(null); 
create table table4( id2 number);
insert into table4 values(1);
insert into table4 values(1);
insert into table4 values(1);
insert into table4 values(3);
insert into table4 values(2);
insert into table4 values(null);
insert into table4 values(null);
select * from table4;
select count(*) from table3 full join table4 on table3.id1=table4.id2;
select count(*) from table3 left join table4 on table3.id1=table4.id2;
select count(*) from table3 right join table4 on table3.id1=table4.id2;
select count(*) from table3 join table4 on table3.id1=table4.id2;
CREATE TABLE emp1 (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(15)
);
INSERT INTO emp1 VALUES (1, 'Charan');
INSERT INTO emp1 VALUES (2, 'Ravi');
INSERT INTO empl VALUES (3, 'Anil');
INSERT INTO emp1 VALUES (4, 'Neha');
INSERT INTO emp1 VALUES (5, 'John');
select * from emp1;
CREATE TABLE emp2 (
    emp_id NUMBER,
    salary NUMBER,
    dept   VARCHAR2(10)
);
INSERT INTO emp2 VALUES (1, 50000, 'IT');
INSERT INTO emp2 VALUES (2, 60000, 'HR');
INSERT INTO emp2 VALUES (3, 45000, 'IT');
INSERT INTO emp2 VALUES (4, 70000, 'Sales');
select * from emp2;
select e1.emp_id,emp_name,salary,dept from emp1 e1 left join emp2 e2 on e1.emp_id=e2.emp_id;
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(10),
    city VARCHAR2(10)
);
INSERT INTO customers VALUES (1, 'Charan', 'Bangalore');
INSERT INTO customers VALUES (2, 'Ravi', 'Hyderabad');
INSERT INTO customers VALUES (3, 'Anil', 'Chennai');
INSERT INTO customers VALUES (4, 'Neha', 'Mumbai');
INSERT INTO customers VALUES (5, 'John', 'Delhi');
select * from customers;
CREATE TABLE oder(
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE,
    amount NUMBER
);
INSERT INTO oder VALUES (101, 1, DATE '2024-01-10', 500);
INSERT INTO oder VALUES (102, 1, DATE '2024-01-12', 700);
INSERT INTO oder VALUES (103, 2, DATE '2024-01-15', 300);
INSERT INTO oder VALUES (104, 3, DATE '2024-01-18', 900);
INSERT INTO oder VALUES (105, 3, DATE '2024-01-20', 200);
INSERT INTO oder VALUES (106, 4, DATE '2024-01-22', 1000);
select * from oder;
select c.customer_id, c.customer_name, sum(amount) as total_amount, count(order_id) 
from customers c left join oder o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;
