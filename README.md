# Netflix TV shows and Movie Analysis Using SQL

![Netflix Logo](https://github.com/sumnima08/netflix_sql_project/blob/main/Netflix_Logo_RGB.psd)

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


