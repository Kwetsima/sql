use covid_19;
/*display all the data*/
select * from covid_19;

/*This query aggregates the total confirmed cases by country, orders the result in descending order.*/
create table con_cases
SELECT 
    `Country/Region`, 
    SUM(confirmed) AS total_confirmed
FROM 
    covid_19
GROUP BY 
   `Country/Region`
ORDER BY 
    total_confirmed DESC
    limit 10;
    
    /*This query sums the total deaths by country, ordering the results by the highest death counts first.*/
    create table death
    SELECT 
   `Country/Region`, 
    SUM(Deaths) AS total_deaths
FROM 
    covid_19
GROUP BY 
 `Country/Region`
ORDER BY 
    total_deaths DESC
    limit 10;
    
    /*This query sums the total recoveries by country, ordering the results by the highest recovery counts first.*/
    create table recoveries
    SELECT 
     `Country/Region`,
    SUM(recovered) AS total_recovered
FROM 
    covid_19
GROUP BY 
    `Country/Region`
ORDER BY 
    total_recovered DESC
    limit 10;
    
    /*This query aggregates the total active cases by country, ordered by the highest number of active cases.*/
    create table active
    SELECT 
    `Country/Region`,
    SUM(active) AS total_active_cases
FROM 
    covid_19
GROUP BY 
   `Country/Region`
ORDER BY 
    total_active_cases DESC
    limit 10;
    
    /*This query calculates the weekly change and percentage change in confirmed cases by comparing the previous week’s confirmed cases to the current week’s new cases.*/
    create table new 
    SELECT 
`Country/Region`, 
    SUM(`confirmed last week`) AS confirmed_last_week, 
    SUM(`new cases`) AS new_cases_this_week, 
    (SUM(`new cases`) - SUM(`confirmed last week`)) AS week_change, 
    ROUND(((SUM(`new cases`) - SUM(`confirmed last week`)) / SUM(`confirmed last week`)) * 100, 2) AS week_percent_change
FROM 
    covid_19
GROUP BY 
    `Country/Region`
ORDER BY 
    week_percent_change DESC
    limit 10;
    
    /*This query provides a detailed comparative analysis by grouping data by both country and WHO region, including key metrics and rates.*/
    create table compare
    SELECT 
    `Country/Region`, 
    `WHO Region`, 
    SUM(confirmed) AS total_confirmed, 
    SUM(Deaths) AS total_deaths, 
    SUM(recovered) AS total_recovered, 
    SUM(`New cases`) AS total_new_cases, 
    SUM(`New deaths`) AS total_new_deaths, 
    SUM(`New recovered`) AS total_new_recovered,
    ROUND(SUM(Deaths) / SUM(confirmed) * 100, 2) AS death_rate_per_100_cases,
    ROUND(SUM(recovered) / SUM(confirmed) * 100, 2) AS recovery_rate_per_100_cases,
    ROUND(AVG(`1 week % increase`), 2) AS avg_week_percent_change
FROM 
    covid_19
GROUP BY 
    `Country/Region`, 
    `WHO Region`
ORDER BY 
    total_confirmed DESC
    limit 10;
    
    /*This query provides a detailed comparative analysis by grouping data by both country and WHO region, including key metrics and rates.*/
  CREATE TABLE comp AS
    SELECT 
        `Country/Region`, 
        SUM(Deaths) AS total_deaths_last_week, 
        SUM(`New deaths`) AS total_new_deaths, 
        ROUND(ABS((SUM(`New deaths`) - SUM(Deaths)) / NULLIF(SUM(Deaths), 0)) * 100, 2) AS `1 Week % Increase in Deaths`
    FROM 
        covid_19
    GROUP BY 
        `Country/Region`
    ORDER BY 
        `1 Week % Increase in Deaths` DESC
    LIMIT 10;