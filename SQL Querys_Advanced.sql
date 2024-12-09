--11.Calculate the percentage contribution of each pizza type to total revenue.
with pizza_amount
as
(
select 
    t.name, 
    sum(p.price*d.quantity) as amount
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
    )
,
pizza_total as 
(select 
    sum(amount) total 
from pizza_amount
)
select a.name,round((a.amount/t.total*100),2) as percentage from 
pizza_amount a
cross join pizza_total t;

------------------or----------------------------------------------
select 
    t.name, 
    round((sum(p.price*d.quantity)/( select sum(d.quantity*p.price) as total_sales
from
    order_details d,
    pizzas p
where d.pizza_id= p.pizza_id))*100,2) as amount
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
    amount desc;
/*
RESULT:-
NAME                                        PERCENTAGE
The Thai Chicken Pizza	                    5.31
The Barbecue Chicken Pizza	                5.23
The California Chicken Pizza	            5.06
The Classic Deluxe Pizza	                4.67
The Spicy Italian Pizza	                    4.26
The Southwest Chicken Pizza	                4.24
The Italian Supreme Pizza	                4.09
The Hawaiian Pizza	                        3.95
The Four Cheese Pizza	                    3.95
The Sicilian Pizza	                        3.78
The Pepperoni Pizza	                        3.69
The Greek Pizza	                            3.48
The Mexicana Pizza	                        3.27
The Five Cheese Pizza	                    3.19
The Pepper Salami Pizza	                    3.12
The Italian Capocollo Pizza	                3.07
The Vegetables + Vegetables Pizza	        2.98
The Prosciutto and Arugula Pizza	        2.96
The Napolitana Pizza	                    2.95
The Spinach and Feta Pizza	                2.85
The Big Meat Pizza	                        2.81
The Pepperoni, Mushroom, and Peppers Pizza	2.3
The Chicken Alfredo Pizza	                2.07
The Chicken Pesto Pizza	                    2.04
The Soppressata Pizza	                    2.01
The Italian Vegetables Pizza	            1.96
The Calabrese Pizza	                        1.95
The Spinach Pesto Pizza	                    1.91
The Mediterranean Pizza	                    1.88
The Spinach Supreme Pizza	                1.87
The Green Garden Pizza	                    1.71
The Brie Carre Pizza	                    1.42
*/
--12.Analyze the cumulative revenue generated over time.
select 
    order_date, 
    sum(revenue) over (order by order_date) cum_revenue
from 
    (select 
        o.order_date, 
        sum(p.price*d.quantity)as revenue
    from 
        pizzas p
    join 
        order_details d on p.pizza_id = d.pizza_id
    join 
        orders o on o.order_id = d.order_id
    group by 
        o.order_date
    order by 
        o.order_date asc);
--------or-------------------------
with 
    sales 
as 
(select 
    o.order_date, 
    sum(p.price*d.quantity)as revenue
from 
    pizzas p
join 
    order_details d on p.pizza_id = d.pizza_id
join 
    orders o on o.order_id = d.order_id
group by 
    o.order_date
order by 
    o.order_date asc)
select 
    order_date, 
    sum(revenue) over (order by order_date) cum_revenue
from 
    sales;
/*    
RESULT:-
ORDER_DATE  CUM_REVENUE
01-JAN-15	2713.85
02-JAN-15	5445.75
03-JAN-15	8108.15
04-JAN-15	9863.6
05-JAN-15	11929.55
06-JAN-15	14358.5
07-JAN-15	16560.7
08-JAN-15	19399.05
09-JAN-15	21526.4
10-JAN-15	23990.35
11-JAN-15	25862.65
12-JAN-15	27781.7
13-JAN-15	29831.3
14-JAN-15	32358.7
15-JAN-15	34343.5
16-JAN-15	36937.65
17-JAN-15	39001.75
18-JAN-15	40978.6
19-JAN-15	43365.75
20-JAN-15	45763.65
21-JAN-15	47804.2
22-JAN-15	50300.9
23-JAN-15	52724.6
24-JAN-15	55013.85
25-JAN-15	56631.4
26-JAN-15	58515.8
27-JAN-15	61043.85
28-JAN-15	63059.85
29-JAN-15	65105.15
30-JAN-15	67375.45
31-JAN-15	69793.3
01-FEB-15	72982.5
02-FEB-15	75311.1
03-FEB-15	77925.9
04-FEB-15	80159.8
05-FEB-15	82375.6
06-FEB-15	84885.55
07-FEB-15	87123.2
08-FEB-15	89158.2
09-FEB-15	91353.55
10-FEB-15	93410.05
11-FEB-15	95870.05
12-FEB-15	98028.85
13-FEB-15	100783.35
14-FEB-15	103102.5
15-FEB-15	105243.75
16-FEB-15	107212.55
17-FEB-15	109334.45
18-FEB-15	111977.3
19-FEB-15	114007.55
20-FEB-15	116898.7
21-FEB-15	119009.7
22-FEB-15	120589.65
23-FEB-15	122758.2
24-FEB-15	124952.75
25-FEB-15	127294.05
26-FEB-15	129555.35
27-FEB-15	132413.3
28-FEB-15	134952.9
01-MAR-15	136551.45
02-MAR-15	138930.5
03-MAR-15	141218.4
04-MAR-15	143662.7
05-MAR-15	146013.35
06-MAR-15	148527.3
07-MAR-15	150927.75
08-MAR-15	153115.9
09-MAR-15	155450.45
10-MAR-15	157839.15
11-MAR-15	160046.85
12-MAR-15	162041.75
13-MAR-15	164828.4
14-MAR-15	166867.85
15-MAR-15	168936.45
16-MAR-15	171231.5
17-MAR-15	174196.8
18-MAR-15	176272.2
19-MAR-15	178660.8
20-MAR-15	181122.05
21-MAR-15	183389.45
22-MAR-15	184648.7
23-MAR-15	186881.25
24-MAR-15	189043.55
25-MAR-15	190971.3
26-MAR-15	193186.8
27-MAR-15	195931.6
28-MAR-15	198183.7
29-MAR-15	200337.95
30-MAR-15	202593.4
31-MAR-15	205350
01-APR-15	207526.85
02-APR-15	210074
03-APR-15	212612.2
04-APR-15	215379.75
05-APR-15	217289.6
06-APR-15	219911.95
07-APR-15	222146.2
08-APR-15	224440.15
09-APR-15	226487.45
10-APR-15	228912.4
11-APR-15	231456.15
12-APR-15	233450.45
13-APR-15	235946.65
14-APR-15	238452.35
15-APR-15	241031.2
16-APR-15	243049.15
17-APR-15	245724.8
18-APR-15	248011
19-APR-15	249538.95
20-APR-15	251998.4
21-APR-15	254211.55
22-APR-15	256405
23-APR-15	258831.15
24-APR-15	261810.35
25-APR-15	263899.55
26-APR-15	265666.95
27-APR-15	267847.75
28-APR-15	269590.55
29-APR-15	271419.3
30-APR-15	274086.8
01-MAY-15	276658.75
02-MAY-15	279058.95
03-MAY-15	280891.2
04-MAY-15	283180.1
05-MAY-15	284893.7
06-MAY-15	287203.5
07-MAY-15	289432.35
08-MAY-15	292484.65
09-MAY-15	294853.05
10-MAY-15	297141.4
11-MAY-15	299529.45
12-MAY-15	301829.15
13-MAY-15	304090.95
14-MAY-15	306785.45
15-MAY-15	310171.6
16-MAY-15	312452.7
17-MAY-15	314281.1
18-MAY-15	316490.75
19-MAY-15	318477.75
20-MAY-15	320850.75
21-MAY-15	322913.3
22-MAY-15	325548.4
23-MAY-15	327992.55
24-MAY-15	330189.5
25-MAY-15	332293.9
26-MAY-15	334170.35
27-MAY-15	336267.35
28-MAY-15	338283.75
29-MAY-15	341284.95
30-MAY-15	343771.9
31-MAY-15	345489.55
01-JUN-15	348557.3
02-JUN-15	351007.25
03-JUN-15	352914.3
04-JUN-15	355197.9
05-JUN-15	357898.05
06-JUN-15	360179
07-JUN-15	362139.75
08-JUN-15	364404.7
09-JUN-15	366847.25
10-JUN-15	368866.65
11-JUN-15	371517.15
12-JUN-15	373655.75
13-JUN-15	376164.65
14-JUN-15	378023.65
15-JUN-15	380619.25
16-JUN-15	382517.55
17-JUN-15	384654.65
18-JUN-15	386639.15
19-JUN-15	389432.6
20-JUN-15	391493.2
21-JUN-15	393418.4
22-JUN-15	395737.7
23-JUN-15	397780.45
24-JUN-15	400107.95
25-JUN-15	402507.1
26-JUN-15	405252.6
27-JUN-15	408065.5
28-JUN-15	409635.2
29-JUN-15	411508.8
30-JUN-15	413719.75
01-JUL-15	415951.25
02-JUL-15	418246.05
03-JUL-15	421689.05
04-JUL-15	425553.25
05-JUL-15	427144.7
06-JUL-15	429261.6
07-JUL-15	431636
08-JUL-15	434032.05
09-JUL-15	436329.8
10-JUL-15	438762.2
11-JUL-15	440847.75
12-JUL-15	443033.4
13-JUL-15	445092.9
14-JUL-15	447049.4
15-JUL-15	449551.2
16-JUL-15	452015.1
17-JUL-15	455146.75
18-JUL-15	457268.95
19-JUL-15	459291.65
20-JUL-15	461792.65
21-JUL-15	463823.5
22-JUL-15	466115.6
23-JUL-15	468330.1
24-JUL-15	471534.5
25-JUL-15	473771.75
26-JUL-15	475643.3
27-JUL-15	477815.3
28-JUL-15	479909.85
29-JUL-15	481833.1
30-JUL-15	484182.25
31-JUL-15	486277.65
01-AUG-15	488718.2
02-AUG-15	490628.35
03-AUG-15	492610.6
04-AUG-15	494700.75
05-AUG-15	496795.6
06-AUG-15	498894.85
07-AUG-15	501521.25
08-AUG-15	504237.65
09-AUG-15	506240.3
10-AUG-15	508379.75
11-AUG-15	510669.75
12-AUG-15	513035.5
13-AUG-15	515109.65
14-AUG-15	518126.25
15-AUG-15	520378.6
16-AUG-15	522517.9
17-AUG-15	525143.9
18-AUG-15	527245.1
19-AUG-15	529578.05
20-AUG-15	531485.75
21-AUG-15	534087.15
22-AUG-15	536493.15
23-AUG-15	538194.75
24-AUG-15	539891.8
25-AUG-15	541850.7
26-AUG-15	544180.1
27-AUG-15	546297.75
28-AUG-15	548944.95
29-AUG-15	550979.95
30-AUG-15	552474.55
31-AUG-15	554555.9
01-SEP-15	556908.75
02-SEP-15	558774.3
03-SEP-15	561026.9
04-SEP-15	563987.85
05-SEP-15	566525.65
06-SEP-15	568017.3
07-SEP-15	570300.65
08-SEP-15	572550.15
09-SEP-15	575130.25
10-SEP-15	577546.1
11-SEP-15	580308
12-SEP-15	582896.15
13-SEP-15	584734.3
14-SEP-15	586899.55
15-SEP-15	589449.75
16-SEP-15	591635
17-SEP-15	593877.05
18-SEP-15	596598.6
19-SEP-15	598885.15
20-SEP-15	600714.15
21-SEP-15	602845.6
22-SEP-15	605016
23-SEP-15	607179
26-SEP-15	609425.85
27-SEP-15	611740.55
28-SEP-15	613775.85
29-SEP-15	616537.9
30-SEP-15	618735.95
01-OCT-15	621938.1
02-OCT-15	624012.95
03-OCT-15	626413.9
04-OCT-15	628556.1
06-OCT-15	630772.05
07-OCT-15	632864.4
08-OCT-15	634840.25
09-OCT-15	637352.85
10-OCT-15	639663.05
11-OCT-15	641579.3
13-OCT-15	643905.25
14-OCT-15	646051.6
15-OCT-15	650371.8
16-OCT-15	652926.9
17-OCT-15	655266.7
18-OCT-15	657062
20-OCT-15	659499.15
21-OCT-15	661959.65
22-OCT-15	664360.55
23-OCT-15	666971.2
24-OCT-15	669650.7
25-OCT-15	671487.75
27-OCT-15	673476.4
28-OCT-15	675112.35
29-OCT-15	677282.1
30-OCT-15	680018.7
31-OCT-15	682763.55
01-NOV-15	684750.2
02-NOV-15	687049.3
03-NOV-15	688877.85
04-NOV-15	690843.95
05-NOV-15	693024.3
06-NOV-15	696181.8
07-NOV-15	698762.75
08-NOV-15	700872.9
09-NOV-15	703356.65
10-NOV-15	705399.25
11-NOV-15	707345.45
12-NOV-15	709910.25
13-NOV-15	712174.8
14-NOV-15	714499.55
15-NOV-15	716321.2
16-NOV-15	718577.85
17-NOV-15	720534.4
18-NOV-15	722646.1
19-NOV-15	725341
20-NOV-15	727729.1
21-NOV-15	729813.05
22-NOV-15	731181.75
23-NOV-15	733646.9
24-NOV-15	735876.95
25-NOV-15	738240.2
26-NOV-15	742646.15
27-NOV-15	747068.6
28-NOV-15	749036.65
29-NOV-15	750935.65
30-NOV-15	753158.9
01-DEC-15	755235.6
02-DEC-15	757449.7
03-DEC-15	759692.9
04-DEC-15	762571.25
05-DEC-15	765199.2
06-DEC-15	767549.45
07-DEC-15	769964.25
08-DEC-15	771820.5
09-DEC-15	774392.05
10-DEC-15	776377.65
11-DEC-15	779011.65
12-DEC-15	780971.8
13-DEC-15	783216.95
14-DEC-15	785389.55
15-DEC-15	787777
16-DEC-15	790011.8
17-DEC-15	791892.55
18-DEC-15	794778.85
19-DEC-15	797083.05
20-DEC-15	799187.95
21-DEC-15	801288.65
22-DEC-15	803171.6
23-DEC-15	805415.9
24-DEC-15	807553.75
26-DEC-15	809196.8
27-DEC-15	810615.8
28-DEC-15	812253
29-DEC-15	813606.25
30-DEC-15	814944.05
31-DEC-15	817860.05
*/
    
--13.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with a as 
(select 
    t.category,
    t.name,
    sum(p.price*d.quantity) as revenue
from 
    pizzas p
join 
    order_details d on p.pizza_id=d.pizza_id
join 
    pizza_types t on p.pizza_type_id=t.pizza_type_id
group by 
    t.name,
    t.category
order by 
    revenue desc),
b as
(select 
    a.category, 
    a.name, 
    a.revenue, 
    rank() over( PARTITION by a.category order by a.revenue desc) as rank
from a)
select 
    b.name,
    b.revenue, 
    b.rank
from b
where rank <= 3;

--------------------or----------------------------------------
select name,revenue,rank
from
    (
    select 
        category, 
        name, 
        revenue, 
        rank() over( PARTITION by category order by revenue desc) as rank
    from 
        (
        select 
            t.category,
            t.name,
            sum(p.price*d.quantity) as revenue
        from 
            pizzas p
        join 
            order_details d on p.pizza_id=d.pizza_id
        join 
            pizza_types t on p.pizza_type_id=t.pizza_type_id
        group by 
            t.name,
            t.category
        order by 
            revenue desc 
        ) 
    )
where 
    rank <= 3;
/*
RESULT:-
NAME                            REVENUE    RANK
The Thai Chicken Pizza      	43434.25	1
The Barbecue Chicken Pizza	    42768	    2
The California Chicken Pizza	41409.5	    3
The Classic Deluxe Pizza	    38180.5	    1
The Hawaiian Pizza	            32273.25	2
The Pepperoni Pizza	            30161.75	3
The Spicy Italian Pizza	        34831.25	1
The Italian Supreme Pizza	    33476.75	2
The Sicilian Pizza	            30940.5	    3
The Four Cheese Pizza	        32265.7	    1
The Mexicana Pizza	            26780.75	2
The Five Cheese Pizza	        26066.5 	3
*/