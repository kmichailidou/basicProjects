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

