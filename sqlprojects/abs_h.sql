use absenteeism_health; 

select * from absenteeism_at_work; 

show columns from absenteeism_at_work; 

alter table absenteeism_at_work rename column `Reason for absence` to reason_for_absence; 

alter table absenteeism_at_work rename column `Social drinker` to social_drinker;

alter table absenteeism_at_work rename column `Social smoker` to social_smoker; 

alter table absenteeism_at_work rename column `Body mass index` to body_mass_index; 

alter table absenteeism_at_work rename column `Month of absence` to month_of_absence;  

alter table absenteeism_at_work rename column `Absenteeism time in hours` to absenteeism_time_in_hours; 

select * from absenteeism_at_work a 
left outer join compensation b 
on a.ID = b.ID 
left outer join reasons r
on a.Reason_for_obsence = r.`Number`;

-- find the healthiest employees for the bonus 
select * from absenteeism_at_work 
where social_drinker = 0 and social_smoker = 0
and body_mass_index < 25
and absenteeism_time_in_hours < (select avg(absenteeism_time_in_hours) from absenteeism_at_work);

-- compensation rate increase for non_smokers / budget $983,221, so .68 increase per hour / $1,414 per year 
select count(*) as nonsmokers from absenteeism_at_work where social_smoker = 0; 

-- optimism the query
select a.ID, r.Reason, month_of_absence, body_mass_index, 
case 
	when body_mass_index < 18.5 then 'underweight' 
	when body_mass_index between 18.5 and 25 then 'healthy weight'
	when body_mass_index between 25 and 30 then 'overweight' 
	when body_mass_index > 30 then 'obyss'
else 'unknown' end as BMI_Category,
case
	when month_of_absence in(12,1,2) then 'winter'
    when month_of_absence in(3,4,5) then 'spring'
    when month_of_absence in(6,7,8) then 'summer'
    when month_of_absence in(9,10,11) then 'autumn'
else 'unknown' end as Season_Names
from absenteeism_at_work a
left join compensation b on a.ID = b.ID
left join Reasons r on a.reason_for_absence = r.`Number`;




 