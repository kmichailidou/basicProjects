-- Allquestions are in w3resource.com

/* 
SELECT salesman.name, customer.cust_name, customer.city
FROM salesman 
JOIN customer ON salesman.salesman_id = customer.customer_id 
WHERE salesman.city = customer.city;
*/

-- 1 From the following tables write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.
SELECT salesman.name, customer.cust_name, customer.city
FROM salesman, customer
WHERE salesman.city = customer.city;

-- 2 From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
select orders.ord_no, orders.purch_amt, customer.cust_name, customer.city
from orders, customer
where orders.customer_id = customer.customer_id 
and orders.purch_amt between 500 and 2000; 

-- 3 From the following tables write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.
select customer.cust_name, customer.city, salesman.name, salesman.commission
from customer 
inner join salesman 
on customer.salesman_id = salesman.salesman_id;

-- 4 From the following tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.  
select customer.cust_name, customer.city, salesman.`name`, salesman.commission
from customer 
inner join salesman on customer.salesman_id = salesman.salesman_id 
where salesman.commission > 0.12;


-- 5 From the following tables write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission.  
select a.`name`, a.city, b.`name`, b.city, b.commission
from customers a 
inner join salesman b 
on a.salesman_id = b.salesman_id
where a.city <> b.city and b.commission > 0.12;

-- 6 From the following tables write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.
select a.ord_no, a.ord_`date`, a.purch_amt, b.customer, b.grade, c.commission
from orders a 
inner join customer b on a.customer_id = b.customer_id 
inner join salesman c on a.salesman_id = c.salesman_id; 


-- select a.* , b.*, c.*
-- from orders a 
-- inner join customers b on a.customer_id = b.customer_id 
-- inner join salesman c on a.salesman_id = c.salesman_id;

-- 7 Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned. 
select * from orders 
natural join customer
natural join salesman; 
-- natural join compares all comuns of the two joined tables and 
-- only returns the rows where the values match 

-- 8 From the following tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.  
select a.cust_name, a.city, a.grade, b.`name`, b.city
from customer a 
left join salesman b on a.salesman_id = b.salesman_id 
order by a.customer_id asc;


-- 9 From the following tables write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id. 
select a.cust_name, a.city, a.grade, b.`name`, b.city 
from customer a
left outer join salesman b on a.salesman = b.salesman_id 
where a.grade < 300 
order by a.customer_id asc;


-- 10 Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.
select a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt
from customers a 
left outer join orders b on a.customer_id = b.customer_id 
order by purch_amt asc; 
 

-- 11 SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.
select a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt, c.`name`, c.commission 
from customer a 
left outer join orders b on a.customer_id = b.customer_id 
left outer join salesman c on a.salesman_id = c.salesman_id ;


-- 12 Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.
select * from customer a
left join salesman on a.salseman_id = b.salesman_id 
order by salesman asc;
-- select a.cust_name, a.city, a.grade, b.name, b.city 
-- right outer join salesman b on b.salesman_id = a.salesman_id


-- 13 From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount. Condition for selecting list of salesmen : 1. Salesmen who works for one or more customer or, 2. Salesmen who not yet join under any customer, Condition for selecting list of customer : 3. placed one or more orders, or 4. no order placed to their salesman.
select a.cust_name, a.city, a.grade, b.`name`, c.ord_no, c.ord_date, c.purch_amt
from customer a 
right outer join salesman b on b.salesman_id = a.salesman_id 
right outer join orders c on c.customer_id = a.customer_id ; 


-- 14 Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select a.cust_name, a.city, a.grade, b.`name`, c.ord_no, c.ord_date, c.purch_amt
from customer a 
right outer join salesman b on b.salesman_id = a.salesman_id 
right outer join orders c on c.customer_id = a.customer_id 
where c.purch_amt > 2000 and a.grade > 0 ;  

/*
left outer join orders c on c.customer_id = a.customer_id 
where ... and a.grade is not null; 
*/


-- 15 For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from customer a 
right outer join orders b on c.customer_id = a.customer_id 
where c.purch_amt > 0 and a.grade is not null ;  

/*
left outer join orders b on a.customer_id = b.customer_id ;
(without where clause) 
*/


-- 16 Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from customer a 
right outer join orders b on c.customer_id = a.customer_id
where a.grade > 0 and b.ord_no is not null; 

/*
select (all of the incorrect query without a.grade) 
full outer join orders b on a.customer_id = b.customer_id
where a.grade > is not null; 
*/


-- 17 Write a SQL query to combine each row of the salesman table with each row of the customer table.
select a.cust_name, a.city, a.grade, b.ord_no, b.ord_date, b.purch_amt
from salesman a 
full outer join customer b on a.customer_id = b.customer_id ; 

/*
select * from salesman a 
cross join customer.b 
*/


-- 18 Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.
select * from salesman a
cross join customer b
where a.city is not null;


-- 19 Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade.
select * from salesman a
cross join customer b
where a.city is not null and b.grade is not null; 


-- 20 Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.
select * from salesman a
cross join customer b
where a.city is not null 
and a.city <> b.city
and b.grade is not null;  


-- 21 From the following tables write a SQL query to select all rows from both participating tables as long as there is a match between pro_com and com_id.
select * from company_mast a
cross join item_mast b ;

/*
select * from item_mast 
inner join company_mast
on item_mass.PRO_COM = company_mast.COM_ID; 
*/


-- 22 Write a SQL query to display the item name, price, and company name of all the products.
select a.PRO_NAME, a.PRO_PRICE, b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID; 


-- 23 From the following tables write a SQL query to calculate the average price of items of each company. Return average value and company name.
select avg(PRO_ID), b.COM_NAME
from item_mast a
inner join company_mast b
on a.PRO_COM = b.COM_ID; 

/*
select avg(b.PRO_PRICE),...
group by b.COM_NAME;
*/


-- 24 From the following tables write a SQL query to calculate and find the average price of items of each company higher than or equal to Rs. 350. Return average value and company name.
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


-- 25 From the following tables write a SQL query to find the most expensive product of each company. Return pro_name, pro_price and com_name.
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


-- 26 From the following tables write a SQL query to display all the data of employees including their department.
select * from emp_details a
inner join epm_department b
on a.EMP_DEPT = b.DPT_CODE;


-- 27 From the following tables write a SQL query to display the first and last names of each employee, as well as the department name and sanction amount.
select a.DPT_NAME, a.DPT_ALLOTMENT, b.EMP_NAME, b.EMP_LNAME
from emp_details a
inner join epm_department b
on a.EMP_DEPT = b.DPT_CODE;


-- 28 From the following tables write a SQL query to find the departments with budgets more than Rs. 50000 and display the first name and last name of employees.
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


-- 29 From the following tables write a SQL query to find the names of departments where more than two employees are employed. Return dpt_name.
select b.DPT_NAME
from emp_details b
inner join epm_department a
on a.EMP_DEPT = b.DPT_CODE ;

/*
group by b.DPT_NAME 
having count(*) > 2; 
*/


