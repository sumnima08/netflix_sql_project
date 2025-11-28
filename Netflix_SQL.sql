--Netflix Project 
DROP TABLE IF EXISTS Netflix;

DROP TABLE IF EXISTS netflix_titles;

SELECT * FROM netflix_titles;

ALTER TABLE netflix_titles
RENAME TO netflix;

SELECT
COUNT(*) AS total_content
FROM netflix;

SELECT
	DISTINCT type 
FROM netflix;

-- 15 Business Problems

-- 1. Counting the number of Movies Vs TV Shows

SELECT type, COUNT(show_id) AS total_content
FROM netflix
GROUP BY type;

--2. Finding the most common rating for movies and TV shows
SELECT 
	type,
	rating
FROM
(SELECT	
	type, 
	rating,
	COUNT(*),
	RANK () OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM netflix
GROUP BY 1,2
) AS t1
WHERE
	ranking = 1;

--3. Listing all movies released in a specific year (e.g., 2020)

SELECT *
FROM Netflix
WHERE type = 'Movie' 
AND
release_year = 2020;

--4. Top 5 countries with the most content on Netflix

SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country,
	COUNT(show_id) as total_content
FROM Netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--5. Identifying the longest movie

SELECT * FROM Netflix
WHERE
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) FROM Netflix)
	
-- Finding content that were added in last 5 years

SELECT *
FROM Netflix
WHERE
	TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

--Finding all the movies/TV shows by director 'Rajiv Chilaka'

SELECT *
FROM Netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- List all TV shows with more than 5 seasons

SELECT *
FROM Netflix
WHERE type = 'TV Show'
AND 
SPLIT_PART(duration, ' ' , 1) :: NUMERIC > 5;

--Couting the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre,
	COUNT(show_id) AS total_content
FROM Netflix
GROUP BY 1;

--Finding each year and the average numbers of content release by India on Netflix

SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
	COUNT(*),
	ROUND(COUNT(*) :: numeric /(SELECT COUNT(*) FROM Netflix WHERE country ='India') :: numeric * 100,2) AS Avg_content_per_year
FROM Netflix
WHERE country = 'India'
GROUP BY 1;

--Listing all movies that documentaries

SELECT *
FROM Netflix
WHERE listed_in ILIKE '%Documentaries%';

--Find all content without a director

SELECT *
FROM Netflix
WHERE director IS NULL;

-- Finding movies actor 'Salman Khan' appeared in last 10 years

SELECT *
FROM Netflix
WHERE 
	casts ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

--Finding the top 10 actors who have appeared in the highest number of movies produced in India

SELECT 
	UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
	COUNT(*) AS total_content
FROM Netflix
WHERE country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Categorizing the content based on the presence of the words 'kill' and 'violence' in the description field. label content containing these keywords as 'Bad' and all other content as 'Good'. Also, counting how many items fall into each category

WITH new_table
AS
(SELECT *,
		CASE 
		WHEN 
			description ILIKE '%kill%' OR
			description ILIKE '%violence%' THEN 'Bad_Content'
		ELSE 'Good Content'
	END category
FROM Netflix
)
SELECT 
	category,
	COUNT(*) AS total_content
FROM new_table
GROUP BY 1;
	
	