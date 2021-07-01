
use air_quality_data;

select country_name, state_name, city_name, pollution_timestamp, aqi, mainus 
from pollution_event as pe 
join country as ct 
on ct.country_id = pe.country_id 
join state as s 
on s.state_id = pe.state_id
join city as cy 
on cy.city_id = pe.city_id;