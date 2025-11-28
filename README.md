# Netflix TV shows and Movie Analysis Using SQL

![Netflix Logo](https://github.com/sumnima08/netflix_sql_project/blob/main/Netflix_Logo_PMS.png)

**Project Overview**
The Netflix dataset contains metadata for movies and TV shows available on the platform.
-Using SQL, the project:
-Cleans and validates the dataset
-Explores catalog structure and missing data
-Analyzes genre trends and content types
-Evaluates catalog growth over the last 5 years
-Identifies long-running TV shows, global content distribution, and patterns in release years

The goal is to turn raw data into meaningful insights — similar to what data analysts and business intelligence teams do in media companies.

**Dataset Description**

The project uses a table named netflix, containing metadata about Netflix movies and TV shows.

| Column Name   | Data Type | Description                          |
|---------------|-----------|--------------------------------------|
| show_id       | VARCHAR   | Unique identifier for each title     |
| type          | VARCHAR   | Content type: Movie or TV Show       |
| title         | VARCHAR   | Title of the show or movie           |
| director      | VARCHAR   | Director(s) of the content           |
| cast          | VARCHAR   | Main cast members                     |
| country       | VARCHAR   | Country of production                 |
| date_added    | VARCHAR   | Date when title was added to Netflix |
| release_year  | INT       | Year of original release              |
| rating        | VARCHAR   | Age rating (PG, TV-MA, R, etc.)      |
| duration      | VARCHAR   | Runtime in minutes or number of seasons |
| listed_in     | VARCHAR   | Genres/categories                     |
| description   | VARCHAR   | Short description                     |

**SQL Techniques Used**
In this project, I applied a range of SQL techniques to clean, transform, and analyze the Netflix dataset:
Data Cleaning: Filtered nulls and converted text to date formats for accurate analysis.
String Functions: Utilized SPLIT_PART(), STRING_TO_ARRAY(), and UNNEST() to manipulate and extract information from text fields.

-**Date Functions**: Applied TO_DATE() and EXTRACT() to handle and analyze date-related data.

-**Aggregation**: Used COUNT() to summarize data and reveal patterns.

-**Grouping:** Leveraged GROUP BY to segment data by categories such as type, director, and year.

-**Sorting:** Applied ORDER BY to present data in a meaningful order.

-**Condition Filtering:** Used WHERE clauses to focus analysis on specific subsets of the dataset.

-**Common Table Expressions (CTEs)**: Structured complex queries into readable, reusable steps for more efficient analysis.


**Analysis & Queries**

### 1. Count of Movies vs TV Shows

```sql
SELECT type, COUNT(show_id) AS total_content
FROM netflix
GROUP BY type;
```

Determines the number of movies and TV shows on Netflix.

### 2. Most Common Rating by Content Type**
```
SELECT type, rating
FROM (
    SELECT type, rating, COUNT(*) AS cnt,
           RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY 1,2
) t1
WHERE ranking = 1;
```

Identifies the most frequent rating for movies and TV shows.

### 3. Movies Released in 2020
```
SELECT *
FROM Netflix
WHERE type = 'Movie' AND release_year = 2020;
```
Lists all movies released in the year 2020.

### 4. Top 5 Countries by Content
```
SELECT UNNEST(STRING_TO_ARRAY(country, ',')) AS country, COUNT(show_id) AS total_content
FROM Netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```
Finds countries producing the most Netflix content.

### 5. Longest Movie
```
SELECT *
FROM Netflix
WHERE type = 'Movie' AND duration = (SELECT MAX(duration) FROM Netflix);
```
Identifies the longest movie on Netflix.

### 6. Content Added in the Last 5 Years
```
SELECT *
FROM Netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```
Lists content added recently.

### 7. Content by Director Rajiv Chilaka
```
SELECT *
FROM Netflix
WHERE director ILIKE '%Rajiv Chilaka%';
```
Finds all titles by a specific director.

### 8. TV Shows with More Than 5 Seasons
```
SELECT *
FROM Netflix
WHERE type = 'TV Show' AND SPLIT_PART(duration, ' ', 1)::NUMERIC > 5;
```
Lists TV shows with more than five seasons.

### 9. Number of Titles per Genre
```
SELECT UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre, COUNT(show_id) AS total_content
FROM Netflix
GROUP BY 1;
```
Counts content items in each genre.

### 10. Yearly Average Content Released by India
```
SELECT EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
       COUNT(*) AS total_content,
       ROUND(COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM Netflix WHERE country='India')::NUMERIC * 100,2) AS Avg_content_per_year
FROM Netflix
WHERE country = 'India'
GROUP BY 1;
```
Tracks India’s contribution to Netflix content per year.

### 11. Movies in Documentaries Category
```
SELECT *
FROM Netflix
WHERE listed_in ILIKE '%Documentaries%';
```
Lists all documentary movies.

### 12. Content Without a Director
```
SELECT *
FROM Netflix
WHERE director IS NULL;
```
Identifies content missing director information.

### 13. Movies Featuring Salman Khan in the Last 10 Years
```
SELECT *
FROM Netflix
WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```
Lists recent movies starring a specific actor.

### 14. Top 10 Indian Actors by Number of Appearances
```
SELECT UNNEST(STRING_TO_ARRAY(casts,',')) AS actors, COUNT(*) AS total_content
FROM Netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```
Ranks actors based on appearances in Indian productions.

### 15. Content Categorization: Bad vs Good
```
WITH new_table AS (
    SELECT *,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad_Content'
            ELSE 'Good Content'
        END AS category
    FROM Netflix
)
SELECT category, COUNT(*) AS total_content
FROM new_table
GROUP BY 1;
```
Labels content as "Bad" or "Good" based on keywords in descriptions and counts them.


** Key Insights**
-Netflix offers more movies than TV shows globally.

-Most content ratings vary by type; family-friendly ratings dominate.

-India produces significant Netflix content, especially in recent years.

-Some movies and TV shows are missing director information.

-Certain actors (e.g., Salman Khan) dominate Indian movie appearances.

-Keyword-based content categorization can help identify sensitive content.


** Potential Applications**
-Strategic content acquisition for streaming platforms

-Regional content analysis and marketing

-Actor popularity tracking for casting decisions

-Family-friendly vs mature content reporting

