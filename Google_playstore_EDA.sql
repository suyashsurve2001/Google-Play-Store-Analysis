use Google_playstore

  
select *  from googleplaystore
select *  from googleplaystore_user_reviews
--finding null value

 select * 
 from googleplaystore
 where App is null
 or Category is null 
 or Rating is null 
 or Reviews is null 
 or Size is null 
 or Installs is null 
 or Type is null 
 or Price is null 
 or Content_Rating is null
 or Genres is null 
 or Last_Updated is null 
 or Current_Ver is null 
 or Android_Ver is null


--remove null value

delete from googleplaystore
 where App is null
 or Category is null 
 or Rating is null 
 or Reviews is null 
 or Size is null 
 or Installs is null 
 or Type is null 
 or Price is null 
 or Content_Rating is null
 or Genres is null 
 or Last_Updated is null 
 or Current_Ver is null 
 or Android_Ver is null


-- Overview of Dataset: 
--• Total unique apps and categories in the dataset. 

select 
count(distinct Category) as Category ,
count( distinct App) as App  
from  googleplaystore


--Explore App Categories and Counts: 
--• Retrieve the unique app categories and the count of apps in each category. 

select 
Category,
count( distinct App) as App  
from  googleplaystore
group by Category
order by  App desc

--Top-rated Free Apps: 
--• Identify the top-rated free apps. 

select App,Category,Rating
 from  googleplaystore
 where type = 'Free' and Rating <>'NaN'
 order by Rating desc


--Most Reviewed Apps: 
--• Find the apps with the highest number of reviews. 

select top 10 App,Category,Rating,Reviews
 from  googleplaystore
 order by Reviews desc

--Average Rating by Category: 
--• Calculate the average rating for each app category. 

select
App,
Category,
AVG(Try_cast(Rating as float )) as Avg_Rating
from  googleplaystore
group by Category,App
order by Avg_Rating desc

--Top Categories by Number of Installs: 
--• Identify the  categories with the highest total number of installs. 

select 
Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1,CASE WHEN Patindex('%[^0-9]%', Installs + '') = 0 THEN LEN(Installs)ELSE Patindex('%[^0-9]%', Installs + '') - 1 END), ',', '') AS INT)) AS Total_Installs
from  googleplaystore
group by Category
order by Total_Installs desc

--Average Sentiment Polarity by App Category: 
--• Analyse the average sentiment polarity of user reviews for each app category. 

select top 10
Category,
Avg(Try_cast(Sentiment_polarity as float)) AS Avg_Sentiment
from googleplaystore
join googleplaystore_user_reviews
on googleplaystore.App = googleplaystore_user_reviews.App
group by Category
order by Avg_Sentiment desc

--Sentiment Reviews by App Category: 
-- Provide the distribution of sentiments across different app categories.

UPDATE googleplaystore_user_reviews
SET Sentiment = REPLACE(Sentiment, 'NaN', 'Natural')
WHERE Sentiment = 'NaN';


select 
Category,
Sentiment,
count(*) as Total_Sentiment
from googleplaystore
join googleplaystore_user_reviews
on googleplaystore.App = googleplaystore_user_reviews.App

group by Category,Sentiment
order by Total_Sentiment desc

