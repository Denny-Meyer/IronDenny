use sakila;

# 1. Write a query to display for each store its store ID, city, and country.
select s.store_id, a.address, ci.city, co.country
from
	address as a
inner join
	store as s
using 
	(address_id)
inner join
	city as ci
using 
	(city_id)
inner join
	country as co
using 
	(country_id);


# 2. Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) as 'Total amount in $'
from 
	store
inner join
	staff
using
	(store_id)
inner join
	payment
using
	(staff_id)
group by
	store_id;


# 3. What is the average running time(length) of films by category?
select cat.name as Category, avg(f.length) as 'average movie length'
from
	film_category
inner join
	category as cat
using (category_id)
inner join
	film as f
using (film_id)
group by
	cat.name
order by
	avg(f.length) desc;


# 4. Which film categories are longest(length)?
select cat.name as Category, max(f.length) as 'maximum movie length'
from
	film_category
inner join
	category as cat
using (category_id)
inner join
	film as f
using (film_id)
group by
	cat.name
order by
	max(f.length) desc;


# 5. Display the most frequently(number of times) rented movies in descending order.
select title as 'Movie title', count(rental_id) as 'rented in times'
from
	inventory
inner join
	film
using (film_id)
inner join
	rental
using (inventory_id)
group by
	title
order by
	count(rental_id) desc;


# 6. List the top five genres in gross revenue in descending order.
select name, (sum(amount) - replacement_cost) as revenue
from 
	film
inner join
	film_category
using (film_id)
inner join
	category
using (category_id)
inner join
	inventory
using (film_id)
inner join
	rental
using (inventory_id)
inner join
	payment
using (rental_id)
group by
	name, replacement_cost
order by
	(sum(amount) - replacement_cost) desc;

	
# 7. Is "Academy Dinosaur" available for rent from Store 1?
select store_id, title as 'Movie name', count(store_id) as 'available '
from
	store
left join
	inventory
using (store_id)
left join
	film
using (film_id)
where
	title = 'Academy Dinosaur' and store_id = 1
group by
	title
order by
	store_id;
   


