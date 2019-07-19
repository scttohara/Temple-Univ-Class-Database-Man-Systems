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

/* question 12 not sure which way to answer
select DISTINCT i.vendor_id
from INVOICES i INNER join vendors v
ON i.vendor_id = v.vendor_id;

select DISTINCT i.vendor_id
from INVOICES i;
*/

select vendor_contact_last_name AS last, vendor_contact_first_name AS first
from VENDORS 
where lower(vendor_contact_first_name) LIKE 'c%'
order by vendor_contact_last_name, vendor_contact_first_name;