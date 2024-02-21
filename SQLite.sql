Create Table appleStore_description_combined AS

Select * FROM appleStore_description1

UNION all 

Select * FROM appleStore_description2

UNION all 

Select * FROM appleStore_description3

UNION all 

Select * FROM appleStore_description4


**EXPLORATORY DATA ANALYSIS**
--Check the number of uniqlue apps in both tablesAppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appleStore_description_combined

--Check for missing values in key fields

SELECT COUNT(*) AS MissingValues
FROM AppleStore
Where track_name is null Or user_rating is null or prime_genre is NULL

SELECT COUNT(*) AS MissingValues
FROM appleStore_description_combined
Where app_desc is NULL

-- Find our the number of apps per genre

Select prime_genre, COUNT(*) AS NumApps
From AppleStore 
GROUP by prime_genre
Order by NumApps DESC

--Get an  overview of the apps' ratings--

Select min(user_rating) AS MinRating,
	   max(user_rating) AS MaxRating,
       avg(user_rating) AS AVGRating
FROM AppleStore

-- Get the distrubution of app prices	

SELECT
	(price / 2) *2 AS PriceBinStart,
    ((price / 2) *2) +2 AS PriceBinEnd,
    Count(*) AS NumApps
    From AppleStore
    
Group By PriceBinStart
ORDER By PriceBinStart

**Data Analysis

-- Determine whether paid apps have higher ratings than free apps

Select CASE
	When price > 0 Then 'Paid'
    Else 'Free'
    End As App_Type,
    avg(user_rating) AS Avg_Rating
From AppleStore
Group BY App_Type
        
        -- Check if apps with more supported languages have higher ratings
        
Select Case 
	When lang_num < 10 THEN '<10 languages'
    When lang_num between 10 and 30 then '10-30 languages'
    Else '>30 languages'
    END as language_bucket,
    avg(user_rating) AS Avg_Rating
    From AppleStore
    Group by language_bucket
    Order by Avg_Rating DESC
    
    
--Check genres with low ratings	

Select prime_genre,
	avg(user_rating) AS Avg_Rating
From AppleStore
group by prime_genre
order by Avg_Rating ASC
Limit 10 
