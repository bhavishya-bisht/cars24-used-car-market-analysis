
USE cars24;

SELECT * FROM used_cars limit 10 ;


-- columns in the movie table have null and blank values.
SELECT 
SUM(CASE WHEN manufacturer IS NULL OR TRIM(manufacturer) = '' THEN 1 ELSE 0 END) AS manufacturer_blank,
SUM(CASE WHEN Variant IS NULL OR TRIM(Variant) = '' THEN 1 ELSE 0 END) AS variant_blank,
SUM(CASE WHEN Details IS NULL OR TRIM(Details) = '' THEN 1 ELSE 0 END) AS details_blank,
SUM(CASE WHEN India_Location IS NULL OR TRIM(India_Location) = '' THEN 1 ELSE 0 END) AS location_blank,
SUM(CASE WHEN Model IS NULL OR TRIM(Model) = '' THEN 1 ELSE 0 END) AS model_blank,
SUM(CASE WHEN Distance_Travelled IS NULL OR TRIM(Distance_Travelled) = '' THEN 1 ELSE 0 END) AS distance_blank,
SUM(CASE WHEN Fuel_Type IS NULL OR TRIM(Fuel_Type) = '' THEN 1 ELSE 0 END) AS fuel_blank,
SUM(CASE WHEN Engine_Capacity IS NULL OR TRIM(Engine_Capacity) = '' THEN 1 ELSE 0 END) AS engine_blank,
SUM(CASE WHEN Transmission IS NULL OR TRIM(Transmission) = '' THEN 1 ELSE 0 END) AS transmission_blank,
SUM(CASE WHEN Price_INR IS NULL THEN 1 ELSE 0 END) AS price_blank
FROM used_cars;

SELECT * FROM used_cars
WHERE price_INR IS NULL;



select * from used_cars;

-- Add Car_Age column 
UPDATE used_cars
SET Car_Age = YEAR(CURDATE()) - model;




SELECT DISTINCT manufacturer
FROM used_cars
ORDER BY manufacturer;

SELECT manufacturer, COUNT(*) AS total
FROM used_cars
GROUP BY manufacturer
ORDER BY total ASC;
USE cars24;
SELECT *
FROM used_cars
WHERE manufacturer IN ('Land Rover');

UPDATE used_cars
SET manufacturer = 'Land Rover'
WHERE manufacturer IN ('Land','Range');

SELECT *
FROM used_cars
WHERE manufacturer IN ('Classic','Others');

UPDATE used_cars
SET manufacturer = 'Unknown'
WHERE manufacturer IN ('Others','Classic');

-- Identifying Issues in the Variant Column
SELECT COUNT(*) 
FROM used_cars
WHERE variant IS NULL OR TRIM(variant) = '';

SELECT manufacturer, COUNT(*) AS total
FROM used_cars
WHERE variant IS NULL OR TRIM(variant) = ''
GROUP BY manufacturer
ORDER BY total DESC;

SELECT variant, COUNT(*) AS total
FROM used_cars
WHERE LENGTH(TRIM(variant)) < 2
GROUP BY variant
ORDER BY total DESC;

-- Standardizing Missing or Invalid Variant Values
UPDATE used_cars
SET variant = 'Unknown Model'
WHERE variant IS NULL
   OR TRIM(variant) = ''
   OR LENGTH(TRIM(variant)) = 1;
   
SELECT * FROM used_cars;

SELECT COUNT(*)
FROM used_cars
WHERE variant = 'Unknown Model';


SELECT MIN(model), MAX(model)
FROM used_cars;

SELECT model, COUNT(*) AS total
FROM used_cars
GROUP BY model
ORDER BY total DESC
LIMIT 10;

                                                     -- Distance column ?
SELECT MIN(distance_travelled), MAX(distance_travelled)
FROM used_cars;

-- very high mileage cars
SELECT COUNT(*)
FROM used_cars
WHERE distance_travelled >= 500000;

-- Which Cars Have 10,00,000 km
SELECT manufacturer, variant, model, distance_travelled
FROM used_cars
WHERE distance_travelled >= 800000
ORDER BY model  DESC ;

-- are these old cars ?
SELECT 
    MIN(model) AS oldest_year,
    MAX(model) AS newest_year,
    ROUND(AVG(model),0) AS avg_year
FROM used_cars
WHERE distance_travelled >= 800000;


SELECT model, COUNT(*) as total_cars
FROM used_cars
WHERE distance_travelled >= 800000
GROUP BY model
ORDER BY model DESC;

SELECT 
CASE 
   WHEN distance_travelled < 20000 THEN 'Low'
   WHEN distance_travelled BETWEEN 20000 AND 80000 THEN 'Medium'
   WHEN distance_travelled BETWEEN 80000 AND 200000 THEN 'High'
   ELSE 'Very High'
END AS km_segment,
COUNT(*) AS total_cars
FROM used_cars
GROUP BY km_segment;


SELECT * FROM used_cars;

                                        -- ENGINE CAPACITY COLUMN 

SELECT MIN(engine_capacity), MAX(engine_capacity)
FROM used_cars;

-- Distribution by engine capacity 
SELECT 
CASE 
   WHEN engine_capacity < 800 THEN 'Micro'
   WHEN engine_capacity BETWEEN 800 AND 1200 THEN 'Small'
   WHEN engine_capacity BETWEEN 1201 AND 2000 THEN 'Mid'
   WHEN engine_capacity BETWEEN 2001 AND 4000 THEN 'Large'
   ELSE 'Performance'
END AS engine_segment,
COUNT(*) AS total
FROM used_cars
GROUP BY engine_segment
ORDER BY total DESC;

-- handled minimum engine capacity 
SELECT engine_capacity, COUNT(*) 
FROM used_cars
WHERE engine_capacity <= 500
GROUP BY engine_capacity
ORDER BY engine_capacity;

-- How many cars have minimum capacity less than 500?

select count(*) from used_cars
where engine_capacity <500;

SELECT manufacturer, variant
FROM used_cars
WHERE fuel_type ='Electric' ;

ALTER TABLE used_cars
ADD COLUMN battery_capacity_kWh INT;

UPDATE used_cars
SET battery_capacity_kWh = engine_capacity
WHERE fuel_type = 'Electric';

UPDATE used_cars
SET engine_capacity = NULL
WHERE fuel_type = 'Electric';

select * from used_cars 
where fuel_type ='Electric';

select manufacturer,variant,engine_capacity  from used_cars
where engine_capacity <660;


UPDATE used_cars
SET engine_capacity = NULL
WHERE fuel_type <> 'Electric'
AND engine_capacity < 500;

SELECT MIN(engine_capacity), MAX(engine_capacity);

UPDATE used_cars
SET engine_capacity = NULL
WHERE engine_capacity > 6000
AND manufacturer IN ('Suzuki','Daihatsu','Datsun','Hyundai','Nissan');


SELECT manufacturer, variant, Fuel_type, engine_capacity
FROM used_cars
WHERE manufacturer IN ('Suzuki','Daihatsu','Datsun','Hyundai','Nissan')
ORDER BY engine_capacity desc;

SELECT* FROM used_cars 
WHERE engine_capacity ='cc';

SELECT manufacturer, engine_capacity
FROM used_cars
WHERE engine_capacity > 6000;




SELECT * FROM used_cars
WHERE engine_capacity >5000
ORDER BY engine_capacity desc;

UPDATE used_cars
SET engine_capacity = NULL
WHERE engine_capacity = 0;

UPDATE used_cars
SET engine_capacity = NULL
WHERE engine_capacity >= 10000;

                                                -- PRICE INR COLUMN 
SELECT 
    MIN(price_INR) AS min_price,
    MAX(price_INR) AS max_price
FROM used_cars;

SELECT manufacturer, variant, price_INR
FROM used_cars
ORDER BY price_INR DESC
LIMIT 10;

SELECT manufacturer, variant, COUNT(*) AS total_cars
FROM used_cars
WHERE price_INR < 1000000 AND
manufacturer ='Suzuki'
GROUP BY manufacturer, variant
ORDER BY total_cars DESC;

SELECT *
FROM used_cars
WHERE price_INR IS NULL
OR TRIM(price_INR) = '';

SELECT *
FROM used_cars
WHERE India_Location = 'Shahabad';

SELECT *
FROM used_cars
WHERE model IS NULL;



DESC used_cars;


SELECT *
FROM used_cars
WHERE distance_travelled =1;

SELECT manufacturer , count(*) as High_manufacturer
from used_cars 
group by manufacturer
order by High_manufacturer desc  ;

SELECT 
    MAX(distance_travelled) AS max_km,
    MIN(distance_travelled) AS min_km
FROM
    used_cars;


SELECT manufacturer, variant , details ,price_INR FROM used_cars
WHERE Fuel_Type = 'Electric' AND Battery_capacity_kWh >221;












