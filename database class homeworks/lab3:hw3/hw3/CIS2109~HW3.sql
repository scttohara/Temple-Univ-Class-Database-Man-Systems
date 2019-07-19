/*DATABASE homework 3*/

/*7.42
Write an SQL command that will find any customers who have not placed orders.
*/
select c.customername
from customer_t c 
where not exists (select 1 
                    from order_t o
                    where c.customerid = o.customerid);
                    
/*7.43) 
List the names and number of employees supervised 
(label this value HeadCount) for each supervisor 
who supervises more than two employees.
*/
select m.employeename, count(e.employeesupervisor) as headcount
from employee_t e, employee_t m
where e.employeesupervisor = m.employeeid
group by m.employeename
having count(*) > 2;

/*7.44)
List the name of each employee, his or her birth date, 
the name of his or her manager, and the manager’s birth 
date for those employees who were born before their 
manager was born; label the manager’s data Manager and
ManagerBirth. Show how you constructed this query 
using a Venn or other type of diagram.
*/
select e.employeename, e.employeebirthdate, m.employeename as manager, 
m.employeebirthdate as managerBirth
from employee_t e, employee_t m
where e.employeesupervisor = m.employeeid
and e.employeebirthdate < m.employeebirthdate
group by e.employeename, e.employeebirthdate, m.employeename, m.employeebirthdate;

/*7.46
Write an SQL command to display each item ordered for 
order number 1, its standard price, and the total price 
for each item ordered.*/
select p.productdescription, p.productstandardprice, (o.orderedquantity * p.productstandardprice) as totalprice
from orderline_t o inner join product_t p on o.productid = p.productid
where o.orderid = 1;

/*7.47 Write an SQL command to total the cost of order number 1.*/
select sum(o.orderedquantity * p.productstandardprice) as total_cost_of_order1
from orderline_t o inner join product_t p on o.productid = p.productid
where o.orderid = 1;

/*7.49  For every order that has been received, display the order
ID, the total dollar amount owed on that order 
(you’ll have to calculate this total from attributes in one or more tables; 
label this result TotalDue), and the amount received in payments on that order 
(assume that there is only one payment made on each order). 
To make this query a little simpler, you don’t have to include those orders 
for which no payment has yet been received. List the results in decreasing 
order of the difference between total due and amount paid.*/
select ot.orderid, pt.paymentamount, 
sum(ot.orderedquantity * p.productstandardprice) totaldue
from orderline_t ot inner join product_t p on ot.productid = p.productid
                   inner join payment_t pt on ot.orderid = pt.orderid
where pt.paymentamount > 0
group by ot.orderid, pt.paymentamount
order by (totaldue - pt.paymentamount) DESC;


/*7.51 PROBLEM: no orders placed in march 2015??? march 10 done?
Write an SQL query to list each customer who bought at least one 
product that belongs to product line Basic in March 2015. 
List each customer only once.*/
select distinct c.customername
from customer_t c inner join order_t o on c.customerid = o.customerid
                  inner join orderline_t ol on o.orderid = ol.orderid
                  inner join product_t p on ol.productid = p.productid
                  inner join productline_t pl on p.productlineid = pl.productlineid
where lower(pl.productlinename) = 'basic' and (o.orderdate >= '01-MAR-10' and o.orderdate <= '31-MAR-10');


/*7.54
List, in alphabetical order, the names of all employees 
(managers) who are now managing people with skill ID BS12; 
list each manager’s name only once, even if that manager 
manages several people with this skill.
*/
select distinct m.employeename
from employee_t e inner join employee_t m on e.employeesupervisor = m.employeeid
                  inner join employeeskills_t es on e.employeeid = es.employeeid
where es.skillid = 'BS12'
order by m.employeename;

/*7.56 Write a query to list the number of products 
produced in each work center (label as TotalProducts). 
If a work center does not produce any products, display 
the result with a total of 0.*/
select w.workcenterid, count(productid) as totalproducts
from workcenter_t w left outer join producedin_t p on w.workcenterid = p.workcenterid
group by w.workcenterid;

/*7.58
Display the order IDs for customers who have not made any payment, 
yet, on that order. Use the set command UNION, INTERSECT, or MINUS in your query.*/
select orderid
from order_t 
minus (select p.orderid from payment_t p)
order by orderid;

/*7.65
Display the customer ID, name, and order ID for all customer orders. 
For those customers who do not have any orders, 
include them in the display once by showing order ID 0.
*/
select c.customerid, c.customername, nvl(o.orderid, 0)
from customer_t c left join order_t o on c.customerid = o.customerid;

/*7.67
Display the customer names of all customers 
who have ordered (on the same or different orders) 
both products with IDs 3 and 4
*/
select c.customername
from customer_t c inner join order_t o on c.customerid = o.customerid
                  inner join orderline_t ol on o.orderid = ol.orderid
where (ol.productid = 3 or ol.productid = 4);

/*7.69 List the IDs and names of all products that 
cost less than the average product price in their product line.*/
/*7.69 NOT right my first attempt*/
/*select productid, productlineid, average
from product_t p, 
where p.productlineid = (select avg(productstandardprice) as average from product_t)
order by productlineid;*/
/*Not right above
below is:
code i found online and edited*/
select p.productid, p.productdescription
from product_t p
inner join (
  select productlineid, avg(productstandardprice) p_line_average
  from product_t
  group by productlineid ) averages
on (averages.productlineid = p.productlineid 
and p.productstandardprice < averages.p_line_average);


/*7.73
Display in product ID order the product ID and total amount 
ordered of that product by the customer who has bought 
the most of that product; use a derived table in a 
FROM clause to answer this query.
*/
select  p.productid, p_max_or.m
from customer_t c inner join order_t o on c.customerid = o.customerid 
                  inner join orderline_t ot on o.orderid = ot.orderid
                  inner join product_t p on ot.productid = p.productid
                  inner join
                  (select productid, max(orderedquantity) m
                  from orderline_t 
                  group by productid
                  order by productid) p_max_or on p_max_or.productid = p.productid
group by p.productid, p_max_or.m
order by p.productid, p_max_or.m;
                  

