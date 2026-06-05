/* Question 3: How have athlete age, height and weight changed across different Olympic sports over the decades, and how do these trends differ 
between women and men? */

SELECT 

sport,
sex AS gender,
round(AVG(age)) as avg_age,
round (avg(height)/10,1) AS avg_height_cm,
round(avg(weight)/10,1) AS avg_weight_kg,
FLOOR(year / 10) * 10 AS decade

From 

results r

LEFT JOIN athletes a ON r.athleteid = a.athleteid
LEFT JOIN years y ON r.yearid = y.yearid
LEFT JOIN events e ON r.eventid = e.eventid
LEFT JOIN sport s ON e.sportid = s.sportid

WHERE age IS NOT NULL
  AND height IS NOT NULL
  AND weight IS NOT NULL
  AND year IS NOT NULL
  AND sport IS NOT NULL

GROUP BY  sport, gender, decade
ORDER BY sport, decade, gender;