# Anime Data Analysis with MySQL 

This repository contains a data analysis project focused on exploring insights from a dataset of Japanese anime titles sourced from IMDb. The project involves data cleaning, transformation, and deriving key findings about anime popularity, genres, and release trends.

## 📊 Project Overview

The primary goal of this project is to uncover interesting patterns and statistics within a comprehensive dataset of Japanese anime. We aim to answer questions such as:
* What are the highest-rated anime titles?
* Which anime have received the most votes from viewers?
* What are the most popular genres in the anime industry?
* How has the number of anime releases changed over the years?
* What is the overall quality distribution of anime based on user ratings?

## 📂 Dataset

The dataset used for this analysis is:
* **Title:** All Japanese Anime Titles in IMDb
* **Source:** [Kaggle](https://www.kaggle.com/datasets/lorentzyeung/all-japanese-anime-titles-in-imdb)
* **File:** `anime.csv`

This dataset includes various attributes for each anime title, such as:
* `Title`
* `Genre`
* `User Rating`
* `Number of Votes`
* `Runtime`
* `Year` (release year/range)
* `Summary`
* `Stars`
* `Certificate`
* `Metascore`
* `Gross`
* `Episode`
* `Episode Title`

## ✨ Key Findings & Analysis Performed

The project addresses the following key insights:

1.  **Data Cleaning & Type Conversion:** Transformed raw `TEXT` columns into appropriate data types (e.g., `DECIMAL` for ratings, `UNSIGNED` integers for votes and years, `VARCHAR` for strings) in MySQL for efficient storage and accurate calculations. Handled missing or malformed data during conversion.
2.  **Null Value Check:** Identified the presence of missing data across various columns.
3.  **Anime Review Category:** Created a new categorical column (`review_category`) based on `User Rating` thresholds (e.g., 'Excellent', 'Very Good', 'Good', 'Average', 'Poor', 'No Rating').
4.  **Top Anime by User Rating:** Identified the top-rated anime titles, considering a minimum vote count for relevance.
5.  **Anime with Most Votes:** Found the anime titles with the highest number of audience votes, indicating widespread popularity.
6.  **Most Popular Genres:** Analyzed and counted the occurrences of individual genres to determine the most prevalent anime categories.
7.  **Anime Releases by Year:** Tracked the number of anime releases per year to observe trends in production volume over time.
8.  **Additional Insights (Explored):**
    * Average User Rating Over Time
    * Average Runtime by Year
    * Distribution of Anime by Review Category
    * Top Rated Anime within specific genres
