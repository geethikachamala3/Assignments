show database;
show database
show tables;
show tables in mysql;
create table Employee_Details
(
Emp_id number(5)
,Emp_name varchar2(10)
,Mobile_no number(10)
,G_mail varchar2(20)
,Location varchar2(20)
,Dept varchar2(10)
);
Desc Employee_Details;
insert into Employee_Details values(1, 'Mounisha', 8555833685, 'mouni2003@gmail.com', 'Bangalore', 'dev');
insert into Employee_Details values(2, 'Manisha', 8555833686, 'manisha@gmail.com', 'Hyderabad', 'support');
insert into Employee_Details values(3, 'Akshith', 8555833687, 'akki2003@gmail.com', 'Chennai', 'production');
insert into Employee_Details values(4, 'Joshnitha', 8555833688, 'joshi2003@gmail.com', 'Bangalore', 'sit');
select * from Employee_Details;
insert into Employee_Details values(5,'Keerthi', 9000007979,'keerthi@2010','Null','dev');
select * from Employee_Details;
select * from Employee_Details where Dept='dev';
select * from Employee_Details where Dept!='dev';
select count(*) from Employee_Details;
select count(Emp_name) from Employee_Details;
