
-- 1) How many unique orders exist in the ORDER_DETAILS table.--

SELECT COUNT(DISTINCT order_id) AS unique_orders 
FROM ORDER_DETAILS;


-- 2)  List all pizza types (pizza_id) sold and their quantities.--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id;

-- 3)  Retrieve the top 5 most frequently ordered pizzas.--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id 
ORDER BY total_quantity DESC 
LIMIT 5;


-- 4) Retrieve the order_id with the maximum total quantity of pizzas.--

SELECT order_id 
FROM ORDER_DETAILS 
GROUP BY order_id 
ORDER BY SUM(quantity) DESC 
LIMIT 1;


-- 5) Write a query to find the maximum order_details_id in the table.--

SELECT MAX(order_details_id) AS max_order_details_id 
FROM ORDER_DETAILS;



-- 6) How many unique pizza types are there in the ORDER_DETAILS table? --

SELECT COUNT(DISTINCT pizza_id) AS unique_pizzas
 FROM ORDER_DETAILS;


-- 7) Find the quantity of each pizza ordered?--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id;

-- 8)  What is the average quantity of pizzas ordered per order?--

SELECT AVG(quantity) AS average_quantity 
FROM ORDER_DETAILS;





-- 9) How many pizzas were ordered for each order? --

SELECT o.order_id, COUNT(od.pizza_id) AS total_pizzas 
FROM ORDERS o 
JOIN ORDER_DETAILS od ON o.order_id = od.order_id 
GROUP BY o.order_id;



-- 10) List all orders along with their respective pizza types and quantities? --

SELECT od.order_id, od.pizza_id, od.quantity 
FROM ORDER_DETAILS od;

-- 11) Find the running total of pizzas ordered by order ID.--

SELECT order_id, 
       SUM(quantity) OVER (ORDER BY order_id) AS running_total 
FROM ORDER_DETAILS;




-- 12) Which pizza has the highest quantity ordered?-- 

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id 
ORDER BY total_quantity DESC LIMIT 1;




-- 13) Find all orders that contain more than 2 pizzas using a subquery.--

SELECT order_id 
FROM ORDER_DETAILS 
GROUP BY order_id 
HAVING SUM(quantity) > 2;


-- 14) List all pizzas that have been ordered more than once using a subquery? --

SELECT DISTINCT pizza_id 
FROM ORDER_DETAILS 
WHERE pizza_id IN (SELECT pizza_id FROM ORDER_DETAILS GROUP BY pizza_id HAVING SUM(quantity) > 1);



 -- 15) Classify orders into 'Single', 'Double', and 'Multiple' based on quantity ordered.-- 

 SELECT order_details_id,
       CASE 
           WHEN quantity = 1 THEN 'Single'
           WHEN quantity = 2 THEN 'Double'
           ELSE 'Multiple'
       END AS order_classification
FROM ORDER_DETAILS;




-- 16) Count how many pizzas fall into each classification ('Single', 'Double', 'Multiple'). --

SELECT CASE 
           WHEN quantity = 1 THEN 'Single'
           WHEN quantity = 2 THEN 'Double'
           ELSE 'Multiple'
       END AS classification,
       COUNT(*) AS count
FROM ORDER_DETAILS
GROUP BY classification;


 -- 17) What is the maximum quantity of a single type of pizza ordered? --

SELECT MAX(quantity) AS max_quantity 
FROM ORDER_DETAILS;


 -- 18) Find all orders with their corresponding quantities and classify them as above average or below average based on average quantity per order.

WITH avg_quantity AS (
    SELECT AVG(quantity) AS avg_qty FROM ORDER_DETAILS
)

SELECT order_details_id,
       quantity,
       CASE WHEN quantity > (SELECT avg_qty FROM avg_quantity) THEN 'Above Average' ELSE 'Below Average' END AS classification
FROM ORDER_DETAILS;


 -- 19) Determine how many different types of pizzas were ordered in each order using a subquery.--

SELECT order_id, COUNT(DISTINCT pizza_id) AS unique_pizza_count 
FROM ORDER_DETAILS 
GROUP BY order_id;


 -- 20) Count how many times each type of pizza was ordered using a group by statement with having clause to filter results greater than 5 orders.

SELECT pizza_id, COUNT(*) as count_orders 
FROM ORDER_DETAILS 
GROUP BY pizza_id HAVING count_orders > 5;


 -- 21) Count the number of unique pizzas ordered in each size category (small, medium, large).

SELECT CASE 
           WHEN pizza_id LIKE '%s' THEN 'Small'
           WHEN pizza_id LIKE '%m' THEN 'Medium'
           WHEN pizza_id LIKE '%l' THEN 'Large'
       END AS size,
       COUNT(DISTINCT pizza_id) AS unique_pizza_count
FROM ORDER_DETAILS
GROUP BY size;


 -- 22) Find the pizza ID that has been ordered the most times. --

SELECT pizza_id, SUM(quantity) AS total_ordered 
FROM ORDER_DETAILS 
GROUP BY pizza_id 
ORDER BY total_ordered DESC LIMIT 1; 

-- 23) Find the average quantity of pizzas ordered per order. --

SELECT AVG(total_quantity) AS average_quantity_per_order 
FROM (SELECT SUM(quantity) AS total_quantity FROM ORDER_DETAILS GROUP BY order_id) AS subquery;


 -- 24) List all orders and their corresponding quantities, filtering for orders with at least two pizzas.-- 

SELECT order_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY order_id  
HAVING total_quantity >= 2; 



-- 25) Which orders contain both Hawaiian and BBQ Chicken pizzas? --

SELECT DISTINCT order_id 
FROM ORDER_DETAILS 
WHERE order_id IN (
    SELECT order_id FROM ORDER_DETAILS WHERE pizza_id = 'hawaiian_m'
) AND order_id IN (
    SELECT order_id FROM ORDER_DETAILS WHERE pizza_id = 'bbq_ckn_l'
);

 -- 26 count how many different types of pizzas were ordered in each order --

SELECT order_id, COUNT(DISTINCT pizza_id) AS unique_pizza_count 
FROM ORDER_DETAILS 
GROUP BY order_id;

 -- 27) List all orders that contain a specific pizza type (e.g., 'spicy_ital_l'). --

SELECT DISTINCT order_id 
FROM ORDER_DETAILS 
WHERE pizza_id = 'spicy_ital_l'; 


 -- 28) Find orders that have at least one type of large pizza ordered (e.g., any pizza ending with '_l'). --

SELECT DISTINCT order_id 
FROM ORDER_DETAILS 
WHERE pizza_id LIKE '%L'; 

-- 29) List all orders that contain a specific pizza type (e.g., 'spicy_ital_l'). --

SELECT DISTINCT order_id 
FROM ORDER_DETAILS 
WHERE pizza_id = 'spicy_ital_l'; 

 -- 30) Which orders contain both Hawaiian and BBQ Chicken pizzas? --

SELECT DISTINCT order_id 
FROM ORDER_DETAILS 
WHERE order_id IN (
    SELECT order_id FROM ORDER_DETAILS WHERE pizza_id = 'hawaiian_m'
) AND order_id IN (
    SELECT order_id FROM ORDER_DETAILS WHERE pizza_id = 'bbq_ckn_l'
);





 