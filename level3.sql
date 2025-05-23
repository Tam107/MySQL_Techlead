use sakila;

-- level 3
-- 1. Write a SQL query to return the average rental duration for each combination of actor and category in the database,
-- excluding actors who have not appeared in any films in a category.
select * from actor, film_actor, film, film_category, category;

Select concat(a.first_name, ' ', a.last_name) as actor_name, c.name as category_name 
, ROUND(avg(f.rental_duration), 2) as avg_rental_duration from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by a.actor_id, c.category_id 
order by actor_name, category_name;

-- 2. Write a SQL query to return the names of all actors who have appeared 
-- in a film with a rating of 'R' and a length of more than 2 hours, but have never appeared in a film with a rating of 'G'.
select * from actor, film_actor, film;
select distinct concat(a.first_name, ' ', a.last_name) as actor_name from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id where f.rating = 'R' and f.rating != 'G' and f.length > 120;

-- 3. Write a SQL query to return the names of all customers who have rented more than
--  10 films in a single transaction along with the number of films they rented and the total rental fee.
select concat(c.first_name,' ', c.last_name) as customer_name, count(*) as film_count, sum(f.rental_rate) as total_rental_fee
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by c.first_name, c.last_name, date(r.rental_date)
having count(*) > 10
order by customer_name, film_count;
-- 4. Write a SQL query to return the names of all customers who have rented 
-- every film in a category, along with the total number of films rented and the total rental fee.
select concat(c.first_name,' ', c.last_name) as customer_name, count(*) as film_count, sum(f.rental_rate) as total_rental_fee
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by c.first_name, c.last_name, date(r.rental_date)
order by customer_name, film_count;



