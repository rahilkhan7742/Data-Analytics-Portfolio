CREATE DATABASE EV_Population;
USE EV_Population;

SELECT * FROM electric_vehicle_population;

	DESCRIBE electric_vehicle_population;

SET SQL_SAFE_UPDATES = 1;


SELECT Make,Model,`Model Year`
FROM electric_vehicle_population
ORDER BY `Model Year` DESC
LIMIT 10;




SELECT Make,Model,`Model Year`
FROM electric_vehicle_population
WHERE Make = 'TESLA'
LIMIT 10;













USE EV_Population;



SELECT COUNT(*) FROM electric_vehicle_population; 




SELECT City, count(*) AS Total_EV
FROM electric_vehicle_population
GROUP BY City
ORDER BY Total_EV DESC
LIMIT 5;


SELECT Make, COUNT(*) AS Total_vehicles
FROM electric_vehicle_population
GROUP BY Make
ORDER BY Total_vehicles DESC
limit 5;








SET SQL_SAFE_UPDATES = 1;

USE EV_Population;



SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

UPDATE electric_vehicle_population
SET `Legislative District` = 0
WHERE `Legislative District` = '';

UPDATE electric_vehicle_population
SET `Electric Utility` = 'Not Specified'
WHERE `Electric Utility` = '';




-- Total EV Registrations Count
SELECT COUNT(*) AS total_ev_registrations 
FROM electric_vehicle_population;


-- Top 5 EV Manufacturers by Volume
SELECT Make, COUNT(*) AS total_vehicles
FROM electric_vehicle_population
GROUP BY Make
ORDER BY total_vehicles DESC
LIMIT 5;


-- EV Type Distribution (BEV vs PHEV)
SELECT `Electric Vehicle Type`, COUNT(*) AS total_count,
ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM electric_vehicle_population)), 2) AS percentage_share
FROM electric_vehicle_population
GROUP BY `Electric Vehicle Type`;


-- CAFV Eligibility Breakdown by Top Brands
SELECT 
    Make,
    COUNT(*) AS total_vehicles,
    SUM(CASE WHEN `Clean Alternative Fuel Vehicle (CAFV) Eligibility` LIKE '%Eligible%' THEN 1 ELSE 0 END) AS eligible_vehicles,
    ROUND(
        (SUM(CASE WHEN `Clean Alternative Fuel Vehicle (CAFV) Eligibility` LIKE '%Eligible%' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2
    ) AS cafv_eligibility_rate
FROM electric_vehicle_population
GROUP BY Make
HAVING COUNT(*) > 1000
ORDER BY total_vehicles DESC;


-- Average Electric Range Comparison: BEV vs PHEV
SELECT 
    `Electric Vehicle Type`,
    ROUND(AVG(`Electric Range`), 2) AS avg_electric_range,
    MAX(`Electric Range`) AS max_electric_range
FROM electric_vehicle_population
WHERE `Electric Range`> 0
GROUP BY `Electric Vehicle Type`;


-- Top 3 Most Popular EV Models for Each Top Manufacturer
WITH RankedModels AS (
    SELECT Make,Model,
        COUNT(*) AS vehicle_count,
        DENSE_RANK() OVER (PARTITION BY Make ORDER BY COUNT(*) DESC) AS model_rank
    FROM electric_vehicle_population
    GROUP BY Make, Model
)
SELECT 
    Make, 
    Model, 
    vehicle_count, 
    model_rank
FROM RankedModels
WHERE model_rank <= 3 AND Make IN ('TESLA', 'NISSAN', 'CHEVROLET', 'FORD', 'BMW')
ORDER BY Make, model_rank;


-- High-Density EV Adoption Counties & Top Preferred Brand
WITH CountyStats AS (
    SELECT County,COUNT(*) AS total_evs
    FROM electric_vehicle_population
    WHERE County IS NOT NULL
    GROUP BY County
),
CountyTopBrand AS (
    SELECT 
        County,
        Make,
        COUNT(*) AS brand_count,
        ROW_NUMBER() OVER (PARTITION BY County ORDER BY COUNT(*) DESC) AS rn
    FROM electric_vehicle_population
    WHERE County IS NOT NULL
    GROUP BY County, Make
)
SELECT 
    cs.County,
    cs.total_evs,
    ctb.Make AS dominant_brand,
    ctb.brand_count AS dominant_brand_evs
FROM CountyStats cs
JOIN CountyTopBrand ctb ON cs.County = ctb.County AND ctb.rn = 1
ORDER BY cs.total_evs DESC
LIMIT 10;



 






















SELECT Make, COUNT(*) AS Total_cars
FROM electric_vehicle_population
GROUP BY Make
HAVING COUNT(*) > 5000;




 SELECT `VIN (1-10)`,Make,Model,`Electric Range`
 FROM electric_vehicle_population
 WHERE`Electric Range` > (SELECT AVG(`Electric Range`) FROM electric_vehicle_population
						  WHERE `Electric Range` > 0)
                       ORDER BY `Electric Range` DESC;
                       
                       
                       
                       
                       
  WITH BrandSummary AS (
    SELECT Make, COUNT(`VIN (1-10)`) AS Total_Vehical,
    ROUND(AVG(`Electric Range`), 2) AS Avg_Range
    FROM electric_vehicle_population
    GROUP BY Make
  )
   SELECT Make,Total_Vehical,Avg_Range
   FROM BrandSummary
   WHERE Total_Vehical > 5000
   ORDER BY Total_Vehical DESC;
   
   
   
   
   
   WITH BrandTotal AS (
      SELECT Make, count(`VIN (1-10)`) AS Brand_cars
      FROM electric_vehicle_population
      GROUP BY Make
   )
    SELECT Make, Brand_cars,
    SUM(Brand_cars) OVER () AS Total_ev_market,
    ROUND((Brand_cars * 100.0 / SUM(Brand_cars) OVER ()),2 ) AS Market_share_pct
    FROM BrandTotal
    ORDER BY Brand_cars DESC;
   
   
   
   
   WITH YearlyTotals AS (
     SELECT `Model Year`, COUNT(`VIN (1-10)`) AS current_years_cars
     FROM electric_vehicle_population
     GROUP BY `Model Year`
   )
    SELECT `Model Year`,current_years_cars,
    LAG(current_years_cars, 1) OVER (ORDER BY `Model Year`) AS Previous_years_cars,
    (current_years_cars - LAG(current_years_cars, 1) OVER (ORDER BY `Model Year`)) AS YoY_Growth_count
    FROM YearlyTotals
    ORDER BY `Model Year` DESC;
   
   











              
                
                



  
WITH YearlyBrandSales AS (
      SELECT `Model Year`,Make, COUNT(`VIN (1-10)`) AS total_vehicles
      FROM electric_vehicle_population
      GROUP BY `Model Year`,Make
      ),
      RankedBrands AS (
      SELECT `Model Year`,Make,total_vehicles,
      DENSE_RANK() OVER (PARTITION BY `Model Year` ORDER BY total_vehicles DESC ) AS Brand_rank,
      SUM(total_vehicles) OVER (PARTITION BY `Model Year`) AS total_year_evs
      FROM YearlyBrandSales
      )
      SELECT `Model Year`,Brand_rank,Make,total_vehicles,
      ROUND((total_vehicles * 100.0 / total_year_evs), 2) AS market_share_pct
      FROM RankedBrands
      WHERE brand_rank <= 3
      ORDER BY `Model Year` DESC, brand_rank ASC;
      
      
      
      









