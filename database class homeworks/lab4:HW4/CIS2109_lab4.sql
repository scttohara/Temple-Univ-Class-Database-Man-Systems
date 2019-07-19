/*LAB4_
1)*/
SELECT TO_CHAR (SYSDATE, 'MM-DD-YYYY HH24:MI:SS') 
from dual;

/*2)*/
select distinct v.vendor_name
from vendors v inner join invoices i on v.vendor_id = i.vendor_id
where i.invoice_total > 10000;

/*3) distinct names*/
select distinct v.vendor_name
from vendors v inner join invoices i on v.vendor_id = i.vendor_id
where i.invoice_total > i.payment_total;

/*4)equijoins*/
select distinct v.vendor_name
from vendors v, invoices i
where v.vendor_id = i.vendor_id and i.invoice_total > i.payment_total
order by v.vendor_name;

/*4) inner join*/
select distinct v.vendor_name
from vendors v inner join invoices i on v.vendor_id = i.vendor_id
where i.invoice_total > i.payment_total;

/*4) natural join*/
select distinct v.vendor_name
from vendors v natural join invoices i
where i.invoice_total > i.payment_total;


/*5) A)*/
select i.title, od.order_id
from items i inner join order_details od on i.item_id = od.item_id;

/*5)B)*/
select i.title, count(od.item_id) 
from items i inner join order_details od on i.item_id = od.item_id
group by title;

/*5)C)*/
select i.title, count(od.item_id) 
from items i inner join order_details od on i.item_id = od.item_id
group by title
having count(od.item_id) > 5;

/*6) a)*/
select count(vendor_contact_first_name)
from vendors;

/*6) b)*/
select count(distinct vendor_contact_first_name)
from vendors;

/*6) C)*/
select vendor_contact_first_name
from vendors
group by vendor_contact_first_name
having count(vendor_contact_first_name) > 1;

/*7) 1.*/
select order_id
from customers c inner join orders o on c.customer_id = o.customer_id
where lower(c.customer_last_name) = 'blanca';

/*7) 2.*/
select customer_first_name, customer_last_name, order_id
from customers c left join orders o on c.customer_id = o.customer_id
where lower(c.customer_last_name) = 'blanca';

/*7) 3.*/
select customer_first_name, customer_last_name, nvl(order_id, 0)
from customers c left join orders o on c.customer_id = o.customer_id
where lower(c.customer_last_name) = 'blanca';

/*8*/
select customer_first_name, customer_last_name, count(order_qty)
from customers c left join orders o on c.customer_id = o.customer_id
                inner join order_details od on o.order_id = od.order_id
where lower(c.customer_last_name) = 'blanca'            
group by customer_first_name, customer_last_name;

/*9)*/
select customer_first_name, customer_last_name, count(order_qty)
from customers c left join orders o on c.customer_id = o.customer_id
                inner join order_details od on o.order_id = od.order_id            
group by customer_first_name, customer_last_name;

select customer_first_name, count(order_qty)
from customers c left join orders o on c.customer_id = o.customer_id
                inner join order_details od on o.order_id = od.order_id            
group by customer_first_name;

select customer_last_name, count(order_qty)
from customers c left join orders o on c.customer_id = o.customer_id
                inner join order_details od on o.order_id = od.order_id            
group by customer_last_name;
/*end of 9*/

/*10) 9 on paper...(whats a valid invoice?)
Find the vendor_name and the invoice_number for the vendors who have invoices, 
but only for those invoices that have valid invoicelines.
*/
select v.vendor_name, i.invoice_number
from vendors v inner join invoices i on v.vendor_id = i.vendor_id
               inner join invoice_line_items il on i.invoice_id = il.invoice_id; 

/*11) 10 on paper...(valid invoice lines?)
Find the vendor_id and the corresponding invoice_id for the vendors who have invoices,
even if these invoices do not have valid invoicelines.
*/
select v.vendor_id, i.invoice_id
from vendors v inner join invoices i on v.vendor_id = i.vendor_id
               left outer join invoice_line_items il on i.invoice_id = il.invoice_id;

/*12) 11 on paper...
Find the vendor_id and the corresponding invoice_id for all the vendors, 
even the ones with no invoices, even if these invoices do not have valid invoicelines.*/
select v.vendor_id, i.invoice_id
from vendors v left join invoices i on v.vendor_id = i.vendor_id
               left join invoice_line_items il on i.invoice_id = il.invoice_id;

/*13) A) 12 on paperA. Find the name and phone number of each vendor who has a cooperating vendor.
     Hint: the vendors for whom the field Cooperating_Vendor_id is not empty.*/

select vendor_name, vendor_phone
from vendors
where cooperating_vendor_id is not null;

/*13) B) cooperating vendors in same chart
 B. Now find additionally the name and phone number of the cooperating vendor. Present these two columns as: 
 ‘cooperating vendor’ and ‘cooperating vendor   phone’.
 
select e.employeename, e.employeebirthdate, m.employeename as manager, 
m.employeebirthdate as managerBirth
from employee_t e, employee_t m
where e.employeesupervisor = m.employeeid
and e.employeebirthdate < m.employeebirthdate
group by e.employeename, e.employeebirthdate, m.employeename, m.employeebirthdate;
*/
select v2.vendor_name, v2.vendor_phone, v1.vendor_name as cooperatingvendor, v1.vendor_phone as cooperatingvendorphone
from vendors v1, vendors v2
where v1.cooperating_vendor_id is not null
and v1.cooperating_vendor_id = v2.vendor_id;

/*13) C)
 C. Modify the above query to report all vendors. 
 If they are have a cooperating vendor, report their name if not report ‘N/A’.*/
select v1.vendor_name, v1.vendor_phone, 
nvl(v2.vendor_name, 'N/A')cooperatingvendor, 
nvl(v2.vendor_phone, 'N/A')cooperatingvendorphone
from vendors v1 left outer join vendors v2 on v1.cooperating_vendor_id = v2.vendor_id;

/*14) 1.Find the order date for all the orders of customers who leave in Los Angeles using joins
2. Repeat the same query this time using non-correlated subqueries
3. Repeat the same query this time using correlated subqueries with the IN statement
4. Repeat the same query this time using WHERE EXISTS
*/
select order_date
from customers c inner join orders o on c.customer_id = o.customer_id
where lower(c.customer_city) = 'los angeles';

/**/
select *
from  customers c
where c.customer_id = (select orders.customer_id
        from orders
        );

/**/
select *
from  customers c
where c.customer_id IN (select distinct customer_id
        from orders);












