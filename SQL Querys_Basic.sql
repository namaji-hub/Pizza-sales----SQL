--1.Retrieve the total number of orders placed.
select 
    count(order_id) as total_orders 
from 
    orders;
/*
RESULT :-
TOTAL_ORDERS
21350
*/
--2.Calculate the total revenue generated from pizza sales.
select 
    sum(d.quantity*p.price) as total_sales
from
    order_details d,
    pizzas p
where 
    d.pizza_id= p.pizza_id;
/*
RESULT:-
TOTAL_SALES
817860.05
*/
--3.Identify the highest-priced pizza.
select 
    t.name,
    p.price
from 
    pizzas p,
    pizza_types t
where 
    p.pizza_type_id= t.pizza_type_id
order by 
    price desc
FETCH FIRST 1 ROWS ONLY;
/*
RESULT:-
NAME                PRICE
The Greek Pizza     35.95
 */       
--4.Identify the most common pizza size ordered.
select 
    p.pizza_size, 
    sum(d.quantity) as total_size
from 
    pizzas p,
    order_details d
where 
    p.pizza_id = d.pizza_id
group by 
    p.pizza_size
order by 
    total_size desc
fetch first 1 row only;
/*
RESULT :-
PIZZA_SIZE  TOTAL_SIZE
L           18956
 */   
--5.List the top 5 most ordered pizza types along with their quantities.
select 
    t.name,
    p.pizza_type_id, 
    sum(d.quantity) as count
from 
    order_details d 
join 
    pizzas p ON d.pizza_id = p.pizza_id
join 
    pizza_types t on t.pizza_type_id = p.pizza_type_id
group by 
    t.name,
    p.pizza_type_id
order by 
    count desc
fetch first 5 row only;
/*
RESULT:-
NAME                         PIZZA_TYPE_ID  COUNT
The Classic Deluxe Pizza	classic_dlx	    2453
The Barbecue Chicken Pizza	bbq_ckn	        2432
The Hawaiian Pizza	        hawaiian	    2422
The Pepperoni Pizza	        pepperoni	    2418
The Thai Chicken Pizza  	thai_ckn	    2371
*/