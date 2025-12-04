use loan_demo;

Select * from customers;
Select * from loan;
Select * from payments;

-- Find total number of customers
select count(*) as total_customers from customers;

-- Total loan amount disbursed (only Approved loans)
select count(*) as count_disbusted ,sum(loan_amount) as total_disbusted from loan 
where loan_status = 'Approved';

-- Count of Approved vs Rejected loans
select loan_status , count(*) as count_loan 
from loan group by loan_status;

-- List customers who applied for loans but got rejected
select c.customer_id, c.name, l.loan_amount
from customers c join loan l on c.customer_id = l.customer_id
where l.loan_status = 'Rejected';

-- Loans disbursed in the last 1 year
select * from loan
where disbursed_date >= curdate() - interval 1 year;

-- Find customers with NO payments made
select c.customer_id, c.name
from customers c join loan l on c.customer_id = l.customer_id
left join payments p on l.loan_id = p.loan_id
where p.payment_id is null;

-- Find customers with Late Payments
select distinct c.customer_id, c.name
from customers c join loan l on c.customer_id = l.customer_id
join payments p on l.loan_id = p.loan_id
where p.late_payment_flag = 1;

-- Count loans issued month-wise
select date_format(disbursed_date, '%Y-%m') as month_name, count(*) as total_loans
from loan group by date_format(disbursed_date, '%Y-%m')
order by month_name;

-- Average loan amount by employment type
select c.employment_type, avg(l.loan_amount) as avg_loan
from customers c join loan l on c.customer_id = l.customer_id
group by  c.employment_type;

-- Top 5 highest loan amounts with customer details
select l.loan_id, c.name,c.employment_type, c.city, l.loan_amount
from loan l join customers c on l.customer_id = c.customer_id
where l.loan_status = 'Approved'
order by l.loan_amount desc limit 5;

-- Find customers with multiple loans
select c.customer_id, c.name, COUNT(l.loan_id) as total_loans
from customers c join loan l on c.customer_id = l.customer_id
group by c.customer_id, c.name
having COUNT(l.loan_id) >1;

-- Identify high-value customers (Income > 10L & Approved loans > 5L)
select distinct c.customer_id, c.name, c.income
from customers c join loan l on c.customer_id = l.customer_id
where c.income > 1000000 and l.loan_amount > 500000 and l.loan_status = 'Approved';

-- Find customers whose loan amount is more than their annual income
select c.customer_id, c.name, c.income, l.loan_amount
from customers c join loan l on c.customer_id = l.customer_id
where l.loan_amount > c.income;

-- Find the city with the highest approved loan amount
select c.city, sum(l.loan_amount) as total_loan
from customers c join loan l on c.customer_id = c.customer_id
where l.loan_status = 'Approved' group by c.city
order by total_loan desc limit 1;



