/*6.60 List the customers who live in California or Washington. Order them by zip code, from high to low.*/
select customerstate, customerpostalcode
from CUSTOMER_T 
where customerstate LIKE 'CA' 
OR customerstate LIKE 'WA'
order by customerpostalcode DESC;

/*6.64 Display the product line ID and the average standard price for all products in each product line.*/
select productlineid, avg(productstandardprice) 
from PRODUCT_T
group by productlineid;
/*65 For every product that has been ordered, 
display the product ID and the total quantity ordered 
(label this result TotalOrdered). 
List the most popular product first and the least popular last.
*/
select productid, orderedquantity AS TotalOrdered
from orderline_t
order by orderedquantity DESC;

/*66 For each customer, list the CustomerID and total number of orders placed. */
select c.customer_id, od.order_qty
from customers c inner join orders o on c.customer_id = o.customer_id
        inner join order_details od on o.order_id = od.order_id
        /*where (customer_id*/
order by customer_id;

/*67 For each salesperson, display a list of CustomerIDs*/
select st.salespersonname, o.customerid
from salesperson_t st inner join order_t o 
ON st.salespersonid = o.salespersonid;

/*68
Display the product ID and the number of orders placed for each product. 
Show the results in decreasing order by the number of times 
the product has been ordered and label this result column NumOrders. 
*/
select od.productid, sum(od.orderedquantity) as numorders
from orderline_t od inner join product_t p on od.productid = p.productid
group by od.productid
order by sum(od.orderedquantity) desc;

/*70
For each salesperson, list the total number of orders. 
*/
select s.salespersonname, count(*) 
from salesperson_t s inner join order_t o 
                     on s.salespersonid = o.salespersonid
group by s.salespersonname;

/*71)
For each customer who had more than two orders, 
list the CustomerID and the total number of orders placed.
*/
select c.customerid, count(*)
from customer_t c inner join order_t o on c.customerid = o.customerid 
group by c.customerid
having count(*) > 2;

/*75)
Display the territory ID and the number of salespersons 
in the territory for all territories that have more than 
one salesperson. Label the number of salespersons NumSalesPersons.*/
select s.salesterritoryid, count(*) as numsalespersons
from salesperson_t s
group by s.salesterritoryid
having count(*) > 1;

/*79)
List ProductID, ProductDescription, ProductFinish, 
and ProductStandardPrice for oak products with a 
ProductStandardPrice greater than $400 or cherry 
products with a StandardPrice less than $300. 
Show how you constructed this query using a Venn diagram. 
*/
select productid, productdescription, productfinish, productstandardprice
from product_t 
where ((lower(productfinish) like 'oak' and productstandardprice > 400) 
OR (lower(productfinish) like 'cherry' and productstandardprice < 300));



        
    
    



