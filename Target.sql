--TARGET

--CUSTOMER TABLE : - WHY 2 CUSTOME ID  AND UNIQUE ID HAD - > NON UNIQUE FEILDS
-----------------------------------------------------------------------------------------------------------
SELECT customer_id,customer_unique_id, customer_city,customer_state
FROM `target_data.customers`;
SELECT COUNT(DISTINCT customer_id),COUNT(DISTINCT customer_unique_id) FROM `target_data.customers`;
SELECT (customer_id),(customer_unique_id) FROM `target_data.customers`;

--customers
---------
SELECT * FROM `target_data.customers`;
SELECT COUNT(*) FROM `target_data.customers`;--99441
SELECT COUNT(DISTINCT customer_id) FROM `target_data.customers`;--99441
SELECT COUNT(DISTINCT customer_unique_id) FROM `target_data.customers`;--96096
SELECT COUNT(*) FROM (SELECT customer_unique_id,ROW_NUMBER() OVER(PARTITION BY customer_unique_id) AS ROWNUM
FROM `target_data.customers` ) AS E WHERE ROWNUM > 1;--3345 (96096+3345 = 99441)
SELECT * FROM (SELECT customer_unique_id,ROW_NUMBER() OVER(PARTITION BY customer_unique_id) AS ROWNUM
FROM `target_data.customers` ) AS E WHERE ROWNUM > 1;

SELECT DISTINCT CUSTOMER_CITY FROM `target_data.customers`;
SELECT COUNT(DISTINCT CUSTOMER_CITY) FROM `target_data.customers`;--4119
SELECT DISTINCT CUSTOMER_STATE FROM `target_data.customers`;
SELECT COUNT(DISTINCT CUSTOMER_STATE) FROM `target_data.customers`;--27SELECT * FROM `target_data.customers`;
SELECT COUNT(*) FROM `target_data.customers`;--99441
SELECT COUNT(DISTINCT customer_id) FROM `target_data.customers`;--99441
SELECT COUNT(DISTINCT customer_unique_id) FROM `target_data.customers`;--96096
SELECT COUNT(*) FROM (SELECT customer_unique_id,ROW_NUMBER() OVER(PARTITION BY customer_unique_id) AS ROWNUM
FROM `target_data.customers` ) AS E WHERE ROWNUM > 1;--3345 (96096+3345 = 99441)
SELECT * FROM (SELECT customer_unique_id,ROW_NUMBER() OVER(PARTITION BY customer_unique_id) AS ROWNUM
FROM `target_data.customers` ) AS E WHERE ROWNUM > 1;

SELECT DISTINCT CUSTOMER_CITY FROM `target_data.customers`;
SELECT COUNT(DISTINCT CUSTOMER_CITY) FROM `target_data.customers`;--4119
SELECT DISTINCT CUSTOMER_STATE FROM `target_data.customers`;
SELECT COUNT(DISTINCT CUSTOMER_STATE) FROM `target_data.customers`;--27


--ORDERS TABLE:
-----------------------------------------------------------------------------------------------------------
SELECT * FROM `target-382407.target_data.customers`;
SELECT COUNT(*) FROM `target-382407.target_data.customers`;
SELECT DISTINCT  customer_state
FROM `target-382407.target_data.customers`;
SELECT * FROM (SELECT S.*,RANK() OVER(PARTITION BY customer_id ORDER BY customer_id) AS RNK
FROM `target_data.customers` AS S) AS E WHERE RNK >1;
SELECT * FROM `target_data.sellers`;
SELECT COUNT(*) FROM `target_data.sellers`;--3095
SELECT COUNT(DISTINCT SELLER_ID) FROM `target_data.sellers`;--3095 
SELECT COUNT(*) FROM (SELECT SELLER_ID,ROW_NUMBER() OVER(PARTITION BY SELLER_ID) AS ROWNUM
FROM `target_data.sellers`) AS E WHERE ROWNUM > 1;-- No duplicates 

--order_items 
-----------------------------------------------------------------------------------------------------------
select * from `target_data.order_items`;
select count(*) from `target_data.order_items`;--112650
select count(distinct order_id), count(distinct order_item_id), 
  count(distinct product_id),count(distinct seller_id) from `target_data.order_items`;--98666,(quandity)21,32951, sellers - 3095

SELECT * FROM (SELECT order_id,ROW_NUMBER() OVER(PARTITION BY order_id) AS ROWNUM
FROM `target_data.order_items`) AS E WHERE ROWNUM > 1;  
SELECT * FROM `target_data.order_items` where order_id= '261f725152296e3e8d5041687181d836'

--geolocations
-----------------------------------------------------------------------------------------------------------
select * from `target_data.geolocation`;
select count(distinct geolocation_city) from `target_data.geolocation`;--8011
select count(distinct geolocation_state) from `target_data.geolocation`;--27


--payments
-----------------------------------------------------------------------------------------------------------
select * from `target_data.payments`;
select count(*) from `target_data.payments`;--103886
select count(distinct order_id) from `target_data.payments`;--99440
select distinct payment_type from `target_data.payments`;-- 5 
select distinct payment_installments from `target_data.payments`;--24 


--orders;(8 columns were there in actual table- order_approved_at)
-----------------------------------------------------------------------------------------------------------
select * from `target_data.orders`;
select count(*) from `target_data.orders`;--99441
select count(distinct order_id) from `target_data.orders`;--99441
select count(distinct customer_id) from `target_data.orders`;--99441


--reviews
-----------------------------------------------------------------------------------------------------------
select * from `target_data.order_reviews`;
select count(*) from `target_data.order_reviews`;--99224
select count(distinct order_id) from `target_data.order_reviews`;--98673
select count(distinct review_id) from `target_data.order_reviews`;--98410
SELECT * FROM (SELECT review_id,ROW_NUMBER() OVER(PARTITION BY review_id) AS ROWNUM
FROM `target_data.order_reviews`) AS E WHERE ROWNUM > 1;

select * from `target_data.order_reviews` where review_id = '3415c9f764e478409e8e0660ae816dd2'; 

--products
-----------------------------------------------------------------------------------------------------------
select * from `target_data.products`;
select count(*) from `target_data.products`;--32951
select count(distinct product_id) from `target_data.products`;--32951
select count(distinct product_category) from `target_data.products`;--73



SELECT * FROM `target_data.sellers`;
SELECT * FROM (SELECT S.*,RANK() OVER(PARTITION BY seller_id ORDER BY seller_id) AS RNK
FROM `target_data.sellers` AS S) AS E WHERE RNK >1;


SELECT * FROM `target_data.order_items`;

SELECT * FROM `target_data.orders`;

SELECT * FROM `target_data.geolocation`;

SELECT * FROM `target_data.orders`;

SELECT * FROM `target_data.order_reviews`;

SELECT * FROM `target_data.orders`;--order_purchase_timestamp,order_delivered_customer_date,order_estimated_delivery_date

SELECT COUNT(*) 
FROM `target_data.orders`; 

12.	Time period for which the data is given  - 2016-09-04 TO 2018-10-17

sELECT DISTINCT FIRST_VALUE(order_purchase_timestamp) OVER(ORDER BY order_purchase_timestamp)
FROM `target_data.orders`;
SELECT DATE(MIN(order_purchase_timestamp))
FROM `target_data.orders`; --2016-09-04
select * from (SELECT DISTINCT LAST_VALUE(order_purchase_timestamp) OVER(ORDER BY order_purchase_timestamp) as x
FROM `target_data.orders`) as e   order by x desc;
SELECT DATE(MAX(order_purchase_timestamp))
FROM `target_data.orders`; --	2018-10-17

13.	Cities and States of customers ordered during the given period


SELECT DISTINCT customer_city 
FROM `target_data.customers`;

SELECT COUNT(DISTINCT customer_city )
FROM `target_data.customers`;--------------4119
SELECT COUNT(DISTINCT customer_state )
FROM `target_data.customers`;  -------------27

----------------------------------------------------------------------------------------------------------------------
--2

SELECT order_purchase_timestamp, FORMAT_DATE('%B', DATE(order_purchase_timestamp)) AS month_name,
FORMAT_DATE('%Y', DATE(order_purchase_timestamp)) AS year_name
FROM `target_data.orders`;

SELECT order_purchase_timestamp,concat(FORMAT_DATE('%B', DATE(order_purchase_timestamp)),' ',FORMAT_DATE('%Y', DATE(order_purchase_timestamp))) as month_year
FROM `target_data.orders`;


select m.month_year,avg(cnt) from
(
select count(order_id) cnt,month_year from
(
SELECT order_id,concat(FORMAT_DATE('%B', DATE(order_purchase_timestamp)),' ',FORMAT_DATE('%Y', DATE(order_purchase_timestamp))) as month_year
FROM `target_data.orders`
) as a
group by  month_year
order by substr(month_year,-2,4)) as m;
	
	
SELECT order_id,
FORMAT_DATE('%Y', DATE(order_purchase_timestamp)) AS year_name
FROM `target_data.orders`
group by year_name order by year_name;



SELECT  COUNT(ORDER_ID), 
EXTRACT(HOUR FROM TIMESTAMP(order_purchase_timestamp)) AS hour_ord
FROM `target_data.orders`
--WHERE EXTRACT(YEAR FROM TIMESTAMP(order_purchase_timestamp))= 2018
GROUP BY hour_ord
ORDER BY hour_ord;

----------------------------------------------------------------------------------------------------------------------
--3)

select c.customer_state,count(o.order_id) as cnt
from `target_data.customers` c JOIN `target_data.orders` o on c.customer_id=o.customer_id
group by c.customer_state;

with cte_1 as (
SELECT order_id,customer_id,(FORMAT_DATE('%B', DATE(order_purchase_timestamp))) as month
FROM `target_data.orders`
)
select c.customer_state,o.month,count(o.order_id) from cte_1 o join `target_data.customers` c on 
c.customer_id=o.customer_id 
group by  c.customer_state,o.month
order by substr(month,-2,4);

with cte_1 as (
SELECT order_id,--customer_id,
extract(month from DATE(order_purchase_timestamp)),
FORMAT_DATE('%Y', DATE(order_purchase_timestamp)) as year
FROM `target_data.orders`
)
select o.*,p.payment_value from cte_1 o join `target_data.payments` p on o.order_id=p.order_id;


select o.order_id,p.product_id,oi.price
from `target_data.order_items` oi join `target_data.orders` o on o.order_id=oi.order_id
join `target_data.products` p on p.product_id= oi.product_id
order by o.order_id;
----------------------------------------------------------------------------------------------------------------------

--4)

select c.customer_state,sum(oi.price),sum(oi.freight_value),avg(oi.price),avg(oi.freight_value)
from `target_data.customers` c join `target_data.orders` o on c.customer_id=o.customer_id
join `target_data.order_items` oi on o.order_id=oi.order_id
group by c.customer_state
order by sum(oi.price)desc;

----------------------------------------------------------------------------------------------------------------------
--5)
--1)
select order_id,
  order_purchase_timestamp,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  date_diff(order_delivered_customer_date,order_purchase_timestamp,day) as cus_delivery,
  date_diff(order_estimated_delivery_date,order_purchase_timestamp,day) as estimate_delivery
 from `target_data.orders`
 where order_delivered_customer_date is not null;\
