# DATA CLEANING PROJECT
# The dataset has many duplicate values, null values, unnecessary coloumns.

# DELETING DUPLICATE VALUES 
create table layoffsv2 like layoffs;
ALTER TABLE layoffsv2
ADD COLUMN duplicate_indicator int ;

insert layoffsv2 
select *, row_number() over(
						partition by company, location, industry, total_laid_off,percentage_laid_off, 'date',stage,country,funds_raised_millions) as duplicate_indicator
 from layoffs;

select * from layoffsv2;

select * from layoffsv2
 where duplicate_indicator > 1;
 
delete from layoffsv2
 where duplicate_indicator > 1;
 
 create table layoffsv3 like layoffsv2;
 insert layoffsv3 
select * from layoffsv2;

ALTER TABLE layoffsv3
DROP COLUMN duplicate_indicator ;






# STANDARDIZATION OF DATA

UPDATE layoffsv3
SET COMPANY= TRIM(COMPANY);
#TAKE WHITESPACES AT THE END

SELECT DISTINCT INDUSTRY FROM layoffsv3 order by 1;
#'Crypto''Crypto Currency''CryptoCurrency' WE HAVE TO FIX IT

SELECT * FROM  layoffsv3 WHERE industry LIKE 'Crypto%';

update layoffsv3 SET INDUSTRY= 'Crypto'
					where industry LIKE 'Crypto%';

SELECT DISTINCT location FROM layoffsv3 order by 1; # SEEMS OKAY



SELECT DISTINCT country FROM layoffsv3 order by 1;
#United States United States. GOTTA FIX IT
update layoffsv3 SET COUNTRY= 'United States'
					where COUNTRY LIKE 'United States%';
                    
                    
                    
#FILL THE BLANK DATA WHERE IT IS FILLABLE

SELECT * FROM layoffsv3 WHERE 
						industry IS NULL OR industry= '';
#Airbnb 
#Bally's Interactive
#Carvana
#Juul

SELECT company,location, INDUSTRY 
FROM layoffsv3 WHERE COMPANY = 'Juul';
#GOT Consumer FROM ANOTHER ROW
UPDATE layoffsv3 SET INDUSTRY = 'Consumer' WHERE COMPANY = 'Juul';

SELECT company,location, INDUSTRY 
FROM layoffsv3 WHERE COMPANY = 'Carvana';
#GOT Transportation FROM ANOTHER ROW
UPDATE layoffsv3 SET INDUSTRY = 'Transportation' WHERE COMPANY = 'Carvana';

SELECT company,location, INDUSTRY 
FROM layoffsv3 WHERE COMPANY like 'Bally%';
#GOT Nothing

SELECT company,location, INDUSTRY 
FROM layoffsv3 WHERE COMPANY = 'Airbnb';
#GOT Travel FROM ANOTHER ROW
UPDATE layoffsv3 SET INDUSTRY = 'Travel' WHERE COMPANY = 'Airbnb';




#DELETING UNNECESSARY ROWS FOR LIKE NO DATA IN TOTAL LAYOFFS AND PERCENTAGE LAYOFFS
SELECT * FROM layoffsv3 
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM layoffsv3 
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;


#NOW THE DATA IS GOOD ENUGH TO WORK

select * from layoffsv3;


