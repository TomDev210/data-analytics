set foreign_key_checks =0 ;

create database if not exists loan_demo;
use loan_demo;

drop table if exists payments;
drop table if exists loan;
drop table if exists customers;

create table customers (
    customer_id int primary key,
    name varchar(100),
    age int,
    income bigint,
    city varchar(50),
    employment_type varchar(50)
);

create table loan (
    loan_id int primary key, 
    customer_id int,
    loan_amount bigint,
    interest_rate decimal(5,2),
    tenure_months int,
    loan_status varchar(20),
    disbursed_date date,
    foreign key(customer_id) references customers(customer_id)
);

create table payments (
    payment_id int primary key,
    loan_id int,
    payment_date date,
    amount_paid bigint,
    late_payment_flag tinyint(1),
    foreign key (loan_id) references loan(loan_id)
);

set global local_infile = 1;
show variables like 'local_infile'; 

load data local infile 'C:/Users/ELCOT/Downloads/customers.csv'
into table customers
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines
(customer_id,name,age,income,city,employment_type);

Select * from customers limit 5;

load data local infile'C:/Users/ELCOT/Downloads/loans.csv'
into table loan
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines
(loan_id,customer_id,loan_amount,interest_rate,tenure_months,loan_status,@disbursed_date)
set disbursed_date = STR_TO_DATE(@disbursed_date, '%d-%m-%Y');

select * from loan limit 5;

load data local infile 'C:/Users/ELCOT/Downloads/payments.csv'
into table payments
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines
(payment_id,loan_id,@payment_date,amount_paid,late_payment_flag)
set payment_date = STR_TO_DATE(@payment_date, '%d-%m-%Y');

select * from payments limit 5;

set foreign_key_checks = 1;

