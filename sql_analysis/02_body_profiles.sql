/* Question 2: Which height and weight patterns are typical for different Olympic sports, separated by gender? */


SELECT 

sport,
sex AS gender,
round (avg(height/10)) AS avg_height,
round(avg(weight/10)) AS avg_weight

From 

results r

LEFT JOIN events e ON r.eventid = e.eventid
LEFT JOIN sport s ON e.sportid = s.sportid
LEFT JOIN athletes a ON r.athleteid = a.athleteid

WHERE sport IS NOT NULL
	AND height IS NOT NULL
	AND weight IS NOT NULL

GROUP BY sport, sex
ORDER BY sport, gender;
