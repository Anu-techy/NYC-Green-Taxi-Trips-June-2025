/********************************************
-- Project: NYC Green Taxi trips Data Analysis
-- Purpose: SQL queries for Data Cleaning
********************************************/


/********************************************
1. BASIC EXPLORATION
********************************************/
DESC green_trips;    
- 15 columns

SELECT COUNT(*) FROM green_trips;   
-49390 rows

SELECT * from green_trips LIMIT 5;

/********************************************
2. DATA TYPE OPTIMIZATION
********************************************/
-- LocationID values 1,2 --- 260 
ALTER TABLE green_trips
  MODIFY COLUMN PULocationID SMALLINT UNSIGNED,
  MODIFY COLUMN DOLocationID SMALLINT UNSIGNED;
  
-- passenger count values 1,2 --- 9
-- payment type values 1,2 --- 5
ALTER TABLE green_trips
  MODIFY COLUMN passenger_count TINYINT UNSIGNED,
  MODIFY COLUMN payment_type TINYINT UNSIGNED;

    
  -- numeric columns
  ALTER TABLE green_trips
  MODIFY COLUMN trip_distance        DECIMAL(7,2),
  MODIFY COLUMN fare_amount          DECIMAL(8,2),
  MODIFY COLUMN tip_amount           DECIMAL(5,2),
  MODIFY COLUMN total_amount         DECIMAL(7,2),
  MODIFY COLUMN congestion_surcharge DECIMAL(4,2),
  MODIFY COLUMN cbd_congestion_fee   DECIMAL(6,2);
     
/********************************************
3. HANDLING NULLS
********************************************/
  -- rename columns
ALTER TABLE green_trips
  CHANGE COLUMN lpep_pickup_datetime  pickup_datetime  DATETIME,
  CHANGE COLUMN lpep_dropoff_datetime dropoff_datetime DATETIME;
  
  -- stored procedure to get null count for each column
CALL GetNullCounts('green_trips', 'green_trips');    
CALL GetNullCounts('green_trips', 'locations');
  
  -- replace 3785 passenger_count nulls with 1 (min)
  UPDATE green_trips
SET passenger_count = 1
WHERE passenger_count IS NULL;

  -- replace 3785 payment_type nulls with 5 as "UnKnown" as per data dictionary
   UPDATE green_trips
SET payment_type = 5
WHERE payment_type IS NULL;
  
  -- replace 3785 nulls with 0 as no surcharge was applied.
 UPDATE green_trips
SET congestion_surcharge = 0
WHERE congestion_surcharge IS NULL;

/********************************************
4. HANDLING DATA QUALITY ISSUES
********************************************/

-- deleted 287 trips whose fare_amount <= 0
DELETE FROM green_trips WHERE fare_amount <= 0;

-- deleted 58 trips whose total_amount <= 0
DELETE FROM green_trips WHERE total_amount <= 0;

--deleted 1381(2.8 % data approx) as per client
DELETE FROM green_trips WHERE trip_distance <= 0;

-- Normalize zone names
UPDATE locations SET Zone = TRIM(Zone);

-- checking duplicates in Zone names in location table
  SELECT Zone, COUNT(*) AS dup_count
FROM locations
GROUP BY Zone
HAVING COUNT(*) > 1;

--  Ensure location IDs exist in lookup
-- deleted 176 rows of 3 invalid pickup locations
DELETE FROM green_trips WHERE PULocationID NOT IN 
(SELECT LocationID FROM locations);

-- deleted 676 rows of 3 invalid dropoff locations
DELETE FROM green_trips WHERE DOLocationID NOT IN 
(SELECT LocationID FROM locations);

-- deleted 69 rows 
DELETE FROM green_trips WHERE tip_amount > fare_amount;

/********************************************
4. HANDLING OUTLIERS (Manual Thresholds)
********************************************/

SELECT min(trip_distance), max(trip_distance),
min(tip_amount), max(tip_amount),
min(fare_amount), max(fare_amount),
min(total_amount),max(total_amount)
from green_trips;

-- deleted 1 row
DELETE from green_trips where fare_amount >= 500;

-- deleted 1511 rows
DELETE from green_trips where fare_amount < 3;

-- deleted 8 rows
DELETE from green_trips where trip_distance > 50;

--203 rows deleted
Delete from green_trips where trip_distance < 0.3;

/********************************************
4. DERIVED COLUMNS 
********************************************/
-- Added  congestion_fee
ALTER TABLE green_trips
ADD COLUMN congestion_fee DECIMAL(6,2);

UPDATE green_trips 
SET congestion_fee = congestion_surcharge  +  cbd_congestion_fee;

---------------------------------------------------------

-- Added derived trip_category
ALTER TABLE green_trips
ADD COLUMN trip_category ENUM('Solo', 'Shared');

UPDATE green_trips 
SET trip_category = CASE 
    WHEN passenger_count = 1 THEN 'Solo' 
    ELSE 'Shared' 
END;

---------------------------------------------------------

-- Added payment_type
ALTER TABLE green_trips
ADD COLUMN payment_type1 ENUM('Credit Card', 'Cash','Other');

UPDATE green_trips 
SET payment_type1 = CASE 
    WHEN payment_type = 1 THEN 'Credit Card' 
    WHEN payment_type = 2 THEN 'Cash' 
    ELSE 'Other' 
END;

---------------------------------------------------------

-- Added distance_category
ALTER TABLE green_trips
ADD COLUMN distance_category ENUM('Short', 'Medium', 'Long');

UPDATE green_trips
SET distance_category = CASE
    WHEN trip_distance < 3.1 THEN 'Short'
    WHEN trip_distance BETWEEN 3.1 AND 6.5 THEN 'Medium'
    ELSE 'Long'
END;

-----------------------------------------

-- Added pickup_hour
ALTER TABLE green_trips 
ADD COLUMN pickup_hour INT;

UPDATE green_trips 
SET pickup_hour = HOUR(pickup_datetime);

-------------------------------------------------------------

-- Added pickup_day
ALTER TABLE green_trips 
ADD COLUMN pickup_day DATE;

UPDATE green_trips 
SET pickup_day = DATE(pickup_datetime);

-------------------------------
DROPPED passenger_count, payment_type, congestion_surcharge, cbd_congestion_fee;

/********************************************
4. FINAL SHAPE
********************************************/
44131 rows and  15 columns









