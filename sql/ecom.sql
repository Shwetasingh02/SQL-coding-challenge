show databases;
use ecomdb;
show tables;

insert into customer (name,email,password)value('Jhon Doe','john@gmail','jhon@02'),
                                                ('Jane Smith','jane@gmail','smith@04'),
                                                ('Robert Johnson','robert@gmail','johnson@03'),
                                                ('Sarah Brown','sarah@gmail','sarah@05'),
                                                ('David Lee','david@gmail','lee@04');
                                                
 insert into product (name,price,describtion,stock_quantity)values('Laptop',800,'High_performance laptop',10),
                                                                   ('smartphone',600,'latest smartphone',15),
                                                                   ('refrigerator',900,'enery-efficient',10),
                                                                   ('tablet',700,'portable tablet',20),
                                                                   ('tv',500,'4k smart tv',5); 
                                                                   
																
insert into car(quantity,customer_id,product_id)values(2,1,1),(1,1,3),(3,2,2),(4,3,4),(2,4,2);


insert into orders (id,date,total_price,shipping_address,customer_id)values(1,'2024-04-03',900,'mumbai',1),
																		   (2,'2024-03-09',300,'MS',2),
                                                                           (3,'2024-03-04',700,'goa',4),
                                                                           (4,'2024-01-02',400,'chennai',3);

insert ordeitem(quantity,order_id,product_id)values(2,1,3),(3,2,1),(1,1,1),(2,4,3),(1,3,4);



-- 01. update refrigeretor price to 800

update product
set price = 800
where id = 4;

-- 02 remove all cart items for a specific customer
delete from car
where customer_id = '1';

-- 03.retrive product price below 100

select *
from product
where price <100;

-- output will be NULL because not a signal product price is less than 100

-- 04. find products with stock quantity is greater than 5

select *
from product
where stock_quantity >5;

-- output
/*
1	Laptop	       800	High_performance laptop	   10
2	Laptop	       800	High_performance laptop	   10
3	smartphone     600	latest smartphone	       15
4	refrigerator   800	enery-efficient	           10
5	tablet	      700	portable tablet	           20
*/

-- 05 retrive orders total amountt between 500 to 1000

select *
from orders
where total_price between 500 and 1000;

-- output

/*
1	2024-04-03	 900 	    mumbai	1
3	2024-03-04	 700	    goa	    4
*/

 -- 06 find the product which name starts with r
 
 select *
 from product
 where name like 'r%';
 
 -- output
 
 /*
 4	refrigerator	800	enery-efficient	10
 */
 
 -- 07 retrive cart item for customer 5
 
 select *
 from car
 where customer_id=5;
 
 -- 08 find the customer who placed order in 2023
 
 select c.*
 from customer c JOIN orders o  ON c.id=o.customer_id
 where Year (2023);
 
 -- 09 determine minimum stock quantity for each product
 
 select distinct name,min(stock_quantity)
 from product
 group by name;
 
 -- output
 /*
 Laptop	        10
refrigerator	10
smartphone	    15
tablet	        20
tv	             5
 */
 
 -- 10 claculate total amount spent by each customer
 
 select c.name, sum(o.total_price) as total_price_spent
 from customer c JOIN orders o ON c.id=o.customer_id
 group by c.id;
 
 -- output
 
 /*
 Jhon Doe	    900
Jane Smith	    300
Sarah Brown	    700
Robert Johnson	400
 */
 
 -- 11 find average order amount for each customer
 
 select c.name, avg(o.total_price) as avg_amount_spent
 from customer c JOIN orders o ON c.id=o.customer_id
 group by c.id;
 
 -- output
 
 /*
 Jhon Doe	    900.0000
Jane Smith	    300.0000
Sarah Brown	    700.0000
Robert Johnson	400.0000
 */
 
 -- 12 count number of order placed by each customer
 
 select c.name,count(o.customer_id)
 from customer c JOIN orders o ON c.id=o.customer_id
 group by o.id;
 
 -- output
 
 /*
 Jhon Doe	    1
Jane Smith	    1
Sarah Brown	    1
Robert Johnson	1
 */
 
 -- 13 find max order amount for each customer
 
 select c.name, max(o.total_price) as max_order_amount
 from customer c JOIN orders o ON c.id=o.customer_id
 group by c.id;
 
 -- output
 
 /*
 Jhon Doe	    900
Jane Smith	    300
Sarah Brown	    700
Robert Johnson	400  
 */
 
 -- 14 get customer who placed order amount over 1000
 
 select c.name, sum(o.total_price) as 'total_amount'
 from customer c JOIN orders o ON c.id=o.customer_id
 group by c.id
 having total_amount >1000;
 
 -- 15 find the product who not in the cart table
 
 select *
 from product
 where id NOT IN (select ca.product_id
                   from product p JOIN car ca ON ca.product_id=p.id
                   group by ca.product_id);
                   
-- OUTPUT
/*
1	Laptop	800	High_performance laptop 	 10
3	smartphone	600	latest smartphone	     15
5	tablet	700	portable tablet	             20
6	tv	500	4k smart tv	                     5
*/
	
 
 -- 16 find the customer who haven't placed order
 
 select *
 from customer
 where id NOT IN(
                select o.customer_id
				from customer c JOIN orders o ON c.id=o.customer_id
				group by o.id);
                
-- output

/*
5	David Lee	david@gmail	lee@04
*/

-- 18 find product with low stock

select p1.name,p1.stock_quantity
from product p1
where p1.stock_quantity = (select max(p2.stock_quantity)
                       from product p2);
                       
                       
-- or

select name,stock_quantity
from product 
order by stock_quantity desc
limit 1;
                       
                       -- output  tv	5
                       

                       
					
                    
														