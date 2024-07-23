-- complex queries
-- 1) fetch duplicate records from a table using window function
select user_id, user_name, email 
from 
	(select * , row_number() over (partition by user_name order by user_id) as rn 
	from users 
    order by user_id) x
where x.rn > 1;


-- 2) Write a SQL query to fetch the second last record from employee table 

select * 
from
	(select * , row_number() over (order by emp_id) as rn
    from employee e 
    order by emp_id) x
where x.rn > 2;

/*
select emp_id, emp_name, dept_name, salary
from (
select *,
row_number() over (order by emp_id desc) as rn
from employee e) x
where x.rn = 2;
*/


-- 3) Write a SQL query to display only the details of employees who either earn the highest salary or 
-- the lowest salary in each department from the employee table.
select * 
from
	(select *, 
    row_number() over (partition by dept_name order by max(salary)) as max_salary, 
    row_number() over (partition by dept_name order by min(salary)) as min_salary 
    from employee e) x
where x.max_salary = max(salary) and x.min_salary = min(salary);

/*
select x.*
from employee e
join (select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee) x
on e.emp_id = x.emp_id
and (e.salary = x.max_salary or e.salary = x.min_salary)
order by x.dept_name, x.salary;
*/




