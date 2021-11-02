use sakila;

# 1. Which actor has appeared in the most films?
select count(f.actor_id) as movie_count, concat(a.first_name, ' ', a.last_name) as name
from 
	film_actor as f
inner join
	actor as a
on
	f.actor_id = a.actor_id
group by
	f.actor_id
order by
	movie_count desc
limit 1;


# 2. Most active customer (the customer that has rented the most number of films)
select count(r.customer_id) as rent_count, concat(c.first_name,' ', c.last_name) as name
from
	rental as r
inner join
	customer as c
on
	r.customer_id = c.customer_id
group by
	r.customer_id
order by
	count(r.customer_id) desc;


# 3. List number of films per category.

select count(c.category_id) as category_count, c.name as name
from
	film_category as f
inner join
	category as c
on
	f.category_id = c.category_id
group by
	c.category_id
order by
	count(c.category_id) desc;


# 4. Display the first and last names, as well as the address, of each staff member.
select concat(first_name, ' ', last_name) as name, address, district, postal_code
from
	staff as s
inner join
	address as a
on
	s.address_id = a.address_id;


# 5. Display the total amount rung up by each staff member in August of 2005.
select sum(p.amount) as Total_amount, concat(s.first_name, ' ', s.last_name) as Name
from 
	payment as p
inner join
	staff as s
on 
	p.staff_id= s.staff_id
where 
	payment_date like '2005-08-%'
	#payment_date between '2005-08-00 00:00:00' and '2005-08-31 00:00:00'
group by
	Name;

# 6. List each film and the number of actors who are listed for that film.
select f.title as movie_title, count(a.actor_id) as number_of_actors
from
	film as f
left join
	film_actor as a
using (film_id)
group by
	title
order by
 count(a.actor_id) desc;
	

# 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer.
# List the customers alphabetically by last name. Bonus: Which is the most rented film? 
# The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
select concat(c.first_name,' ',c.last_name) as name,  sum(p.amount) as Total_amount
from 
	customer as c
inner join
	payment as p
using 
	(customer_id)
group by
	c.last_name, c.first_name
order by
	c.last_name;
    
select f.title, count(r.rental_id) 
from
	inventory as i
inner join
	rental as r
using (inventory_id)
inner join 
	film as f
using (film_id)
group by
	f.title
order by
	count(r.rental_id) desc
limit 1;

