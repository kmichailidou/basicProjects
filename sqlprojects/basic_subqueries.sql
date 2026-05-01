# all questions are from w3resource.com

-- 1 From the following table, write a SQL query to find those employees who receive a higher salary than the employee with ID 163. Return first name, last name.
select FIRST_NAME, LAST_NAME from employees 
where SALARY > (select * from employees where EMPLOYEE_ID = 163);


-- 2 From the following table, write a SQL query to find out which employees have the same designation as the employee whose ID is 169. Return first name, last name, department ID and job ID.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, JOB_ID from employees 
where DEPARTMENT_ID = (select * from employees where EMPLOYEE_ID = 169);

/*
where JOB_ID = ....
*/


-- 3 From the following table, write a SQL query to find those employees whose salary matches the lowest salary of any of the departments. Return first name, last name and department ID.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees 
where SALARY = (select min(SALARY) from employees); 

/*
where SALARY IN ... 
*/


-- 4 From the following table, write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME from employees 
where SALARY in (select avg(SALARY) from employees);

/*
where SALARY >
*/


-- 5 From the following table, write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY from employees 
where EMPLOYEE_ID in (select * from employees where FIRST_NAME like "Payam%");

/*
where MANAGER_ID = (select * from employees where FIRST_NAME = 'Payam');
*/


-- 6 From the following tables, write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.
select b.DEPARTMENT_ID, b.DEPARTMENT_NAME, a.FIRST_NAME, a.JOB_ID 
from employees a
inner join departments b 
where a.EMPLOYEE_ID in (select * from department where DEPARTMENT_NAME = 'Finance');

/*
from employees a, departments b 
where a.DEPARTMENT_ID = b.DEPARTMENT_ID 
and b.DEPARTMENT_NAME = 'Finance';
*/


-- 7 From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fields.
select * from employees
where SALARY in(select * from employees where EMPLOYEE_ID = 121 and SALARY = 3000);

/*
select * from employees
where (SALARY, MANAGER_ID) = (select 3000, 121)  
*/


-- 8 From the following table, write a SQL query to find those employees whose ID matches any of the numbers 134, 159 and 183. Return all the fields.  
select * from employees 
where EMPLOYEE_ID = 134 or EMPLOYEE_ID = 159 or EMPLOYEE_ID = 183;

/*
where EMPLOYEE_ID in(134,159,183) 
*/


-- 9 From the following table, write a SQL query to find those employees whose salary is in the range of 1000, and 3000 (Begin and end values have included.). Return all the fields.
select * from employees 
where SALARY between 1000 and 3000; 

/*
where SALARY between (select 1000) and 3000; 
*/


-- 10 From the following table and write a SQL query to find those employees whose salary falls within the range of the smallest salary and 2500. Return all the fields.
select * from employees 
where SALARY in(min(SALARY), 2500);

/*
where SALARY between(select min(SALARY) from employees) and 2500;
*/


-- 11 From the following tables, write a SQL query to find those employees who do not work in the departments where managers’ IDs are between 100 and 200 (Begin and end values are included.). Return all the fields of the employeess.
select * from employees 
where MANAGER_ID between (select 100) and (select 200) ;

/*
where DEPARTMENT_ID not in
(select DEPARTMENT_ID from departments where MANAGER_ID between 100 and 200);
*/


-- 12 From the following table, write a SQL query to find those employees who get second-highest salary. Return all the fields of the employees.
select * from employees 
where SALARY in (select * from employees where max(SALARY) - SALARY); 

/*
where EMPLOYEE_ID in
	(select EMPLOYEE_ID from employees 
	where SALARY = (select max(SALARY) from employees where SALARY 
		< (select max(SALARY) from employees)
	)
);
*/


-- 13 From the following tables, write a SQL query to find those employees who work in the same department as ‘Clara’. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.
select FIRST_NAME, LAST_NAME, HIRE_DATE from employees
where FIRST_NAME like 'Clara%' and
	(select EMPLOYEE_ID from employees where FIRST_NAME not like 'Clara%'); 

/*
where DEPARTMENT_ID = 
	(select DEPARTMENT_ID from employees where FIRST_NAME = 'Clara')
and FIRST_NAME <> 'Clara';
*/


-- 14 From the following tables, write a SQL query to find those employees who work in a department where the employee’s first name contains the letter 'T'. Return employee ID, first name and last name.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME from employees
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where FIRST_NAME like '%T%');


-- 15 From the following tables, write a SQL query to find those employees who earn more than the average salary and work in the same department as an employee whose first name contains the letter 'J'. Return employee ID, first name and salary.
select EMPLOYEE_ID, FIRST_NAME, SALARY from employees
where SALARY = (select SALARY from employees where avg(SALARY) < SALARY)
and FIRST_NAME like '%J%'; 

/*
where SALARY > (select avg(SALARY) from employees) 
and DEPARTMENT_ID in (select DEPARTMENT_ID from employees where FIRST_NAME like '%J%'); 
*/


-- 16 From the following table, write a SQL query to find those employees whose department is located at ‘Toronto’. Return first name, last name, employee ID, job ID.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees, location
where DEPARTMENT_ID in (select DEPARTMENT_ID from departments) 
and LOCATION_ID in(select CITY from location where CITY = 'Toronto');

/*
from employees (without location being mentioned in this field)
where DEPARTMENT_ID = (... where LOCATION_ID = (select LOCATION_ID from location where CITY = 'Toronto');
*/


-- 17 From the following table, write a SQL query to find those employees whose salary is lower than that of employees whose job title is ‘MK_MAN’. Return employee ID, first name, last name, job ID.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary < (select JOB_ID from employees where JOB_ID = 'MK_MAN');

/*
where salary < ANY (select SALARY from employees where JOB_ID = 'MK_MAN');
*/ 


-- 18 From the following table, write a SQL query to find those employees whose salary is lower than that of employees whose job title is "MK_MAN". Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name, last name, job ID.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary < ANY 
	(select SALARY from employees where JOB_ID = 'MK_MAN' 
    and (select JOB_ID from employees where JOB_ID != 'MK_MAN')
    );

/*
and JOB_ID <> 'MK_MAN';
*/


-- 19 From the following table, write a SQL query to find those employees whose salary exceeds the salary of all those employees whose job title is "PU_MAN". Exclude job title ‘PU_MAN’. Return employee ID, first name, last name, job ID.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary > (select JOB_ID from employees where JOB_ID = 'PU_MAN')
and JOB_ID <> 'PU_MAN'; 

/*
where salary > all ... 
*/


-- 20 From the following table, write a SQL query to find those employees whose salaries are higher than the average for all departments. Return employee ID, first name, last name, job ID.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees
where SALARY > (select avg(SALARY) from employees); 

/*
where SALARY > all (select avg(SALARY) from employees group_by DEPARTMENT_ID);
*/ 


-- 21 From the following table, write a SQL query to check whether there are any employees with salaries exceeding 3700. Return first name, last name and department ID.
select FIRST_NAME, LAST_NAME,DEPARTMENT_ID from employees
where EMPLOYEE_ID in (select EMPLOYEE_ID from employees where SALARY > 3700);

/*
where exists (select * from employees where SALARY >3700);
*/


-- 22 From the following table, write a SQL query to calculate total salary of the departments where at least one employee works. Return department ID, total salary.
select b.DEPARTMENT_ID, sum(a.SALARY) from employees a, departments b
where a.EMPLOYEE_ID = (select * from employees a);

/*
select a.DEPARTMENT_ID, result1.TOTAL_AMT from departments a,
(select a.DEPARTMENT_ID, sum(a.SALARY) TOTAL_AMT from employees b group by a.DEPARTMENT_ID) result1
where result1.DEPARTMENT_ID = a.DEPARTMENT_ID 
*/


-- 23 Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID  from employees 
where EMPLOYEE_ID in (select EMPLOYEE_ID from employees 
						where JOB_ID = 'ST_MAN' as SALESMAN and JOB_ID = 'IT_PROG' as DEVELOPER);
                        
/*
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,   
case JOB_ID
	when 'ST_MAN' then 'SALESMAN'
    when 'IT_PROG' then 'DEVELOPER'
    else JOB_ID
end as designation, 
SALARY from employees ; 

*/


-- 24 Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,  
case SALARY
	when SALARY < avg(SALARY) then 'LOW' 
    else 'HIGH'
end as SalaryStatus
from employees ;


/*
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY,
case 
	when SALARY >= (select avg(SALARY) from employees) then 'HIGH'
    else 'LOW'
end as SalaryStatus
from employees;
*/


-- 25 Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, avg(SALARY) as AvgCompare,
case 
	when SALARY >= (select avg(SALARY) from employees) then 'HIGH'
    else 'LOW'
end as SalaryStatus
from employees;

/*
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY as SalaryDrawn,
round((SALARY - (select avg(SALARY) from employees)), 2) as AvgCompare,
case ... 
from ...
*/


-- 26 From the following table, write a SQL query to find all those departments where at least one employee is employed. Return department name.
select * from departments 
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where EMPLOYEE_ID > 1); 

/*
select DEPARTMENT_NAME from departments
where ... (select distinct (DEPARTMENT_ID) from employees);
*/


-- 27 From the following tables, write a SQL query to find employees who work in departments located in the United Kingdom. Return first name.
select FIRST_NAME from employees 
where EMPLOYEE_ID in
	(select DEPARTMENT_NAME from departments where LOCATION_ID in 
		(select LOCATION_ID from locations where COUNTRY_ID in
			(select COUNTRY_ID from country where COUNTRY_NAME = 'United Kingdom')));

/*
where DEPARTMENT_ID in 
	(select DEPARTMENT_ID from departments where ...
		(... where COUNTRY_ID = 
			(...))); 
*/


-- 28 From the following table, write a SQL query to find out which employees are earning more than the average salary and who work in any of the IT departments. Return last name.
select LAST_NAME from employees 
where SALARY > avg(SALARY) 
and DEPARTMENT_NAME in (select DEPARTMENT_NAME from departments where DEPARTMENT_NAME = 'IT');

/*
where DEPARTMENT_ID in (select DEPARTMENT_ID from departments where DEPARTMENT_NAME like 'IT%')
and SALARY > (select avg(SALARY) from employees); 
*/
 

-- 29 From the following table, write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. Sort the result in ascending order by last name. Return first name, last name and salary.
select FIRST_NAME, LAST_NAME, SALARY from employees 
where EMPLOYEE_ID in (select EMPLOYEE_ID from employees where LAST_NAME = 'Ozer')
order by LAST_NAME asc; 

/*
where SALARY > (select SALARY from employees where LAST_NAME = 'Ozer')
... ;
*/


-- 30 From the following tables, write a SQL query find the employees who report to a manager based in the United States. Return first name, last name.
select FIRST_NAME, LAST_NAME from employees 
where MANAGER_ID in
	(select MANAGER_ID from departments where LOCATION_ID in
		(select LOCATION_ID from locations where CITY = 'United States'));
        
/*
... (select EMPLOYEE_ID from employees where DEPARTMENT_ID in 
		(select DEPARTMENT_ID from departments where LOCATION_ID in 
			(select ... where COUNTRY_ID = 'US')));
*/


-- 31 From the following tables, write a SQL query to find those employees whose salaries exceed 50% of their department's total salary bill. Return first name, last name.
select FIRST_NAME, LAST_NAME from employees 
where SALARY > (select SALARY from employees where sum(SALARY) < (50/100)); 

/*
select e1.FIRST_NAME, e1.LAST_NAME from employees e1
where SALARY > (select sum(SALARY)) * 0.5  from employees e2 where e1.DEPARTMENT_ID = e2.DEPARTMENT_ID); 
*/ 


-- 32 From the following tables, write a SQL query to find those employees who are managers. Return all the fields of employees table.
select * from employees 
where EMPLOYEE_ID in (select * from employees where EMPLOYEE_ID = MANAGER_ID);

/*
(select distinct MANAGER_ID from employees);
*/


-- 33 From the following table, write a SQL query to find those employees who manage a department. Return all the fields of employees table.
select * from employees
where EMPLOYEE_ID in (select * from employees where EMPLOYEE_ID = MANAGER_ID); 

/*
where EMPLOYEE_ID = any(select MANAGER_ID = from departments);
*/  


-- 34 From the following table, write a SQL query to search for employees who receive such a salary, which is the maximum salary for salaried employees, hired between January 1st, 2002 and December 31st, 2003. Return employee ID, first name, last name, salary, department name and city.
select a.EMPLOYEE_ID, a.FIRST_NAME, a.LAST_NAME, a.SALARY, b.DEPARTMENT_NAME, c.CITY 
from employees a, departments b, locations c 
where a.EMPLOYEE_ID = 
	(select a.EMPLOYEE_ID, max(a.SALARY) from employees a where a.HIRE_DATE between 2002-01-01 and 2003-12-31);
    
/*
where a.SALARY = 
	(select max(SALARY) from employees where HIRE_DATE between 2002-01-01 and 2003-12-31)
and a.DEPARTMENT_ID = b.DEPARTMENT_ID
and b.LOCATION_ID = c.LOCATION_ID;
*/


-- 35 From the following tables, write a SQL query to find those departments that are located in the city of London. Return department ID, department name.
select DEPARTMENT_ID, DEPARTMENT_NAME from departments 
where DEPARTMENT_ID = (select CITY from locations where CITY = 'London'); 

/*
where LOCATION_ID = (select LOCATION_ID from locations where CITY = 'London'); 
*/


-- 36 From the following table, write a SQL query to find those employees who earn more than the average salary. Sort the result-set in descending order by salary. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees
where SALARY > (select avg(SALARY) from employees)
order by SALARY desc;


-- 37 From the following table, write a SQL query to find those employees who earn more than the maximum salary for a department of ID 40. Return first name, last name and department ID.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees
where SALARY > (select max(SALARY) from employees) 
and DEPARTMENT_ID = 40;

/*
where SALARY > all (select SALARY from employees where DEPARTMENT_ID = 40);
*/


-- 38 From the following table, write a SQL query to find departments for a particular location. The location matches the location of the department of ID 30. Return department name and department ID.
select DEPARTMENT_ID, DEPARTMENT_NAME from departments
where LOCATION_ID = (select LOCATION_ID from departments where DEPARTMENT_ID = 30);


-- 39 From the following table, write a SQL query to find employees who work for the department in which employee ID 201 is employed. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where EMPLOYEE_ID = 201);

/*
where DEPARTMENT_ID = ... 
*/


-- 40 From the following table, write a SQL query to find those employees whose salary matches that of the employee who works in department ID 40. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY = (select SALARY from employees where EMPLOYEE_ID = 40);

/*
where SALARY in ...

(so matches is in)   
*/ 


-- 41 From the following table, write a SQL query to find those employees who work in the department 'Marketing'. Return first name, last name and department ID.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees 
where DEPARTMENT_ID in(select DEPARTMENT_ID from departments where DEPARTMENT_NAME = 'Marketing'); 

/*
where DEPARTMENT_ID = ... 
*/


-- 42 From the following table, write a SQL query to find those employees who earn more than the minimum salary of a department of ID 40. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY > (select min(SALARY) from employees where DEPARTMENT_ID = 40);

/*
where SALARY > any ...
*/


-- 43 From the following table, write a SQL query to find those employees who joined after the employee whose ID is 165. Return first name, last name and hire date.
select FIRST_NAME, LAST_NAME, HIRE_DATE from employees
where EMPLOYEE_ID = (select EMPLOYEE_ID from employees where EMPLOYEE_ID = 165);

/*
select FIRST_NAME || ' ' || LAST_NAME as Full_Name, HIRE_DATE from employees
where HIRE_DATE > (select HIRE_DATE ...);
*/


-- 44 From the following table, write a SQL query to find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY < (select min(SALARY) from employees where DEPARTMENT_ID = 70);

/*
where SALARY < all (select SALARY from employees where DEPARTMENT_ID = 70);

*/


-- 45 From the following table, write a SQL query to find those employees who earn less than the average salary and work at the department where Laura (first name) is employed. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY < (select avg(SALARY) from employees)
and FIRST_NAME = 'Laura'; 

/*
and DEPARTMENT_ID = (select DEPARTMENT_ID from employees where FIRST_NAME = 'Laura');
*/


-- 46 From the following tables, write a SQL query to find all employees whose department is located in London. Return first name, last name, salary, and department ID.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where DEPARTMENT_ID =
	(select DEPARTMENT_ID from departments where LOCATION_ID =
		(select LOCATION_ID from locations where CITY = 'London'));

/*
where DEPARTMENT_ID in 
*/


-- 47 From the following tables, write a SQL query to find the city of the employee of ID 134. Return city.
select CITY from locations 
where LOCATION_ID =	
	(select LOCATION_ID from departments where DEPARTMENT_ID =
		(select DEPARTMENT_ID from employees where EMPLOYEE_ID = 134)
	);


-- 48 From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. Return all the fields of the departments.
select * from departments 
where DEPARTMENT_ID = 
	(select DEPARTMENT_ID from employees where max(SALARY) > 7000 and EMPLOYEE_ID = 
		(select EMPLOYEE_ID from job_history where JOB_ID )
    );

/*
where DEPARTMENT_ID in 
	(select ... where EMPLOYEE_ID in 
		(select EMPLOYEE_ID from job_history 
        group by EMPLOYEE_ID having count(EMPLOYEE_ID) > 1) 
	group by DEPARTMENT_ID having max(SALARY) > 7000);
*/


-- 49 From the following tables, write a SQL query to find those departments where the starting salary is at least 8000. Return all the fields of departments.
select * from departments
where DEPARTMENT_ID = 
	(select DEPARTMENT_ID from employees where min(SALARY) = 8000); 
    
/*
where DEPARTMENT_ID in
	(select DEPARTMENT_ID from employees group by DEPARTMENT_ID having min(SALARY) >= 8000);

*/


-- 50 From the following table, write a SQL query to find those managers who supervise four or more employees. Return manager name, department ID.
select (FIRST_NAME, LAST_NAME) as 'maanger_name',  DEPARTMENT_ID from employees
where MANAGER_ID = (select MANAGER_ID from employees) ;

/*
select FIRST_NAME || ' ' || LAST_NAME as 'maanger_name',  DEPARTMENT_ID from employees
where EMPLOYEE_ID in (select MANAGER_ID from employees group by MANAGER_ID having count(*) >= 4); 
*/


-- 51 From the following table, write a SQL query to find employees who have previously worked as 'Sales Representatives'. Return all the fields of jobs.
select * from jobs 
where JOB_TITLE = 'Sales Representative' and JOB_ID = 
	(select JOB_ID from employees where DEPARTMENT_ID = 
		(select DEPARTMENT_ID from job_history)
	);

/*
where JOB_ID in
	(select JOB_ID from employees where EMPLOYEE_ID in 
		(select EMPLOYEE_ID from job_history where JOB_ID = 'SA_REP')
	);
*/


-- 52 From the following table, write a SQL query to find those employees who earn the second-lowest salary of all the employees. Return all the fields of employees.
select * from employees 
where EMPLOYEE_ID = 
	(select EMPLOYEE_ID from employees where SALARY > min(SALARY) ); 

/*
from employees m 
where 2 = (select count(distinct SALARY) from employees where SALARY <=m.SALARY);
*/


-- 53 From the following table, write a SQL query to find the departments managed by Susan. Return all the fields of departments.
select * from departments 
where DEPARTMENT_ID = (select DEPARTMENT_ID from employees where FIRST_NAME = 'Susan');

/*
where MANAGER_ID in (select EMPLOYEE_ID from employees where FIRST_NAME = 'Susan');
*/


-- 54 From the following table, write a SQL query to find those employees who earn the highest salary in a department. Return department ID, employee name, and salary.
select DEPARTMENT_ID, FIRST_NAME || ' ' || LAST_NAME as 'employee_name', SALARY from employees
where EMPLOYEE_ID = (select EMPLOYEE_ID from employees group by DEPARTMENT_ID having max(SALARY)); 

/*
from employees a
where SALARY = (select max(SALARY) from employees where DEPARTMENT_ID = a.DEPARTMENT_ID);
*/


-- 55 From the following table, write a SQL query to find those employees who have not had a job in the past. Return all the fields of employees.
select * from employees 
where EMPLOYEE_ID = 
	(select EMPLOYEE_ID from job_history where (START_DATE and END_DATE) not between 1995-01-01 and 2007-31-12);

/*
where EMPLOYEE_ID not in (select EMPLOYEE_ID from job_history);
*/


