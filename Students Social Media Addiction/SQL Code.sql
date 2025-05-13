create database SQLPROJECTS;
use SQLPROJECTS;
# Q1. List all student details
select * from  students;

# Q2. Names (Student_IDs) and average daily usage of students from India

SELECT Student_ID, Avg_Daily_Usage_Hours FROM students WHERE Country = 'India';

# Q3. Number of male and female students

SELECT Gender, COUNT(*) FROM students GROUP BY Gender;

# Q4. Distinct academic levels

SELECT DISTINCT Academic_Level FROM students;

# Q5. Students who sleep more than 7 hours

SELECT * FROM students WHERE Sleep_Hours_Per_Night > 7;

# Q6. Students sorted by addicted score (descending)

SELECT * FROM students ORDER BY Addicted_Score DESC;

# Q7. Students who say social media does not affect academic performance

SELECT * FROM students WHERE Affects_Academic_Performance = 'No';

# Q8. Average Addicted_Score for each academic level

SELECT Academic_Level, AVG(Addicted_Score) FROM students GROUP BY Academic_Level;

# Q9. Total number of students by country

SELECT Country, COUNT(*) AS Total_Students FROM students GROUP BY Country;

# Q10. Average mental health score grouped by gender

SELECT Gender, AVG(Mental_Health_Score) FROM students GROUP BY Gender;

# Q11. Most used platform by count

SELECT Most_Used_Platform, COUNT(*) FROM students GROUP BY Most_Used_Platform ORDER BY COUNT(*) DESC;

# Q12. Platform with highest average Addicted_Score

SELECT Most_Used_Platform, AVG(Addicted_Score) FROM students GROUP BY Most_Used_Platform ORDER BY AVG(Addicted_Score) DESC;

# Q13. Average daily usage for students who are ‘Single’

SELECT AVG(Avg_Daily_Usage_Hours) FROM students WHERE Relationship_Status = 'Single';

# Q14. Top 3 countries by average daily usage

SELECT Country, AVG(Avg_Daily_Usage_Hours) FROM students GROUP BY Country ORDER BY AVG DESC LIMIT 3;

# Q15. Students who sleep < 6 hours and have Addicted_Score > 7

SELECT * FROM students WHERE Sleep_Hours_Per_Night < 6 AND Addicted_Score > 7;

# Q16. Identify students who have above-average addicted scores

SELECT * FROM students
WHERE Addicted_Score > (
    SELECT AVG(Addicted_Score) FROM students
);

# Q17. Find academic levels where average mental health score is below 6

SELECT Academic_Level, AVG(Mental_Health_Score) AS Avg_Mental_Health
FROM students
GROUP BY Academic_Level
HAVING AVG(Mental_Health_Score) < 6;

# Q18. Relationship status group with highest average conflict over social media

SELECT Relationship_Status, AVG(Conflicts_Over_Social_Media) AS Avg_Conflicts
FROM students
GROUP BY Relationship_Status
ORDER BY Avg_Conflicts DESC
LIMIT 1;

# Q19. Label students as ‘Low’, ‘Medium’, or ‘High’ risk based on Addicted_Score

SELECT Student_ID, Addicted_Score,
CASE
    WHEN Addicted_Score < 4 THEN 'Low'
    WHEN Addicted_Score BETWEEN 4 AND 7 THEN 'Medium'
    ELSE 'High'
END AS Risk_Level
FROM students;

# Q20. Summary: for each platform, show number of users and average usage time

SELECT Most_Used_Platform,
       COUNT(*) AS User_Count,
       AVG(Avg_Daily_Usage_Hours) AS Avg_Usage_Hours
FROM students
GROUP BY Most_Used_Platform;

# Q21. Top 5 students with highest Addicted_Score from Graduate level

SELECT * FROM students
WHERE Academic_Level = 'Graduate'
ORDER BY Addicted_Score DESC
LIMIT 5;

# Q22. Average sleep duration for each mental health score group (2-point buckets)

SELECT 
  CASE 
    WHEN Mental_Health_Score BETWEEN 0 AND 2 THEN '0-2'
    WHEN Mental_Health_Score BETWEEN 3 AND 4 THEN '3-4'
    WHEN Mental_Health_Score BETWEEN 5 AND 6 THEN '5-6'
    WHEN Mental_Health_Score BETWEEN 7 AND 8 THEN '7-8'
    ELSE '9-10'
  END AS Mental_Health_Bucket,
  AVG(Sleep_Hours_Per_Night) AS Avg_Sleep
FROM students
GROUP BY Mental_Health_Bucket;

# Q23. Using a CTE, find students with more than average number of conflicts over social media

WITH AvgConflicts AS (
    SELECT AVG(Conflicts_Over_Social_Media) AS avg_conflict FROM students
)
SELECT * FROM students
WHERE Conflicts_Over_Social_Media > (SELECT avg_conflict FROM AvgConflicts);

# Q24. Find the student(s) with the maximum Addicted_Score in each academic level

WITH RankedStudents AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Academic_Level ORDER BY Addicted_Score DESC) AS rank
    FROM students
)
SELECT * FROM RankedStudents WHERE rank = 1;

# Q25. Rank students based on Avg_Daily_Usage_Hours by country (Top 2 per country)

WITH RankedByCountry AS (
    SELECT *, RANK() OVER (PARTITION BY Country ORDER BY Avg_Daily_Usage_Hours DESC) AS rank
    FROM students
)
SELECT * FROM RankedByCountry WHERE rank <= 2;


