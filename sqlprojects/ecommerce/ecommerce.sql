create database ecommerce;

-- set @@global.sql_mode= '';


select * from olist_customers_dataset;


-- How many customers are in each city and state
select 
customer_city, 
customer_state,
count(*) as city_count 
from olist_customers_dataset
group by customer_city, customer_state
order by count(*) desc;


/*select 
order_purchase_timestamp as date, 
count(*) 
from olist_orders_dataset
group by order_purchase_timestamp
order by order_purchase_timestamp; 
*/ 

-- Most popular days 
select 
order_purchase_timestamp, 
count(*) 
from olist_orders_dataset
group by order_purchase_timestamp
order by count(*) desc;


-- Popular products categories
select 
t.product_category_name_english,
count(*) 
from olist_products_dataset p
inner join olist_order_items_dataset oi on p.product_id = oi.product_id
inner join product_category_name_translation t on p.product_category_name = t.product_category_name 
group by p.product_category_name 
order by count(*) desc;

-- How close the estimate and actual order dates are, and if they have gotten better or worse 
update olist_orders_dataset 
set order_delivered_carrier_date = '0000-00-00 00:00:00' 
-- where order_status != 'delivered';
where order_id = '2d858f451373b04fb5c984a1cc2defaf';

update olist_orders_dataset 
set order_delivered_customer_date = '0000-00-00 00:00:00' 
-- where order_status != 'delivered';
where order_id = '20edc82cf5400ce95e1afacc25798b31';


update olist_orders_dataset 
set order_approved_at = '0000-00-00 00:00:00' 
where order_status != 'delivered';


select * from olist_orders_dataset where order_status != 'delivered'; 


-- alter table olist_orders_dataset modify column order_delivered_customer_date datetime null;
-- alter table olist_orders_dataset modify column order_estimated_delivery_date datetime;
-- alter table olist_orders_dataset modify column order_delivered_carrier_date datetime null;


select 
year(order_purchase_timestamp) as order_year, 
month(order_purchase_timestamp) as order_month, 
avg(datediff(order_estimated_delivery_date, order_delivered_customer_date)) as date_diff
from olist_orders_dataset
where order_status = 'delivered'
group by order_year, order_month 
order by order_year, order_month; 


-- Orders that took longer than the normal
select 
year(order_purchase_timestamp) as order_year, 
month(order_purchase_timestamp) as order_month,
order_delivered_customer_date as actual_delivery_date,
order_estimated_delivery_date as estimated_delivery_date
from olist_orders_dataset
where order_status = 'delivered'
and order_delivered_customer_date != '';

