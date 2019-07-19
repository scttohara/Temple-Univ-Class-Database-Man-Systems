select title, unit_price AS old_price, unit_price*0.8 AS New_Price
from ITEMS ;

select MAX(unit_price)
from ITEMS;

select count(*)
from ORDER_DETAILS;

select count(*)
from ORDER_DETAILS
where item_id = 1;

select TITLE, ARTIST
from ITEMS
where ARTIST LIKE '%&%';

select customer_first_name, customer_last_name
from CUSTOMERS
where customer_fax is null;

select customer_last_name, customer_first_name 
from CUSTOMERS
Order by customer_last_name ASC , customer_first_name DESC;

select customer_last_name, customer_address 
from CUSTOMERS
where customer_state IN 'CA'
and LOWER(customer_city) < 'new york';

select customer_last_name, customer_first_name, customer_state, customer_city
from CUSTOMERS
where customer_state IN 'CA'
and (LOWER(customer_city) < 'new york'
or lower(customer_first_name) like 'a%');

select customer_last_name, customer_first_name, customer_state, customer_city
from CUSTOMERS
where customer_state IN 'CA'
and LOWER(customer_city) < 'new york'
and lower(customer_first_name) like 'a%';

select invoice_id, invoice_total
from INVOICES
where invoice_total > 600 
and invoice_total < 700;

select invoice_id, invoice_total
from INVOICES
where invoice_total between 600 and 700;

select customer_last_name, customer_first_name, customer_state, customer_city
from CUSTOMERS
where customer_state IN 'CA'
and LOWER(customer_city) < 'new york'
and lower(customer_first_name) like 'a%';

select invoice_id, invoice_total
from INVOICES
where invoice_total > 600 
and invoice_total < 700;

select invoice_id, invoice_total
from INVOICES
where invoice_total between 600 and 700;

/* question 12 not sure which way to answer*/
select DISTINCT i.vendor_id
from INVOICES i INNER join vendors v
ON i.vendor_id = v.vendor_id;

select DISTINCT i.vendor_id
from INVOICES i;


/*question 13) 1)*/
select vendor_contact_first_name AS first, vendor_contact_last_name AS last 
from VENDORS 
where lower(vendor_contact_first_name) LIKE 'c%'
order by vendor_contact_first_name, vendor_contact_last_name;

/*13 2)*/
select vendor_contact_first_name AS first, vendor_contact_last_name AS last 
from VENDORS 
where lower(vendor_contact_first_name) LIKE 'c%'
order by vendor_contact_first_name, vendor_contact_last_name DESC;

/*13 3)*/
select vendor_contact_last_name AS last, vendor_contact_first_name AS first 
from VENDORS 
where lower(vendor_contact_first_name) LIKE 'c%'
order by vendor_contact_last_name, vendor_contact_first_name;

/*14)*/
select customer_first_name, (NVL(customer_fax, 9999999999)) 
from CUSTOMERS;

/*15)*/
select SUBSTR(customer_first_name, 0, 1), customer_last_name
from customers;

/*16)*/
select concat(concat(substr(customer_first_name, 0, 1), '.'), concat(' ',customer_last_name)) AS full_name
from customers;

/*17*/
select artist, price 
from items, (select avg(unit_price) as price from items) 
group by artist, price;

/*avg(unit_price) AS avg_unit_price from items)*/

/*18*/
select order_id, count(order_qty)
from order_details 
group by order_id;

/*19*/
select customer_state, count(*) as State_Ordering
from customers
group by customer_state
order by State_Ordering DESC;

/*20*/
select customer_state, count(*) as State_Ordering
from customers
group by customer_state
having count(*) > 1
order by State_Ordering DESC





