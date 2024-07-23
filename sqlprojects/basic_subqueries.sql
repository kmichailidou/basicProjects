# all questions are from w3resource.com

-- 1
select FIRST_NAME, LAST_NAME from employees 
where SALARY > (select * from employees where EMPLOYEE_ID = 1);


-- 2
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, JOB_ID from employees 
where DEPARTMENT_ID = (select * from employees where EMPLOYEE_ID = 169);

/*
where JOB_ID = ....
*/


-- 3
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees 
where SALARY = (select min(SALARY) from employees); 

/*
where SALARY IN ... 
*/


-- 4
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME from employees 
where SALARY in (select avg(SALARY) from employees);

/*
where SALARY >
*/


-- 5
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY from employees 
where EMPLOYEE_ID in (select * from employees where FIRST_NAME like "Payam%");

/*
where MANAGER_ID = (select * from employees where FIRST_NAME = 'Payam');
*/


-- 6
select b.DEPARTMENT_ID, b.DEPARTMENT_NAME, a.FIRST_NAME, a.JOB_ID 
from employees a
inner join departments b 
where a.EMPLOYEE_ID in (select * from department where DEPARTMENT_NAME = 'Finance');

/*
from employees a, departments b 
where a.DEPARTMENT_ID = b.DEPARTMENT_ID 
and b.DEPARTMENT_NAME = 'Finance';
*/


-- 7
select * from employees
where SALARY in(select * from employees where EMPLOYEE_ID = 121 and SALARY = 3000);

/*
select * from employees
where (SALARY, MANAGER_ID) = (select 3000, 121)  
*/


-- 8
select * from employees 
where EMPLOYEE_ID = 134 or EMPLOYEE_ID = 159 or EMPLOYEE_ID = 183;

/*
where EMPLOYEE_ID in(134,159,183) 
*/


-- 9
select * from employees 
where SALARY between 1000 and 3000; 

/*
where SALARY between (select 1000) and 3000; 
*/


-- 10
select * from employees 
where SALARY in(min(SALARY), 2500);

/*
where SALARY between(select min(SALARY) from employees) and 2500;
*/


-- 11 
select * from employees 
where MANAGER_ID between (select 100) and (select 200) ;

/*
where DEPARTMENT_ID not in
(select DEPARTMENT_ID from departments where MANAGER_ID between 100 and 200);
*/


-- 12 
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


-- 13
select FIRST_NAME, LAST_NAME, HIRE_DATE from employees
where FIRST_NAME like 'Clara%' and
	(select EMPLOYEE_ID from employees where FIRST_NAME not like 'Clara%'); 

/*
where DEPARTMENT_ID = 
	(select DEPARTMENT_ID from employees where FIRST_NAME = 'Clara')
and FIRST_NAME <> 'Clara';
*/


-- 14
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME from employees
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where FIRST_NAME like '%T%');


-- 15
select EMPLOYEE_ID, FIRST_NAME, SALARY from employees
where SALARY = (select SALARY from employees where avg(SALARY) < SALARY)
and FIRST_NAME like '%J%'; 

/*
where SALARY > (select avg(SALARY) from employees) 
and DEPARTMENT_ID in (select DEPARTMENT_ID from employees where FIRST_NAME like '%J%'); 
*/


-- 16
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees, location
where DEPARTMENT_ID in (select DEPARTMENT_ID from departments) 
and LOCATION_ID in(select CITY from location where CITY = 'Toronto');

/*
from employees (without location being mentioned in this field)
where DEPARTMENT_ID = (... where LOCATION_ID = (select LOCATION_ID from location where CITY = 'Toronto');
*/


-- 17
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary < (select JOB_ID from employees where JOB_ID = 'MK_MAN');

/*
where salary < ANY (select SALARY from employees where JOB_ID = 'MK_MAN');
*/ 


-- 18
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary < ANY 
	(select SALARY from employees where JOB_ID = 'MK_MAN' 
    and (select JOB_ID from employees where JOB_ID != 'MK_MAN')
    );

/*
and JOB_ID <> 'MK_MAN';
*/


-- 19
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees 
where salary > (select JOB_ID from employees where JOB_ID = 'PU_MAN')
and JOB_ID <> 'PU_MAN'; 

/*
where salary > all ... 
*/


-- 20
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID from employees
where SALARY > (select avg(SALARY) from employees); 

/*
where SALARY > all (select avg(SALARY) from employees group_by DEPARTMENT_ID);
*/ 


-- 21
select FIRST_NAME, LAST_NAME,DEPARTMENT_ID from employees
where EMPLOYEE_ID in (select EMPLOYEE_ID from employees where SALARY > 3700);

/*
where exists (select * from employees where SALARY >3700);
*/


-- 22
select b.DEPARTMENT_ID, sum(a.SALARY) from employees a, departments b
where a.EMPLOYEE_ID = (select * from employees a);

/*
select a.DEPARTMENT_ID, result1.TOTAL_AMT from departments a,
(select a.DEPARTMENT_ID, sum(a.SALARY) TOTAL_AMT from employees b group by a.DEPARTMENT_ID) result1
where result1.DEPARTMENT_ID = a.DEPARTMENT_ID 
*/


-- 23
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


-- 24
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


-- 25
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


-- 26
select * from departments 
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where EMPLOYEE_ID > 1); 

/*
select DEPARTMENT_NAME from departments
where ... (select distinct (DEPARTMENT_ID) from employees);
*/


-- 27
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


-- 28
select LAST_NAME from employees 
where SALARY > avg(SALARY) 
and DEPARTMENT_NAME in (select DEPARTMENT_NAME from departments where DEPARTMENT_NAME = 'IT');

/*
where DEPARTMENT_ID in (select DEPARTMENT_ID from departments where DEPARTMENT_NAME like 'IT%')
and SALARY > (select avg(SALARY) from employees); 
*/
 

-- 29
select FIRST_NAME, LAST_NAME, SALARY from employees 
where EMPLOYEE_ID in (select EMPLOYEE_ID from employees where LAST_NAME = 'Ozer')
order by LAST_NAME asc; 

/*
where SALARY > (select SALARY from employees where LAST_NAME = 'Ozer')
... ;
*/


-- 30
select FIRST_NAME, LAST_NAME from employees 
where MANAGER_ID in
	(select MANAGER_ID from departments where LOCATION_ID in
		(select LOCATION_ID from locations where CITY = 'United States'));
        
/*
... (select EMPLOYEE_ID from employees where DEPARTMENT_ID in 
		(select DEPARTMENT_ID from departments where LOCATION_ID in 
			(select ... where COUNTRY_ID = 'US')));
*/


-- 31
select FIRST_NAME, LAST_NAME from employees 
where SALARY > (select SALARY from employees where sum(SALARY) < (50/100)); 

/*
select e1.FIRST_NAME, e1.LAST_NAME from employees e1
where SALARY > (select sum(SALARY)) * 0.5  from employees e2 where e1.DEPARTMENT_ID = e2.DEPARTMENT_ID); 
*/ 


-- 32
select * from employees 
where EMPLOYEE_ID in (select * from employees where EMPLOYEE_ID = MANAGER_ID);

/*
(select distinct MANAGER_ID from employees);
*/


-- 33
select * from employees
where EMPLOYEE_ID in (select * from employees where EMPLOYEE_ID = MANAGER_ID); 

/*
where EMPLOYEE_ID = any(select MANAGER_ID = from departments);
*/  


-- 34
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


-- 35
select DEPARTMENT_ID, DEPARTMENT_NAME from departments 
where DEPARTMENT_ID = (select CITY from locations where CITY = 'London'); 

/*
where LOCATION_ID = (select LOCATION_ID from locations where CITY = 'London'); 
*/


-- 36
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees
where SALARY > (select avg(SALARY) from employees)
order by SALARY desc;


-- 37
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees
where SALARY > (select max(SALARY) from employees) 
and DEPARTMENT_ID = 40;

/*
where SALARY > all (select SALARY from employees where DEPARTMENT_ID = 40);
*/


-- 38
select DEPARTMENT_ID, DEPARTMENT_NAME from departments
where LOCATION_ID = (select LOCATION_ID from departments where DEPARTMENT_ID = 30);


-- 39
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where DEPARTMENT_ID in (select DEPARTMENT_ID from employees where EMPLOYEE_ID = 201);

/*
where DEPARTMENT_ID = ... 
*/


-- 40
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY = (select SALARY from employees where EMPLOYEE_ID = 40);

/*
where SALARY in ...

(so matches is in)   
*/ 


-- 41
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from employees 
where DEPARTMENT_ID in(select DEPARTMENT_ID from departments where DEPARTMENT_NAME = 'Marketing'); 

/*
where DEPARTMENT_ID = ... 
*/


-- 42 
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY > (select min(SALARY) from employees where DEPARTMENT_ID = 40);

/*
where SALARY > any ...
*/


-- 43
select FIRST_NAME, LAST_NAME, HIRE_DATE from employees
where EMPLOYEE_ID = (select EMPLOYEE_ID from employees where EMPLOYEE_ID = 165);

/*
select FIRST_NAME || ' ' || LAST_NAME as Full_Name, HIRE_DATE from employees
where HIRE_DATE > (select HIRE_DATE ...);
*/


-- 44
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY < (select min(SALARY) from employees where DEPARTMENT_ID = 70);

/*
where SALARY < all (select SALARY from employees where DEPARTMENT_ID = 70);

*/


-- 45
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where SALARY < (select avg(SALARY) from employees)
and FIRST_NAME = 'Laura'; 

/*
and DEPARTMENT_ID = (select DEPARTMENT_ID from employees where FIRST_NAME = 'Laura');
*/


-- 46
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from employees 
where DEPARTMENT_ID =
	(select DEPARTMENT_ID from departments where LOCATION_ID =
		(select LOCATION_ID from locations where CITY = 'London'));

/*
where DEPARTMENT_ID in 
*/


-- 47
select CITY from locations 
where LOCATION_ID =	
	(select LOCATION_ID from departments where DEPARTMENT_ID =
		(select DEPARTMENT_ID from employees where EMPLOYEE_ID = 134)
	);


-- 48
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


-- 49
select * from departments
where DEPARTMENT_ID = 
	(select DEPARTMENT_ID from employees where min(SALARY) = 8000); 
    
/*
where DEPARTMENT_ID in
	(select DEPARTMENT_ID from employees group by DEPARTMENT_ID having min(SALARY) >= 8000);

*/


-- 50
select (FIRST_NAME, LAST_NAME) as 'maanger_name',  DEPARTMENT_ID from employees
where MANAGER_ID = (select MANAGER_ID from employees) ;

/*
select FIRST_NAME || ' ' || LAST_NAME as 'maanger_name',  DEPARTMENT_ID from employees
where EMPLOYEE_ID in (select MANAGER_ID from employees group by MANAGER_ID having count(*) >= 4); 
*/


-- 51 
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


-- 52
select * from employees 
where EMPLOYEE_ID = 
	(select EMPLOYEE_ID from employees where SALARY > min(SALARY) ); 

/*
from employees m 
where 2 = (select count(distinct SALARY) from employees where SALARY <=m.SALARY);
*/


-- 53
select * from departments 
where DEPARTMENT_ID = (select DEPARTMENT_ID from employees where FIRST_NAME = 'Susan');

/*
where MANAGER_ID in (select EMPLOYEE_ID from employees where FIRST_NAME = 'Susan');
*/


-- 54
select DEPARTMENT_ID, FIRST_NAME || ' ' || LAST_NAME as 'employee_name', SALARY from employees
where EMPLOYEE_ID = (select EMPLOYEE_ID from employees group by DEPARTMENT_ID having max(SALARY)); 

/*
from employees a
where SALARY = (select max(SALARY) from employees where DEPARTMENT_ID = a.DEPARTMENT_ID);
*/


-- 55
select * from employees 
where EMPLOYEE_ID = 
	(select EMPLOYEE_ID from job_history where (START_DATE and END_DATE) not between 1995-01-01 and 2007-31-12);

/*
where EMPLOYEE_ID not in (select EMPLOYEE_ID from job_history);
*/


