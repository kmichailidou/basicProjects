-- population table
select * from population;

select min(population_year), max(population_year) from population;

alter table population rename column population_entity to country;
alter table population rename column population_year to `year`;

select country, count(*) from population group by country order by country ASC; 

select distinct country from population  where country like '%(UN)%';

alter table population add column record_type varchar(100);

update population set record_type = 'Continent' where country like '%(UN)%'; 


/* 
 * countries that have not been updated yet
 * 
 * */
select distinct country from population where record_type is null;

update population set record_type = 'Category' where country in ( 
'High-income countries',
'Land-locked developing countries (LLDC)',
'Least developed countries',
'Less developed regions',
'Less developed regions, excluding China',
'Less developed regions, excluding least developed countries',
'Low-income countries',
'Lower-middle-income countries',
'More developed regions',
'Small island developing states (SIDS)',
'Upper-middle-income countries',
'World'
);

/* 
 * filling null values with country 
 * 
 * */
update population set record_type = 'Country' where record_type is null;



-- population_by_broad_age_group table 

alter table population_by_broad_age_group rename column Entity to country;
alter table population_by_broad_age_group rename column `Year` to `year`;
-- alter table population_by_broad_age_group rename column `65+ years` to `65_and_over`;

select country, count(*) from population_by_broad_age_group group by country order by country ASC; 

select distinct country from population_by_broad_age_group where country like '%(UN)%';

alter table population_by_broad_age_group add column record_type varchar(100);

update population_by_broad_age_group set record_type = 'Continent' where country like '%(UN)%';

select distinct country from population_by_broad_age_group where record_type is null;

update population_by_broad_age_group set record_type = 'Category' where country in ( 
'High-income countries',
'Land-locked developing countries (LLDC)',
'Least developed countries',
'Less developed regions',
'Less developed regions, excluding China',
'Less developed regions, excluding least developed countries',
'Low-income countries',
'Lower-middle-income countries',
'More developed regions',
'Small island developing states (SIDS)',
'Upper-middle-income countries',
'World'
);


update population_by_broad_age_group set record_type = 'Country' where record_type is null;

/*
 * what is 90 and above for each country in the latest year?
 * 
 * */
-- select * from population where `year` = 2023 and record_type = 'Country' order by country ASC;


/* 
 * which countries heave the highest population growth in the last year? 
 * 
 * */
select 
country,
population_2022,
population_2023,
population_2023 - population_2022 as pop_growth_num,
(population_2023 - population_2022)/ population_2022 as pop_growth_pct
from(  
	select 
	p.country,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2022
	
	) as population_2022,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2023
	
	) as population_2023 
	from population p 
	where p.record_type = 'Country'
	and p.`year` = 2022
) s
order by pop_growth_num DESC;


/* 
 * which single country has the highest population decline in the last year?
 * 
 * */
select 
country,
population_2022,
population_2023,
population_2023 - population_2022 as pop_growth_num,
(population_2023 - population_2022)/ population_2022 as pop_growth_pct
from(  
	select 
	p.country,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2022
	
	) as population_2022,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2023
	
	) as population_2023 
	from population p 
	where p.record_type = 'Country'
	and p.`year` = 2022
) s
order by pop_growth_num asc
limit 1; -- just to show the one country for the highest decline in population


/* 
 *  which age group had the highest population out of all countries last year? 
 * 
 * */

select 
sum(`0-4 years`),
sum(`5-14 years`),
sum(`15-24 years`),
sum(`25-64 years`),
sum(`65+ years`) 
from population_by_broad_age_group
where country = 'World' and `year` = 2023;


-- select count(country) from population_by_broad_age_group where country = 'Greece'; 


/* 
 *  what are the top 10 countries with the highest population growth in the last 10 years? 
 * 
 * */
select 
country,
population_2011,
population_2023,
population_2023 - population_2011 as pop_growth_num,
from(  
	select 
	p.country,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2011
	
	) as population_2011,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2023
	
	) as population_2023 
	from population p 
	where p.record_type = 'Country'
	and p.`year` = 2022
) s
order by pop_growth_num asc
limit 10;


-- which country has the highest percentage growth since the first year recorded?
create view population_by_year as
select 
country,
population_1950,
population_2011,
population_2020,
population_2023,
population_2023 - population_2011 as pop_growth_num,
from(  
	select 
	p.country,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 1950
	
	) as population_1950,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2011
	
	) as population_2011,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2020
	
	) as population_2020,
	(
		select p1.population_all
		from population p1
		where p1.country = p.country
		and p1.`year` = 2023
	
	) as population_2023 
	from population p 
	where p.record_type = 'Country'
	and p.`year` = 2022
) s
order by pop_growth_num asc
limit 10;

select country, 
population_1950, 
population_2023, 
(population_2023 - population_1950)/ population_1950 as pop_growth_pct 
from population_by_year
order by pop_growth_pct desc;

/* 
 * what is the population of each continent in each year and how much has it changed in each year? 
 * 
 * */

select country,
`year`,
population_all,
lag(population_all, 1) over(
	partition by country 
	order by `year` asc
) as population_change 
from population 
where record_type = 'Continent'
order by country asc, `year` asc;



