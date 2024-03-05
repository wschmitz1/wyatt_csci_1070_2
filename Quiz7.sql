Select * 
From payment
where amount >= 9.99;

Select MAX(amount)
from payment

--  Films with max $11.99 rental price.
--  8831, 3973, 4383, 16040, 11479, 14763, 15415, 14759

select first_name, last_name, email, address, city, country 
from staff s left join address a on s.address_id = a.address_id
left join city c on a.city_id = c.city_id
left join country cc on c.country_id = cc.country_id

first_name, last_name, email, address, city, country 
-- I am currently working in the Aerospace industry. 
-- I would like to stay in this industry long-term.
-- But would like to shift to more of an analyst
-- or SW engineer down the road. 
