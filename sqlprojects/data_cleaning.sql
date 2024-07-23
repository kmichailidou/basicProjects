use world_layoffs;

SELECT * FROM layoffs;

-- #### 

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT * FROM layoffs_staging;
INSERT layoffs_staging SELECT * FROM layoffs;

-- Remove duplictates

WITH duplicate_cte AS
(SELECT *, ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * FROM duplicate_cte WHERE row_num > 1; 

SELECT * FROM layoffs_staging WHERE company = "Casper";

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2 
SELECT *, ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2 WHERE row_num > 1;

DELETE FROM layoffs_staging2 WHERE row_num > 1;

SELECT * FROM layoffs_staging2; 

-- standarize the data

SELECT company, TRIM(company) FROM layoffs_staging2;

UPDATE layoffs_staging2 SET company = TRIM(company);

SELECT DISTINCT industry FROM layoffs_staging2 order by 1;

SELECT * from layoffs_staging2 where industry like 'Crypto%'; 

Update layoffs_staging2 set industry = 'Crypto' where industry like 'Crypto%';

select distinct country, trim(trailing '.' from country) 
from layoffs_staging2 where country like 'United States%';

update layoffs_staging2 set country = trim(trailing '.' from country) 
where country like 'United States%';


select `date`, str_to_date(`date`, '%m/%d/%Y') from layoffs_staging2;

update layoffs_staging2 set `date` = str_to_date(`date`, '%m/%d/%Y');
select `date` from layoffs_staging2;

alter table layoffs_staging2 modify column `date` date;


-- null values or blank 

select * from layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null;

select distinct industry from layoffs_staging2;

select * from layoffs_staging2 where industry is null or industry = '';

select * from layoffs_staging2 where company = 'Airbnb';

-- we do the join to the same table because we want to know if the industry is completely blank or not 
select * from layoffs_staging2 t1 
join layoffs_staging2 t2 
	on t1.company = t2.company 
	and t1.location = t2.location 
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

-- just the industry column 
select t1.industry, t2.industry
from layoffs_staging2 t1 
join layoffs_staging2 t2 
	on t1.company = t2.company 
	and t1.location = t2.location 
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


update layoffs_staging2 set industry = null where industry = ''; 


update layoffs_staging2 t1 
join layoffs_staging2 t2 
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;


select * from layoffs_staging2 where company like 'Bally%';


-- remove any columns or rows


select * from layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null;


delete from layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null;

alter table layoffs_staging2 drop column row_num;


