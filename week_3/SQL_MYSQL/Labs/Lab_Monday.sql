
#
# Lab SQL Intro
#
use sakila;

# 2 all coloumn
show full tables;


# 3 get film title
select title from sakila.film;


# 4 Select one column from a table and alias it. 
# Get unique list of film languages under the alias language.
# Note that we are not asking you to obtain the language per each film,
# but this is a good time to think about how you might get that information in the future.
select city as stadt from city;
select distinct(name) from language;


# 5.1 Find out how many stores does the company have?
select count(store_id) from store;
# return 2, to get an overwiev about
select * from store;


# 5.2 Find out how many employees staff does the company have?
# overview
select * from staff;
select count(staff_id) from staff;

# 5.3 Return a list of employee first names only?
select first_name from staff;

#
#
# Lab SQL Queries
#
#

use bank;

# 1. Get the id values of the first 5 clients from district_id with a value equals to 1.
select * from client; # get overview
select client_id from client where district_id = 1 limit 5;

# 2. In the client table, get an id value of the last client where the district_id equals to 72.
select client_id from client where district_id = 72 order by client_id desc limit 1;


# 3. Get the 3 lowest amounts in the loan table.
select * from loan; # overview
select amount from loan order by amount limit 3;


# 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct(status) from loan order by status;


# 5. What is the loan_id of the highest payment received in the loan table?
select loan_id from loan order by payments desc limit 1;


# 6. What is the loan amount of the lowest 5 account_ids in the loan table?
#    Show the account_id and the corresponding amount
select amount from loan order by account_id limit 5;

# 7. What are the account_ids with the lowest loan amount that have a 
#    loan duration of 60 in the loan table?
select account_id from loan where duration = 60 order by amount limit 5;


# 8.
# What are the unique values of k_symbol in the order table?
# Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. 
# You have to use backticks to escape the order table name.
select distinct(k_symbol) from bank.order where length(k_symbol) > 1;
	# if not filtering by length(), some entries are empty


# 9.
# In the order table, what are the order_ids of the client with the account_id 34?
select order_id from bank.order where account_id = 34;


# 10.
# In the order table, which account_ids were responsible for orders 
# between order_id 29540 and order_id 29560 (inclusive)?
select distinct(account_id) from bank.order where order_id between 29540 and 29560;


# 11.
# In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select distinct(amount) from bank.order where account_to = 30067122;


# 12.
# In the trans table, show the trans_id, date, type and amount of the 10 first transactions 
# from account_id 793 in chronological order, from newest to oldest.
select trans_id, date, type, amount from trans where account_id = 793 order by date desc limit 10;


# 13.
# In the client table, of all districts with a district_id lower than 10, 
# how many clients are from each district_id? 
# Show the results sorted by the district_id in ascending order.
select district_id, count(client_id) from client where district_id < 10 group by district_id order by district_id;



# 14
# In the card table, how many cards exist for each type? 
# Rank the result starting with the most frequent type.
select type,count(type) from card group by type order by count(type) desc;


# 15
# Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select account_id, sum(amount) from loan group by account_id order by sum(amount) desc;


# 16
# In the loan table, retrieve the number of loans issued for each day, before (excl) 930907,
# ordered by date in descending order.
#select * from loan where date < 930907 order by date desc;
select date, count(loan_id) from loan where date < 930907 group by date order by date desc;


# 17
# In the loan table, for each day in December 1997,
# count the number of loans issued for each unique loan duration,
# ordered by date and duration, both in ascending order.
# You can ignore days without any loans in your output.
#select * from loan;
select distinct(date), duration, count(date) from loan where date between 971200 and 971231 group by date, duration order by date;


# 18
# In the trans table, for account_id 396, sum the amount of transactions
# for each type (VYDAJ = Outgoing, PRIJEM = Incoming). 
# Your output should have the account_id, the type and the sum of amount, named as total_amount.
# Sort alphabetically by type.
select account_id, type, sum(amount) from trans where account_id = 396 group by account_id, type;


# 19
# From the previous output, translate the values for type to English, 
# rename the column to transaction_type, round total_amount down to an integer

 select account_id, 
 replace(replace(type,'VYDAJ','Outgoing'),'PRIJEM','Incoming') as transaction_type,
 round(sum(amount))
 from trans 
 where account_id = 396 
 group by account_id, type 
 having type = 'VYDAJ' OR type = 'PRIJEM';
 
 
 # 20
 # From the previous result, modify your query so that it returns only one row, 
 # with a column for incoming amount, outgoing amount and the difference.

# create temporay variables
set @income=(select 
 round(sum(amount))
 from trans 
 where account_id = 396 
 group by account_id, type 
 having type = 'PRIJEM');

# dummy function, not needed already working in final sequel
#
#set @outcome=(select 
# round(sum(amount))
# from trans 
# where account_id = 396 
# group by account_id, type 
# having type = 'VYDAJ');
 
select 
	account_id, 
	@income as incoming_amount,
    round(sum(amount)) as outcoming_amount, 
    @income - round(sum(amount)) as difference 
from 
	trans 
where 
	account_id = 396
group by 
	account_id, 
	type
having 
	type = 'VYDAJ';


 # 21
 # Continuing with the previous example,
 # rank the top 10 account_ids based on their difference.
 
 # still open ^^ 
 
set @income=(select 
distinct(account_id),
 round(sum(amount))
 from trans 
 group by account_id, type 
 having type = 'PRIJEM');
	
 
 