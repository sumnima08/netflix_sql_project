## Netflix Movies and TV shows Analysis Using SQL

In this project, I explored Netflix’s catalog using SQL to uncover patterns in content strategy, genre trends, and the evolution of titles added to the platform. What began as a simple dataset turned into a deeper story about how Netflix has expanded globally, the types of shows it invests in, and where data gaps exist.
The goal of this project is to demonstrate real-world SQL skills in data cleaning, exploration, and insight generation — the same skills used in analytics roles to support business decisions.

🎬 Understanding the Dataset
The dataset represents Netflix’s full catalog, covering both movies and TV shows. Every row is a unique title, and together the attributes help answer questions like:
What does Netflix add the most — movies or shows?
Which genres dominate the platform?
How quickly is the catalog growing?
How global is Netflix’s content?
Column Name	Description
show_id	Unique title identifier
type	Movie or TV Show
title	Name of the content
director	Director(s) involved
cast	Main actors
country	Production country
date_added	When the title was added to Netflix
release_year	Original release year
rating	Age rating
duration	Runtime or # of seasons
listed_in	Genre categories
description	Short summary
🧹 1. Cleaning the Data — Preparing the Story
Before the analysis started, I had to ensure the dataset was usable:
Detected missing values (especially in the director field).
Converted date_added from text to a proper date format.
Validated duration values across movies and shows.
This cleaning step ensured the insights were accurate and reliable.
🔍 2. Exploring the Data — Asking the Right Questions
Once cleaned, I explored the dataset to understand the landscape:
How many titles does Netflix have?
Which countries contribute the most content?
Are some genres overwhelmingly more common?
What does the mix of Movies vs TV Shows look like?
How many titles were added in the last 5 years?
Each question helped shape the direction for deeper analysis.
📊 3. Analysis — Turning Data Into Insights
Through SQL analysis, I uncovered insights that resemble real business questions Netflix analysts would investigate:
✔ Content Growth
Analyzed how many titles were added across years and recent 5-year trends.
✔ Genre Patterns
Identified top genres and how diverse Netflix’s catalog truly is.
✔ Missing Director Clusters
Noticed patterns in titles lacking director information — often documentaries or older titles.
✔ TV Shows With Long Seasons
Extracted shows with more than 5 seasons to understand “evergreen” long-running content.
✔ Country Contributions
Found which countries dominate Netflix’s content pipeline.
Each analysis answers a potential business question:
"What types of content should Netflix prioritize?"
"Which regions should Netflix invest in?"
"Is our catalog aging, growing, or diversifying?"
🧠 Core SQL Queries Used
Titles added in the last 5 years
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
Missing directors
SELECT *
FROM netflix
WHERE director IS NULL;
TV Shows with more than 5 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND SPLIT_PART(duration, ' ', 1)::NUMERIC > 5;
Count Movies vs TV Shows
SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;
Most common genres
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genre,
    COUNT(*) AS total
FROM netflix
GROUP BY genre
ORDER BY total DESC;
Titles added per year
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year_added,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY year_added
ORDER BY year_added;
🧰 SQL Skills Demonstrated
Data quality checks & cleaning
Complex filtering & text manipulation
Date extraction & comparisons
Genre unnesting using array and string functions
Grouping, aggregation, and trend analysis
Interpreting results to answer business questions
🚀 How to Run This Project
Clone the repository:
git clone https://github.com/your-username/netflix-sql-project.git
Open the SQL scripts in your SQL environment (PostgreSQL, DBeaver, TablePlus, PgAdmin) and run them in sequence.
📁 Project Structure
📂 netflix-sql-project
 ├── README.md
 ├── netflix_titles.csv
 └── netflix_queries.sql
💡 Future Enhancements
Build a Power BI or Tableau dashboard for visualization
Add clustering to group similar titles
Analyze Netflix Original vs non-original distribution
Time-series analysis on content addition trends
