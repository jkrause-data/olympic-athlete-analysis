/*Question 1: At what age do athletes typically compete in Olympic sports, and how do these patterns differ 
between male and female athletes? 



1a)Average Athlete Age by Sport and Gender  */

SELECT 
		sport,
		sex AS Gender,
		ROUND(avg(age)) AS avg_age
	
	From results r
	
	Left JOIN events e ON r.eventid = e.eventid
	LEFT JOIN sport s ON e.sportid = s.sportid
	LEFT JOIN athletes a ON r.athleteid = a.athleteid
	
	WHERE sport IS NOT NULL
		AND age IS NOT NULL
	GROUP BY sport, sex
	ORDER BY avg_age DESC

; 

/* 1B Sports with the highest and lowest average athlete age by gender */

WITH
	cte_age_profiles AS (

	SELECT 
	
		sport,
		sex AS Gender,
		ROUND(avg(age))::int AS avg_age
	
	From results r
	
	Left JOIN events e ON r.eventid = e.eventid
	LEFT JOIN sport s ON e.sportid = s.sportid
	LEFT JOIN athletes a ON r.athleteid = a.athleteid
	
	WHERE sport IS NOT NULL
		AND age IS NOT NULL
	GROUP BY sport, sex
),

female_top AS(
	SELECT sport, avg_age
	FROM cte_age_profiles
	WHERE gender = 'F'
	ORDER BY avg_age DESC
	LIMIT 1
),

male_top AS(
	SELECT sport, avg_age
	FROM cte_age_profiles
	WHERE gender = 'M'
	ORDER BY avg_age DESC
	LIMIT 1

),

female_low AS(
	SELECT sport, avg_age
	FROM cte_age_profiles
	WHERE gender = 'F'
	ORDER BY avg_age ASC
	LIMIT 1
),

male_low AS(
	SELECT sport, avg_age
	FROM cte_age_profiles
	WHERE gender = 'M'
	ORDER BY avg_age ASC
	LIMIT 1
)

SELECT 
female_top.sport AS female_top_highest_avg_age_sport,
female_top.avg_age AS female_top_highest_avg_age,
male_top.sport AS male_top_highest_avg_age_sport,
male_top.avg_age AS male_top_highest_avg_age,
female_low.sport AS female_low_lowest_avg_age_sport,
female_low.avg_age AS female_low_lowest_avg_age,
male_low.sport AS male_low_lowest_avg_age_sport,
male_low.avg_age AS male_low_lowest_avg_age
FROM female_top
CROSS JOIN male_top
CROSS JOIN female_low
CROSS JOIN male_low;