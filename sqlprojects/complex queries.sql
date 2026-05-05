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

-- maximum salary by department  
select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e;
-- with over() we create a window of records


-- fetch the first 2 employees from each department to join the company
/*select e.*,
row_number() over(partition by dept_name order by emp_id) as rn
from employee e; */

select * from 
    (select e.*,
    row_number() over(partition by dept_name order by emp_id) as rn
    from employee e) x
where x.rn < 3;


-- fetch the top 3 employees in each department earning the maximum salary 
select * from 
    (select e.*,
    rank() over(partition by dept_name order by salary desc) as rnk
    from employee e) x
where x.rnk < 4;


-----
select * from 
    (select e.*,
    rank() over(partition by dept_name order by salary desc) as rnk
    dense_rank() over(partition by dept_name order by salary desc) as drnk
    row() over(partition by dept_name order by salary desc) as rn
    from employee e) x
;

-- fetch a query to display if the salary of an  employy is higher, lower or equal to the previous employee
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary
lead(salary) over(partition by dept_name order by emp_id) as next_emp_salary
from employee e;


select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
    when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
    when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same as than previous employee'
end sal_range
from employee e;
