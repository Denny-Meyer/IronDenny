select * from sakila.actor where actor_id = (
	select actor_id from sakila.film_actor where film_id = (
		select film_id from sakila.film where title = 'Alone trip'
	)
);

select concat(first_name,' ',last_name) as Actor_name from actor 
where
	actor_id in (
select actor_id from sakila.film_actor
inner join
	sakila.film
using(film_id)
	where film_id = (select film_id from sakila.film where title = 'Alone trip')
);

# film category
# film names

select * from film
where film_id in (
select film_id from film_category where category_id = 
(select category_id from category
where name = 'Family')
);

select concat(first_name,' ',last_name) as Name, email from customer where address_id in (
select address_id from address where city_id in (
select city_id from city where country_id = (
select country_id from country where country = 'canada')));

select first_name, last_name, email from city 
inner join 
	country
using (country_id)
inner join
	address
using (city_id)
inner join
	customer
using (address_id)
where country = 'canada';

### 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
