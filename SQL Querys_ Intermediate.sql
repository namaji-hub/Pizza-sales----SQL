--6.Join the necessary tables to find the total quantity of each pizza category ordered.
select 
    t.category, 
    sum(d.quantity) as count
from 
    order_details d 
join 
    pizzas p ON d.pizza_id = p.pizza_id
join 
    pizza_types t on t.pizza_type_id = p.pizza_type_id
group by 
    t.category
order by 
    count desc;
result :-
CATEGORY COUNT
Classic	14888
Supreme	11987
Veggie	11649
Chicken	11050

--7.Determine the distribution of orders by hour of the day.
select * from orders;
SELECT 
    TO_CHAR(TO_DATE(order_time, 'HH24:MI:SS'), 'HH24') AS hour,
    count(order_id) as count
FROM 
    orders
group by 
    TO_CHAR(TO_DATE(order_time, 'HH24:MI:SS'), 'HH24');
/*
RESULT :-
HOUR COUNT
11	1231
12	2520
13	2455
14	1472
15	1468
16	1920
17	2336
18	2399
19	2009
20	1642
21	1198
22	663
23	28
10	8
09	1
*/
--8.Join relevant tables to find the category-wise distribution of pizzas.
select 
    category,
    count(category) as count
from 
    pizza_types
group by 
    category;
/*RESULT:-
CATEGORY COUNT
Chicken	6
Classic	8
Supreme	9
Veggie	9
*/
--9.Group the orders by date and calculate the average number of pizzas ordered per day.
select 
    round(avg(sum(d.quantity)),2) as average
from orders o,
    order_details d
where 
    o.order_id=d.order_id
group by 
    o.order_date;
/*
RESULT :-
AVERAGE
138.47
*/
--10.Determine the top 3 most ordered pizza types based on revenue.
select 
    t.name, 
    round(sum(p.price*d.quantity),0) as amount
from 
    pizzas p
join 
    order_details d on p.pizza_id=d.pizza_id
join 
    pizza_types t on p.pizza_type_id=t.pizza_type_id
group by 
    p.pizza_type_id,
    t.name
order by 
    amount desc
fetch first 3 row only;
/*
RESULT:-
NAME                        AMOUNT
The Thai Chicken Pizza	    43434
The Barbecue Chicken Pizza	42768
The California Chicken Pizza 41410
*/