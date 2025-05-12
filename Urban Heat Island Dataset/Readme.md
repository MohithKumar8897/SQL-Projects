
# 🌆 Urban Heat Island SQL Analysis Project

## 📌 Project Title
**Data-Driven Environmental Analysis of Urban Heat Island Effects Across Cities**

## 📊 Project Overview

This project focuses on analyzing urban environmental data using SQL to uncover patterns related to Urban Heat Island (UHI) effects. By querying a dataset of 500 cities, we explore the relationships between climate indicators, urban infrastructure, land cover types, health impacts, and socioeconomic factors.

The SQL-based analysis answers 50 real-world questions, ranging from basic data exploration to advanced correlation analysis and vulnerability scoring.

---

## 🧾 Dataset Information

- **File**: [`urban.csv`](https://github.com/MohithKumar8897/SQL-Projects/blob/main/Urban%20Heat%20Island%20Dataset/urban.csv)
- **Records**: 500 cities
- **Fields Include**:
  - City name, latitude, longitude, elevation
  - Temperature, humidity, wind speed, rainfall
  - Land cover type (e.g., Water, Green Space)
  - Urban greenness ratio (%)
  - Air quality index (AQI)
  - Population density
  - Energy consumption
  - Health impact (mortality rate per 100k)
  - GDP per capita (USD)

Detailed column definitions and analytical questions are provided in the [`📊 Dataset Overview.pdf`](https://github.com/MohithKumar8897/SQL-Projects/blob/main/Urban%20Heat%20Island%20Dataset/%F0%9F%93%8A%20Dataset%20Overview.pdf).

---

## ✅ Tools & Technologies

- **SQL Workbench / MySQL**
- **CSV data import**
- **Jupyter Notebook (optional for visualizations)**


---

## 🔎 SQL Analysis Summary

The analysis includes:

### 🌍 Geographic & Climate Analysis
- Hottest and coolest cities
- Elevation vs. temperature relationship
- Land cover types vs. temperature

### 🏙 Urban Structure & Impact
- Population density vs. AQI
- Greenness vs. mortality rate
- Energy use vs. air quality

### 📊 Statistical Aggregations
- Grouping by land cover
- Ranking by AQI, GDP, greenness, etc.
- Finding extreme values

### 💀 Public Health Insights
- High temperature + high mortality cities
- UHI vulnerability scoring

### 🔁 Advanced Queries
- Subqueries (above-average metrics, percentiles)
- Correlations (GDP vs. AQI, Temp vs. Greenness)
- Environmental scoring: `score = (Temperature + AQI - Greenness)`

---

## 🧠 Sample SQL Queries

```sql
-- Top 10 most vulnerable cities to Urban Heat Island
SELECT city_name,
       (temperature + air_quality_index - urban_greenness_ratio) AS heat_vulnerability_score
FROM urban
ORDER BY heat_vulnerability_score DESC
LIMIT 10;

-- Cities with high mortality and low greenness
SELECT city_name
FROM urban
WHERE health_impact > 25 AND urban_greenness_ratio < 20;
```

---

