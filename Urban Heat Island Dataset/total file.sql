create database SQLPROJECTS;
use SQLPROJECTS;
select * from urban;
# 1. List all unique cities in the dataset.
select distinct city_name from urban;
# 2. Show the first 10 rows of city-level environmental data.
SELECT 
    "City Name", 
    "Temperature (°C)", 
    "Air Quality Index (AQI)", 
    "Urban Greenness Ratio (%)", 
    "Wind Speed (km/h)", 
    "Humidity (%)", 
    "Annual Rainfall (mm)"
FROM urban
LIMIT 10;

# 3. What are the different land cover types?
SELECT DISTINCT land_cover
FROM urban;

# 4. Which cities have the highest population density?
SELECT 
    "City_Name", 
    "Population_Density"
FROM urban
ORDER BY "Population_Density" DESC
LIMIT 10;

# 5. Display all cities with their average temperature.

SELECT 
    "City_Name", 
    AVG("Temperature") AS "Average_Temperature"
FROM urban
GROUP BY "City_Name";

# 6. Find cities with temperature above 35°C.
select * from urban;
SELECT 
    "City_Name", 
    "Temperature"
FROM urban
WHERE "Temperature" > 25.0;

# 7. List cities where Urban Greenness Ratio is below 20%.

SELECT 
    "City_Name", 
    "Urban_Greenness_Ratio"
FROM urban
WHERE "Urban_Greenness_Ratio" < 20;

# 8. Show cities with AQI worse than 150 (poor air quality).

SELECT 
    "city_name", 
    "air_quality_index"
FROM urban
WHERE "air_quality_index" >= 150;

# 9. Which cities have elevation below 100 meters?

SELECT 
    "City_Name", 
    "Elevation"
FROM urban
WHERE "Elevation" < 100;

# 10. Filter cities with mortality rates above 30 per 100k.
SELECT *
FROM urban
WHERE Health_Impact > 30;

# 11. Rank cities by highest temperature.

SELECT *
FROM urban
ORDER BY Temperature DESC;

# 12. Sort cities by best air quality (lowest AQI).

SELECT *
FROM urban
ORDER BY Air_Quality_Index ASC;

# 13. Show top 10 cities by GDP per capita.

SELECT city_name, gdp_per_capita
FROM urban
ORDER BY gdp_per_capita DESC
LIMIT 10;

# 14. Order cities by Urban Greenness Ratio (descending).

SELECT city_name, urban_greenness_ratio
FROM urban
ORDER BY urban_greenness_ratio DESC;

# 15. List cities with lowest energy consumption.

SELECT city_name, energy_consumption
FROM urban
ORDER BY energy_consumption ASC;

# (OR)

SELECT city_name, energy_consumption
FROM urban
ORDER BY energy_consumption ASC
LIMIT 10;

# 16. Count total number of cities in the dataset.

SELECT COUNT(*) AS total_cities
FROM urban;

# 17. How many cities have “Green Space” as land cover?

SELECT COUNT(*) AS green_space_city_count
FROM urban
WHERE land_cover = 'Green Space';

# 18. What is the average temperature by land cover type?

SELECT land_cover, AVG(temperature) AS avg_temperature
FROM urban
GROUP BY land_cover;

# 19. Compute the average mortality rate across all cities.

SELECT AVG(health_impact) AS average_mortality_rate
FROM urban;

# 20. Count cities in each AQI range (e.g., Good, Moderate, Poor).

SELECT
  CASE
    WHEN air_quality_index BETWEEN 0 AND 50 THEN 'Good'
    WHEN air_quality_index BETWEEN 51 AND 100 THEN 'Moderate'
    WHEN air_quality_index BETWEEN 101 AND 150 THEN 'Unhealthy for Sensitive Groups'
    WHEN air_quality_index BETWEEN 151 AND 200 THEN 'Unhealthy'
    WHEN air_quality_index BETWEEN 201 AND 300 THEN 'Very Unhealthy'
    ELSE 'Hazardous'
  END AS aqi_category,
  COUNT(*) AS city_count
FROM urban
GROUP BY aqi_category
ORDER BY city_count DESC;

# 26. List cities hotter than the average temperature.

SELECT city_name, temperature
FROM urban
WHERE temperature > (
    SELECT AVG(temperature) FROM urban
)
ORDER BY temperature DESC;

# 27. Find cities with AQI worse than the dataset’s median AQI.

SELECT city_name, air_quality_index
FROM urban
WHERE air_quality_index > (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY air_quality_index)
    FROM urban
)
ORDER BY air_quality_index DESC;

# 28. Show cities with mortality rate in the top 10%.

SELECT 
    city_name,
    health_impact AS mortality_rate
FROM 
    urban
WHERE 
    health_impact >= (
        SELECT health_impact
        FROM (
            SELECT health_impact
            FROM urban
            ORDER BY health_impact DESC
            LIMIT 1 OFFSET (SELECT COUNT(*) FROM urban) * 0.1) - 1
        )
    )
ORDER BY 
    health_impact DESC;

# 29. Find cities with above-average greenness but below-average temperature.

SELECT 
    city_name,
    urban_greenness_ratio,
    temperature
FROM 
    urban
WHERE 
    urban_greenness_ratio > (SELECT AVG(urban_greenness_ratio) FROM urban)
    AND temperature < (SELECT AVG(temperature) FROM urban)
ORDER BY 
    urban_greenness_ratio DESC;

# 30. Identify cities with GDP per capita above the 75th percentile.

SELECT 
    city_name,
    gdp_per_capita
FROM 
    urban
WHERE 
    gdp_per_capita > (
        SELECT gdp_per_capita
        FROM (
            SELECT gdp_per_capita, 
                   NTILE(4) OVER (ORDER BY gdp_per_capita) AS quartile
            FROM urban
        ) AS quartiles
        WHERE quartile = 3
        LIMIT 1
    )
ORDER BY 
    gdp_per_capita DESC;

# 31. Find all cities with names starting with “San”.

SELECT city_name
FROM urban
WHERE city_name LIKE 'San%';

# 32. Count how many cities have “Green” in the Land Cover field:

SELECT COUNT(*) AS green_cover_count
FROM urban
WHERE land_cover LIKE '%Green%';

# 33. Show land cover types that include the word “Water”.

SELECT DISTINCT land_cover
FROM urban
WHERE land_cover LIKE '%Water%';

# 34. Replace “Green Space” with “Vegetation Zone” in output (display only):

SELECT city_name,
       CASE 
           WHEN land_cover = 'Green Space' THEN 'Vegetation Zone'
           ELSE land_cover
       END AS land_cover
FROM urban;

# 35. List all cities whose names contain a number (if any):

SELECT city_name
FROM urban
WHERE city_name REGEXP '[0-9]';

# 36. Simulate seasons: find cities with high humidity and high rainfall.

SELECT city_name, humidity, annual_rainfall
FROM urban
WHERE humidity > (
    SELECT AVG(humidity) FROM urban
)
AND annual_rainfall > (
    SELECT AVG(annual_rainfall) FROM urban
)
ORDER BY humidity DESC, annual_rainfall DESC;

# 37. Cities likely to suffer drought (low humidity, low rainfall):

SELECT city_name, humidity, annual_rainfall
FROM urban
WHERE humidity < (
    SELECT AVG(humidity) FROM urban
)
AND annual_rainfall < (
    SELECT AVG(annual_rainfall) FROM urban
)
ORDER BY humidity ASC, annual_rainfall ASC;

# 38. Windy cities with low temperatures (simulate cold windy places):

SELECT city_name, wind_speed, temperature
FROM urban
WHERE wind_speed > (
    SELECT AVG(wind_speed) FROM urban
)
AND temperature < (
    SELECT AVG(temperature) FROM urban
)
ORDER BY wind_speed DESC, temperature ASC;

# 39. Rank cities by potential for solar energy (high temperature, low rainfall):

SELECT city_name, temperature, annual_rainfall
FROM urban
WHERE temperature > (
    SELECT AVG(temperature) FROM urban
)
AND annual_rainfall < (
    SELECT AVG(annual_rainfall) FROM urban
)
ORDER BY temperature DESC, annual_rainfall ASC;

# 40. List coastal cities (e.g., based on Land Cover = 'Water'):

SELECT city_name
FROM urban
WHERE land_cover = 'Water';

# 41. Calculate average AQI per land cover type.

SELECT land_cover, AVG(air_quality_index) AS avg_aqi
FROM urban
GROUP BY land_cover;

# 42. Find standard deviation of temperature across all cities:

SELECT STDDEV(temperature) AS std_temperature
FROM urban;

# 43. Determine average GDP per region (if location added):

# There is no religion column is there 

# 44. Count cities with mortality rate > 25 and greenness < 20%:

SELECT COUNT(*) AS high_mortality_low_greenness
FROM urban
WHERE health_impact > 25 AND urban_greenness_ratio < 20;

# 45. Find the correlation between GDP per capita and AQI:

SELECT CORR(gdp_per_capita, air_quality_index) AS correlation
FROM urban;

# 46. Cities with high temp, high AQI, low greenness (define thresholds):

SELECT city_name
FROM urban
WHERE temperature > 30 AND air_quality_index > 150 AND urban_greenness_ratio < 20;

# 47. Percentage of cities classified as having “Green Space”:

SELECT 
    (COUNT(*) FILTER (WHERE land_cover = 'Green Space') * 100.0 / COUNT(*)) AS green_space_percentage
FROM urban;

# 48. Cities with low temp and high GDP (define thresholds):

SELECT city_name
FROM urban
WHERE temperature < 15 AND gdp_per_capita > 30000;

# 49. Top 10 cities most vulnerable to urban heat islands (high temp + AQI - greenness):

SELECT city_name,
       (temperature + air_quality_index - urban_greenness_ratio) AS heat_vulnerability_score
FROM urban
ORDER BY heat_vulnerability_score DESC
LIMIT 10;

# 50. Create environmental score = (Temperature + AQI - Greenness), rank cities:

SELECT city_name,
       (temperature + air_quality_index - urban_greenness_ratio) AS environmental_score
FROM urban
ORDER BY environmental_score DESC;
