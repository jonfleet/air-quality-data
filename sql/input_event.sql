use air_quality_data;

begin transaction


Insert into country (country_name) values('United States');
Insert into state (state_name) values ('Pennsylvania');
Insert into city (city_name) values ('Pittsburgh');

Insert into pollution_event (country_id, state_id, city_id, pollution_timestamp, aqi, mainus)
values 
(
	(select country_id from country where country_name = 'United States'),
	(select state_id from state where state_name = 'Pennsylvania'),
	(select city_id from city where city_name = 'Pittsburgh'),
	GETDATE(),
	23,
	'n23'
);

select * from city;

select * from pollution_event;

select country_name, state_name, city_name, pollution_timestamp, aqi, mainus 
from pollution_event as pe 
join country as ct 
on ct.country_id = pe.country_id 
join state as s 
on s.state_id = pe.state_id
join city as cy 
on cy.city_id = pe.city_id;

rollback

delete pollution_event;
delete city;
delete country;
delete state;