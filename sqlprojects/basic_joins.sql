-- Allquestions are in w3resource.com

/* 
SELECT salesman.name, customer.cust_name, customer.city
FROM salesman 
JOIN customer ON salesman.salesman_id = customer.customer_id 
WHERE salesman.city = customer.city;
*/

-- 1
SELECT salesman.name, customer.cust_name, customer.city
FROM salesman, customer
WHERE salesman.city = customer.city;

-- 2
select orders.ord_no, orders.purch_amt, customer.cust_name, customer.city
from orders, customer
where orders.customer_id = customer.customer_id 
and orders.purch_amt between 500 and 2000; 

-- 3
select customer.cust_name, customer.city, salesman.name, salesman.commission
from customer 
inner join salesman 
on customer.salesman_id = salesman.salesman_id;

-- 4
select customer.cust_name, customer.city, salesman.`name`, salesman.commission
from customer 
inner join salesman on customer.salesman_id = salesman.salesman_id 
where salesman.commission > 0.12;


-- 5
select a.`name`, a.city, b.`name`, b.city, b.commission
from customers a 
inner join salesman b 
on a.salesman_id = b.salesman_id
where a.city <> b.city and b.commission > 0.12;

-- 6
select a.ord_no, a.ord_`date`, a.purch_amt, b.customer, b.grade, c.commission
from orders a 
inner join customer b on a.customer_id = b.customer_id 
inner join salesman c on a.salesman_id = c.salesman_id; 


-- select a.* , b.*, c.*
-- from orders a 
-- inner join customers b on a.customer_id = b.customer_id 
-- inner join salesman c on a.salesman_id = c.salesman_id;

-- 7
select * from orders 
natural join customer
natural join salesman; 
-- natural join compares all comuns of the two joined tables and 
-- only returns the rows where the values match 

-- 8 
select a.cust_name, a.city, a.grade, b.`name`, b.city
from customer a 
left join salesman b on a.salesman_id = b.salesman_id 
order by a.customer_id asc;


-- 9
select a.cust_name, a.city, a.grade, b.`name`, b.city 
from customer a
left outer join salesman b on a.salesman = b.salesman_id 
where a.grade < 300 
order by a.customer_id asc;


-- 10
select a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt
from customers a 
left outer join orders b on a.customer_id = b.customer_id 
order by purch_amt asc; 
 

-- 11
select a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt, c.`name`, c.commission 
from customer a 
left outer join orders b on a.customer_id = b.customer_id 
left outer join salesman c on a.salesman_id = c.salesman_id ;


-- 12
select * from customer a
left join salesman on a.salseman_id = b.salesman_id 
order by salesman asc;
-- select a.cust_name, a.city, a.grade, b.name, b.city 
-- right outer join salesman b on b.salesman_id = a.salesman_id


-- 13
select a.cust_name, a.city, a.grade, b.`name`, c.ord_no, c.ord_date, c.purch_amt
from customer a 
right outer join salesman b on b.salesman_id = a.salesman_id 
right outer join orders c on c.customer_id = a.customer_id ; 


-- 14 
select a.cust_name, a.city, a.grade, b.`name`, c.ord_no, c.ord_date, c.purch_amt
from customer a 
right outer join salesman b on b.salesman_id = a.salesman_id 
right outer join orders c on c.customer_id = a.customer_id 
where c.purch_amt > 2000 and a.grade > 0 ;  

/*
left outer join orders c on c.customer_id = a.customer_id 
where ... and a.grade is not null; 
*/


-- 15
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from customer a 
right outer join orders b on c.customer_id = a.customer_id 
where c.purch_amt > 0 and a.grade is not null ;  

/*
left outer join orders b on a.customer_id = b.customer_id ;
(without where clause) 
*/


-- 16
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from customer a 
right outer join orders b on c.customer_id = a.customer_id
where a.grade > 0 and b.ord_no is not null; 

/*
select (all of the incorrect query without a.grade) 
full outer join orders b on a.customer_id = b.customer_id
where a.grade > is not null; 
*/


-- 17
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from salesman a 
full outer join customer b on a.customer_id = b.customer_id ; 

/*
select * from salesman a 
cross join customer.b 
*/


-- 18 
select * from salesman a
cross join customer b
where a.city is not null;


-- 19
select * from salesman a
cross join customer b
where a.city is not null and b.grade is not null; 


-- 20 
select * from salesman a
cross join customer b
where a.city is not null 
and a.city <> b.city
and b.grade is not null;  


-- 21
select * from company_mast a
cross join item_mast b ;

/*
select * from item_mast 
inner join company_mast
on item_mass.PRO_COM = company_mast.COM_ID; 
*/


-- 22
select a.PRO_NAME, a.PRO_PRICE, b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID; 


-- 23
select avg(PRO_ID), b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID; 

/*
select avg(b.PRO_PRICE),...
group by b.COM_NAME;
*/


-- 24
select avg(a.PRO_PRICE), b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID
where a.PRO_PRICE >= 350
group by b.COM_NAME; 
 
/*
(without the where clause, just having)
having avg(b.PRO_PRICE) >= 350; 
*/


-- 25
select max(a.PRO_PRICE), a.PRO_NAME, b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID
group by b.COM_NAME; 

/*
select a.PRO_PRICE, ...
(subquery, after on keyword)
and a.PRO_PRICE = 
	(select max(a.PRO_PRICE) from item where a.PRO_COM = b.COM_ID);

*/


-- 26
select * from emp_details a
inner join epm_department b
on a.EMP_DEPT = b.DPT_CODE;


-- 27
select a.DPT_NAME, a.DPT_ALLOTMENT, b.EMP_NAME, b.EMP_LNAME
from emp_details a
inner join epm_department b
on a.EMP_DEPT = b.DPT_CODE;


-- 28
select a.DPT_NAME, a.DPT_ALLOTMENT, b.EMP_NAME, b.EMP_LNAME
from emp_details a
inner join epm_department b
on a.EMP_DEPT = b.DPT_CODE
where a.DPT_ALLOTMENT > 50000;

/*
select b.EMP_NAME, b.EMP_LNAME 
from ... 
(instead of where, you'll use and operator)
and a.DPT_ALLOTMENT > 50000; 
*/


-- 29
select b.DPT_NAME
from emp_details b
inner join epm_department a
on a.EMP_DEPT = b.DPT_CODE ;

/*
group by b.DPT_NAME 
having count(*) > 2; 
*/


