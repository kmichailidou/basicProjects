
-- the query extracts all the records with an extra column called max_salary
-- which the maximum salary has been calculated from all employees
select e.*, max(salary) over() as max_salary from employees e;