# Netflix Movies and TV Shows Data Analysis using SQL

![NetflixLogo](https://github.com/sumnima08/netflix_sql_project/blob/main/Netflix_Logo_RGB.psd)

A complete SQL-based data exploration project analyzing the Netflix titles dataset.

This project answers 15 real-world business questions using PostgreSQL.

🔥 Project Overview

This project performs exploratory data analysis (EDA) on Netflix content using SQL.
It includes data cleaning, transformation, and analytical insights such as:
-Movies vs TV Shows
-Most common ratings
-Country-based content distribution
-Directors & actors analysis
-Trending release years
-Content categorization
-Genre exploration

🗂️ Dataset
The dataset used is netflix_titles.csv (Kaggle Netflix Titles Dataset).

After import, the table was renamed:
ALTER TABLE netflix_titles
RENAME TO netflix;

🚀 SQL Features Used
This project covers:
✔ Aggregations (COUNT, MAX, ROUND)
✔ Window functions (RANK)
✔ Text functions (SPLIT_PART, STRING_TO_ARRAY, UNNEST)
✔ Date functions (EXTRACT, TO_DATE)
✔ Conditional logic (CASE WHEN)
✔ Filtering using ILIKE
✔ Subqueries
✔ Common Table Expressions (CTE)

📘 Business Questions & SQL Solutions

Below are the 15 business problems solved in this project.

1️⃣ Count Movies vs TV Shows
SELECT type, COUNT(show_id) AS total_content
FROM netflix
GROUP BY type;

2️⃣ Most common rating for each type
SELECT 
	type,
	rating
FROM
(
	SELECT	
		type, 
		rating,
		COUNT(*),
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM netflix
	GROUP BY 1,2
) AS t1
WHERE ranking = 1;

3️⃣ Movies released in 2020
SELECT *
FROM netflix
WHERE type = 'Movie' 
AND release_year = 2020;
4️⃣ Top 5 countries with most Netflix content
SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
5️⃣ Longest movie
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND duration = (SELECT MAX(duration) FROM netflix);
6️⃣ Content added in the last 5 years
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
7️⃣ Content by director Rajiv Chilaka
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';
8️⃣ TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND SPLIT_PART(duration, ' ', 1)::NUMERIC > 5;
9️⃣ Number of items per genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1;
🔟 Average % of content released by India each year
SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
	COUNT(*),
	ROUND(COUNT(*)::NUMERIC / 
		(SELECT COUNT(*) FROM netflix WHERE country = 'India')::NUMERIC * 100, 2) 
	AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1;
1️⃣1️⃣ List all documentaries
SELECT *
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';
1️⃣2️⃣ Content with no director
SELECT *
FROM netflix
WHERE director IS NULL;
1️⃣3️⃣ Salman Khan movies from last 10 years
SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
1️⃣4️⃣ Top 10 actors in Indian content
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) AS actors,
	COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
1️⃣5️⃣ Categorizing “Bad” vs “Good” content based on keywords
WITH new_table AS (
	SELECT *,
		CASE 
			WHEN description ILIKE '%kill%' 
			  OR description ILIKE '%violence%' 
			THEN 'Bad_Content'
			ELSE 'Good Content'
		END AS category
	FROM netflix
)
SELECT 
	category,
	COUNT(*) AS total_content
FROM new_table
GROUP BY 1;
📈 What You Learn From This Project
Real SQL data cleaning
How to handle multi-valued fields (countries, casts, genre)
Creating CTEs and window functions
Real business questions solved with SQL
Transforming raw data into insights
🛠️ Tools Used
PostgreSQL
PgAdmin / TablePlus
VS Code / GitHub
📎 How to Use This Repository
Clone the repo
Import the dataset
Run the SQL scripts in order
Modify queries to explore further
