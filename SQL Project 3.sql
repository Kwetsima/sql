use climate_change;
/* display all the data*/
select * from climate_change_impact_on_agriculture_2024;

/*Question1:Calculate Average Crop Yield by Country and Crop Type 
   Write a query to calculate the average crop yield (`Crop_Yield_MT_per_HA`) by `Country` and `Crop_Type` for each year.*/
create table Average_Crop_Yield(
select Country,Crop_type,Year,round(AVG(Crop_Yield_MT_per_HA),2) AS Average_Crop_Yield_MT_per_HA
from climate_change_impact_on_agriculture_2024
group by Country,Crop_type,Crop_Yield_MT_per_HA,Year);

/*question2:. Identify Countries with Extreme Weather Events 
   Write a query to list all `Country` and `Year` combinations where there were one or more `Extreme_Weather_Events`.*/
create table Weather_events(
SELECT Country,Year,Extreme_Weather_Events FROM climate_change_impact_on_agriculture_2024
where Extreme_Weather_Events > 0);

 /*question3:Find Top 5 Countries by CO2 Emissions
   Write a query to find the top 5 countries with the highest `CO2_Emissions_MT` in any given year.*/                                                                    
create table Top_5(
SELECT Year,Country, CO2_Emissions_MT FROM climate_change_impact_on_agriculture_2024
ORDER BY CO2_Emissions_MT  DESC
LIMIT 5);

/*question4:Calculate the Total Economic Impact of Extreme Weather Events per Region*/
create table total_Economic_Impact_Million_USD(
SELECT Region, round(sum(Economic_Impact_Million_USD),2) as total_Economic_Impact_Million_USD
from climate_change_impact_on_agriculture_2024 
where Extreme_Weather_Events
group by Region);

/*question5:5. List Countries with Irrigation Access Below 50%
   Write a query to find all countries where `Irrigation_Access_%` was below 50% for any given year.*/
create table Irrigation_Access(
select County,Year,`Irrigation_Access_%`
from climate_change_impact_on_agriculture_2024 
where `Irrigation_Access_%` < 50);

/*question6:. Find the Year with the Highest Fertilizer Use in a Specific Country 
   Write a query to identify the year with the highest `Fertilizer_Use_KG_per_HA` in a given country*/
create table Maximum_Fertilizer(
select MAX(Fertilizer_Use_KG_per_HA) as Max_Fertilizer_Use_KG_per_HA
from climate_change_impact_on_agriculture_2024
where Country = `Russia`
order by Fertilizer_Use_KG_per_HA);

/*question7:Compare Average Temperatures by Region Over the Last 5 Years 
   Write a query to calculate the average `Average_Temperature_C` for each `Region` over the last 5 years in the dataset.*/
create table Average_Temp(
select region, round(AVG(average_temperature_c),2) as avg_temperature
from climate_change_impact_on_agriculture_2024
where year >= year(curdate())-5
group by region);

 /*question9:Calculate the Total Pesticide and Fertilizer Use per Year for Each Country  
   Write a query to calculate the total `Pesticide_Use_KG_per_HA` and `Fertilizer_Use_KG_per_HA` for each `Country` per year.*/
create table Total_Pesticide_Use(
SELECT Country, YEAR as Year,
round(SUM(Pesticide_Use_KG_per_HA),2) as Total_Pesticide_Use,
round(SUM(Fertilizer_Use_KG_per_HA),2) as Total_Fertilizer_Use
FROM climate_change_impact_on_agriculture_2024
GROUP BY Country, YEAR);

/*question10:Analyze the Relationship Between Precipitation and Crop Yield  
    Write a query to investigate if there is a correlation between `Total_Precipitation_mm` and `Crop_Yield_MT_per_HA` across all countries and crop types.*/
create table correlation_coefficient(
SELECT 
 round((COUNT(*) * SUM(Total_Precipitation_mm * Crop_Yield_MT_per_HA) - SUM(Total_Precipitation_mm) * SUM(Crop_Yield_MT_per_HA)) /
    SQRT((COUNT(*) * SUM(Total_Precipitation_mm * Total_Precipitation_mm) - SUM(Total_Precipitation_mm) * SUM(Total_Precipitation_mm)) * 
          (COUNT(*) * SUM(Crop_Yield_MT_per_HA * Crop_Yield_MT_per_HA) - SUM(Crop_Yield_MT_per_HA) * SUM(Crop_Yield_MT_per_HA))),2) AS correlation_coefficient
FROM climate_change_impact_on_agriculture_2024); 