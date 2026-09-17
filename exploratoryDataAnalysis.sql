#companies that laidoff 100 percentage of their employees

select * from layoffsv3 where layoffsv3.percentage_laid_off = 1; #115 companies

select * from layoffsv3
where layoffsv3.percentage_laid_off = 1
order by total_laid_off desc ;
#largest one is Katerra	SF Bay Area	Construction	2434


select * from layoffsv3
where layoffsv3.percentage_laid_off = 1
order by funds_raised_millions desc ;
#Britishvolt	London	Transportation	206	1	1/17/2023	Unknown	United Kingdom	2400

#companies with biggest laid offs
select company, sum(total_laid_off) from layoffsv3
group by company order by 2 desc;
#Amazon	18150 Google	12000 Meta	11000 Salesforce	10090 Microsoft	10000 Philips	10000

#layoffs by industry
select industry, sum(total_laid_off) from layoffsv3
group by industry order by 2 desc;
# consumer and retail got real hit Consumer	45182 Retail	43613


