/*CIS2109 Lab 5*/
/*1) 1)*/
select od.order_id
from order_details od natural join items i
where i.artist = 'Burt Ruggles'
minus 
select od.order_id
from order_details od inner join items i on od.item_id = i.item_id
where i.item_id = 7;

/*1) 2)*/
select od.order_id
from order_details od natural join items i
where i.artist = 'Burt Ruggles'
intersect 
select od.order_id
from order_details od inner join items i on od.item_id = i.item_id
where i.item_id = 7;

/*1) 3)*/
select od.order_id
from order_details od natural join items i
where i.artist = 'Burt Ruggles'
union 
select od.order_id
from order_details od inner join items i on od.item_id = i.item_id
where i.item_id = 7;

/*1) 4)*/
select od.order_id
from order_details od natural join items i
where i.artist = 'Burt Ruggles'
union all
select od.order_id
from order_details od inner join items i on od.item_id = i.item_id
where i.item_id = 7;

/*2) */
select c.customer_id, sum(od.order_qty * i.unit_price) as total_amount
from customers c inner join orders o on c.customer_id = o.customer_id
                 inner join order_details od on o.order_id = od.order_id
                 inner join items i on od.item_id = i.item_id
group by c.customer_id
order by c.customer_id;

/*3)*/
select table1.customer_id, table1.total_amount, CASE 
                when table1.total_amount <= 50 then 'Very bad'
                when table1.total_amount between 51 and 100 then 'Bad'
                when table1.total_amount between 101 and 150 then 'OK'
                when table1.total_amount between 151 and 200 then 'Good'
                when table1.total_amount > 200 then 'Very good'
                end customer_status
from (select c.customer_id, sum(od.order_qty * i.unit_price) as total_amount
      from customers c inner join orders o on c.customer_id = o.customer_id
                       inner join order_details od on o.order_id = od.order_id 
                       inner join items i on od.item_id = i.item_id
group by c.customer_id
order by c.customer_id) table1; 

/*4)Create a new table named Customers_Statistics with the following columns:
Customer_id, Number_of_Orders, Number_of_Items

Complete the table definition by choosing the appropriate data types, primary and foreign keys.
*/
DROP TABLE Customers_Statistics;

create table Customers_Statistics (
Customer_id NUMBER(4) not null,
Number_of_Orders NUMBER(4), 
Number_of_Items  NUMBER(4),
PRIMARY KEY (Customer_id)
);
/*done, not screenshot yet*/
commit;
/*5)*/
select c.customer_id, nvl(count(table1.customer_id), 0) as order_count, 
nvl(sum(table2.order_qty), 0) as tot_items_bought
      from customers c left join (select order_id, customer_id
                       from orders
                       group by customer_id, order_id
                       ) table1 on c.customer_id = table1.customer_id 
                       left join (select order_id, order_qty
                       from order_details od
                       group by order_id, order_qty
                       ) table2 on table1.order_id = table2.order_id            
group by c.customer_id
order by c.customer_id; 
 
/*6)*/
INSERT into Customers_Statistics(Customer_id,Number_of_Orders, Number_of_Items)
select c.customer_id, nvl(count(table1.customer_id), 0) as order_count, 
nvl(sum(table2.order_qty), 0) as tot_items_bought
      from customers c left join (select order_id, customer_id
                       from orders
                       group by customer_id, order_id
                       ) table1 on c.customer_id = table1.customer_id 
                       left join (select order_id, order_qty
                       from order_details od
                       group by order_id, order_qty
                       ) table2 on table1.order_id = table2.order_id            
group by c.customer_id
order by c.customer_id; 

/*rollback;*/
commit;
/*6) part 2*/
alter table Customers_Statistics
add Customer_Status VARCHAR2(20);

/*7)*/
update Customers_Statistics SET customer_status = 'ok' where Number_of_Orders between 0 and 1;
update Customers_Statistics SET customer_status = 'good' where Number_of_Orders >= 2;
update Customers_Statistics SET customer_status = 'great' where Number_of_Orders > 5 
and Number_of_Items > 5;

/*8)*/
delete from Customers_Statistics where number_of_orders = 0;
/*commit;*/
/*EXTRA for 8) below*/
rollback;

/*9)*/
truncate TABLE customers_statistics;
/*EXTRA for 9) below*/
rollback;

/*10)*/
drop table customers_statistics;

commit;