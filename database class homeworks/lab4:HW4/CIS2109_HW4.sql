/*7.55) first attempt
select s.salespersonname, p.productfinish, ot.orderedquantity as TotSales
from salesperson_t s inner join order_t o on s.salespersonid = o.salespersonid
                     inner join orderline_t ot on o.orderid = ot.orderid
                     inner join product_t p on ot.productid = p.productid
group by s.salespersonname, p.productfinish, ot.orderedquantity;
7.55)*/
select s.salespersonname, p.productfinish, sum(ot.orderedquantity) as TotSales
from salesperson_t s inner join order_t o on s.salespersonid = o.salespersonid
                     inner join orderline_t ot on o.orderid = ot.orderid
                     inner join product_t p on ot.productid = p.productid
group by s.salespersonname, p.productfinish;
/**/

/*7.57)*/
select c.customername, count(*) as numvendors
from customer_t c, salesperson_t s 
where c.customerstate = s.salespersonstate
group by c.customername;
                    


/*7.58)*/
select o.orderid
from customer_t c inner join order_t o on c.customerid = o.customerid
MINUS
select p.orderid
from payment_t p;


/*7.59)*/
select upper(c.customerstate)
from customer_t c 
minus
select upper(s.salespersonstate)
from salesperson_t s;

/*7.59 without MINUS, INTERSECT, UNION. ??no WHERE clause???*/
select upper(c.customerstate)
from customer_t c left join salesperson_t s on upper(c.customerstate) = 
upper(s.salespersonstate)
where s.salespersonstate is null
group by c.customerstate


