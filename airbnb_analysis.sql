-- #1 Creating Data Base 
CREATE DATABASE airbnb;
use airbnb;
CREATE TABLE listings (
    name VARCHAR(100) PRIMARY KEY,
    host_id INT,
    neighbourhood VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    room_type VARCHAR(50),
    price DECIMAL(10,2),
    minimum_nights INT,
    number_of_reviews INT
);

use airbnb;
show tables ;
ALTER TABLE listings DROP PRIMARY KEY;
ALTER TABLE listings ADD PRIMARY KEY (name);

-- # 3 basic data Retrival
SELECT * FROM listings LIMIT 10;
-- #4 Getting airbnbs with prices greater tahn 100 using WHERE
select * from listings where price > 100;
-- # 5 Getting the top 5 reviewed airbnbs using Orderby
select * from listings order by number_of_reviews desc limit 5;
-- # 6 Finding the average ,minmum and maximum prices using Aggregation
select 
    avg(price) as avg_price,
    min(price) as max_price,
    max(price) as max_price
from listings;    
-- # 7 Catagorizing using a certain grouping using GROUP BY
select neighbourhood ,count(*) as total_listings from listings group by neighbourhood;
-- # 8  Creating specfic cases using different columns 
select  name, price,
case 
	  when price < 50 then 'Cheap'
	  when price between 50 and 150 then 'Moderate'
	  else 'Expensive'
	  end as price_catagory
from Listings limit 5;
-- # 9 if you want to skip the first 10 rows for eg.
select *
from listings
order by id
limit 10
offset 10 ;
-- # 10 If you want to see a distict column 
SELECT DISTINCT neighbourhood
FROM listings;
-- # 11 listings in specific columns 
SELECT name, neighbourhood
FROM listings
WHERE neighbourhood IN ('NINTH WARD', 'FIFTH WARD', 'SEVENTH WARD');
-- #12 Select specific prices 
select name,price
from listings
where price between 50 and 100;
-- 13 smaller temporary table with specific sortings(CTE-Common Table Expression)
with review_counts  as(
select name ,number_of_reviews
from listings
order by number_of_reviews  desc
limit 3)
select * from review_counts;
-- 14 Rank listing by price in each neighborhood group
select id ,name,neighbourhood,price,
rank() over (partition by neighbourhood order by price desc) as price_rank
from listings;
