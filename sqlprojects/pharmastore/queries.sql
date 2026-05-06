-- Across all their Product Line, which one is the best selling?
-- select `drugsid`, `name`, sum(sales) as revenue from `drugs` group by `name` order by 2 desc;

-- What was the best month for sales?


-- How many distinct product lines are there in the dataset?
SELECT COUNT(DISTINCT `name`) FROM `drugs`;
-- 814


-- What is the most selling product line?
SELECT `name`, count(`name`) AS most_selling_product
FROM `drugs` GROUP BY `name` ORDER BY most_selling_product DESC LIMIT 1;
-- Ibuprofen, 11


-- Which product line generated the highest revenue?
SELECT MONTH(`orderdate`) AS `month_name`, SUM(`subtotal`) AS total_revenue
FROM `orders`
LEFT JOIN `order_items` ON `orders`.`orderid` = `order_items`.`ordersid` 
GROUP BY `month_name` ORDER BY total_revenue DESC;

/*
12	1009792.80
3	998915.54
1	970177.21
7	950384.29
5	939453.37
2	937979.14
10	937863.30
11	934342.72
4	929265.66
8	912158.00
9	899277.89
6	883304.94
*/

-- Most expensive order? 
select o.`orderid`, o.`orderdate`, o.`ordstatus`, o.`ordquantity`, oi.`price`, oi.`subtotal` 
from `orders` o
left join `order_items` oi
on o.`orderid` = oi.`ordersid` 
order by oi.`price` desc;

-- Total sales
-- select `drugid`, sum(`quantity`) from `order_items` group by `drugid`;
select sum(`quantity`) as total_sales from `order_items`;

-- Total sales of the last month
select * from `orders` where month(`orderdate`)= month(now())-1;
select * from `orders` where year(`orderdate`) = '2024' and month(`orderdate`)= month(now())-1;

-- Total sales of the last year
select * from `orders` where year(`orderdate`) = '2024' and `ordstatus` != 'Cancelled';
select * from `orders` where year(`orderdate`) = '2024';

-- Total revenue
SELECT SUM(`subtotal`) AS total_revenue FROM `order_items`;

-- Total profit 
SELECT SUM((oi.`price` - d.`buycost`) * oi.`quantity`) AS total_profit
FROM `order_items` oi
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`;

-- Total Margin
SELECT 
    ROUND(
        SUM((oi.`price` - d.`buycost`) * oi.`quantity`) / 
        NULLIF(SUM(oi.`price` * oi.`quantity`), 0), 2
    ) AS total_margin
FROM `order_items` oi
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`;
 

-- Which drug(s) had the most sales (change the LIMIT)
SELECT d.`name`, SUM(oi.`subtotal`) AS total_sales
FROM `order_items` oi
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`
GROUP BY d.`name`
ORDER BY total_sales DESC LIMIT 5;


-- Which category had the most sales
SELECT 
    d.`catname`,
    SUM(oi.`quantity` * oi.`price`) AS total_sales
FROM `order_items` oi
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`
GROUP BY d.`catname`
ORDER BY total_sales DESC LIMIT 5;


-- How many times a customer made an order
SELECT o.`userid`, 
	CONCAT(u.`firstname`,' ', u.`lastname`) as fullname, 
	COUNT(*) AS total_orders
FROM `orders` o
JOIN `users` u ON o.`userid` = u.`ID`
GROUP BY o.`userid`
ORDER BY total_orders DESC;

-- How many times a customer made an order and which category 
SELECT o.`userid`, 
	CONCAT(u.`firstname`,' ', u.`lastname`) as customer_name, 
	d.`catname` AS drug_category, 
	COUNT(DISTINCT o.`orderid`) AS total_orders
FROM `users` u
JOIN `orders` o ON u.`ID` = o.`userid`
JOIN `order_items` oi ON o.`orderid` = oi.`ordersid`
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`
GROUP BY u.`ID`, d.`catname`
ORDER BY customer_name, total_orders DESC;


-- annual sales per product?
SELECT 
    d.`name` AS product_name,
    YEAR(o.`orderdate`) AS order_year,
    SUM(oi.`price` * oi.`quantity`) AS total_sales
FROM `order_items` oi
JOIN `drugs` d ON oi.`drugid` = d.`drugsid`
JOIN `orders` o ON oi.`ordersid` = o.`orderid`
GROUP BY d.`name`, YEAR(o.`orderdate`)
ORDER BY order_year, total_sales DESC;


-- Top Customers 
-- select count(*) from users;
SELECT o.`userid`, 
	CONCAT(u.`firstname`,' ', u.`lastname`) as customer_name,
	sum(o.ordcost) as total_spend
FROM `users` u 	
JOIN `orders` o ON u.`ID` = o.`userid`
group by o.userid , customer_name 
order by total_spend desc 
limit 5; 


-- Most recent order a customer has made
select * from (
	select o.* ,
	row_number() over(partition by o.`userid` order by o.`orderdate`desc) as rn
	from orders o 
) t 
where rn = 1;


-- top 3 orders per customer 
select * from 
    (select o.*,
    rank() over(partition by userid) as rnk
    from orders o) x
where x.rnk < 4;



-- Customers with no orders 
select u.* 
from users u
left join orders o on u.ID = o.userid 
where o.userid is null;


-- Total cost per customer
select u.ID, CONCAT(u.`firstname`,' ', u.`lastname`) as customer_name, sum(o.ordcost) as total_spend
from orders o  
join users u on u.ID = o.userid 
group by u.ID , customer_name; 


-- Customers who made more than 3 orders
select u.ID, CONCAT(u.`firstname`,' ', u.`lastname`) as customer_name, COUNT(*) as order_count
from orders o 
join users u on u.ID = o.userid 
group by o.userid 
having count(*) > 3;

-- Second biggest amount of an order
select distinct o.ordcost
from orders o 
order by o.ordcost desc 
limit 1 offset 1;

-- with window function
SELECT ordcost
FROM (
    SELECT ordcost,
           DENSE_RANK() OVER (ORDER BY ordcost DESC) AS rnk
    FROM orders 
) t
WHERE rnk = 2;



-- Orders per day
select o.orderdate, COUNT(*) as total_orders 
from orders o 
group by date(o.orderdate)
order by o.orderdate;

-- Top 3 customers according to their total spent
select u.ID, CONCAT(u.`firstname`,' ', u.`lastname`) as customer_name, SUM(o.ordcost) as total_spent 
from orders o 
join users u on u.ID = o.userid 
group by u.ID, customer_name   
order by total_spent desc 
limit 3;


-- Orders which total amount surpass the average (11s to execute)
select * 
from orders o 
where o.ordcost > (
	select avg(o.ordcost) from orders o2 
); 


-- Duplicates 
select o.userid, o.orderdate 
from orders o 
group by o.userid, o.orderdate 
having COUNT(*) > 1;

-- Cumulative sum per customer
select o.userid , o.orderdate , o.ordcost,
SUM(ordcost) over(partition by o.userid  order by o.orderdate) as running_total
from orders o ;


-- index
create index idx_user on users(lastname);
SHOW INDEXES FROM users;
DROP INDEX idx_users ON users;
ALTER INDEX idx_users ON users REBUILD;
EXEC sp_rename 'idx_users', 'idx_new_user', 'INDEX';





