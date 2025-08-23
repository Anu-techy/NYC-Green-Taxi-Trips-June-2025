-- ============================================
-- NYC Green Taxi Trip Analysis (EDA + Insights)
-- ============================================

-- ======================
-- 1. Peak Pickup Hours
-- ======================
SELECT pickup_hour,
       COUNT(*) AS trips,
       ROUND(SUM(total_amount),2) AS revenue
FROM green_trips
GROUP BY pickup_hour
ORDER BY trips DESC
LIMIT 5;


-- ===========================
-- 2. Top 10 Pickup Hotspots
-- ===========================
SELECT l.Zone, COUNT(*) AS pickups
FROM green_trips t
JOIN locations l
  ON t.PULocationID = l.LocationID
GROUP BY l.Zone
ORDER BY pickups DESC
LIMIT 10;


-- ===========================
-- 3. Top 10 Dropoff Hotspots
-- ===========================
SELECT l.Zone, COUNT(*) AS dropoffs
FROM green_trips t
JOIN locations l
  ON t.DOLocationID = l.LocationID
GROUP BY l.Zone
ORDER BY dropoffs DESC
LIMIT 10;


-- =======================================
-- 4. Impact of Congestion Fee on Revenue
-- =======================================
SELECT IF(congestion_fee > 0,'With Fee','No Fee') AS fee_status,
       COUNT(*) AS trips,
       ROUND(SUM(fare_amount),2) AS revenue,
       ROUND(AVG(fare_amount),2) AS avg_revenue
FROM green_trips
GROUP BY fee_status;


-- =====================================
-- 5. Revenue Segmentation by Distance
-- =====================================
SELECT 
   CASE 
      WHEN trip_distance <= 5 THEN 'Short'
      WHEN trip_distance <= 20 THEN 'Medium'
      ELSE 'Long'
   END AS distance_band,
   COUNT(*) AS num_trips,
   SUM(total_amount) AS total_revenue,
   ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM green_trips), 2) AS revenue_pct
FROM green_trips
GROUP BY distance_band;


-- ==========================================================
-- 6. Revenue & Trips by Distance Category (Short/Medium/Long)
-- ==========================================================
SELECT 
    -- Number of trips
    SUM(CASE WHEN distance_category = 'Short'  THEN 1 ELSE 0 END)  AS short_trips,
    SUM(CASE WHEN distance_category = 'Medium' THEN 1 ELSE 0 END)  AS medium_trips,
    SUM(CASE WHEN distance_category = 'Long'   THEN 1 ELSE 0 END)  AS long_trips,

    -- Total revenue
    ROUND(SUM(CASE WHEN distance_category = 'Short'  THEN fare_amount ELSE 0 END),2)  AS short_revenue,
    ROUND(SUM(CASE WHEN distance_category = 'Medium' THEN fare_amount ELSE 0 END),2) AS medium_revenue,
    ROUND(SUM(CASE WHEN distance_category = 'Long'   THEN fare_amount ELSE 0 END),2)   AS long_revenue
FROM green_trips;


-- ====================================
-- 7. Borough-Wise Trips and Congestion
-- ====================================
SELECT l.Borough,
       COUNT(*) AS total_trips,
       SUM(fare_amount) AS total_fare,
       SUM(CASE WHEN t.congestion_fee > 0 THEN 1 ELSE 0 END) AS congestion_trips
FROM green_trips t
JOIN locations l ON t.PULocationID = l.LocationID
GROUP BY l.Borough
ORDER BY total_trips DESC;


-- ======================================================
-- 8. Top Pickup-Dropoff Zone Pairs (Trips & Total Fare)
-- ======================================================
SELECT 
    lp.Zone AS pickup_zone,
    ld.Zone AS dropoff_zone,
    COUNT(*) AS trip_count,
    SUM(t.fare_amount) AS total_fare
FROM green_trips t
JOIN locations lp ON t.PULocationID = lp.LocationID
JOIN locations ld ON t.DOLocationID = ld.LocationID
GROUP BY lp.Zone, ld.Zone
ORDER BY trip_count DESC   -- or total_fare DESC
LIMIT 10;


-- =====================================================
-- 9. Top 3 Pickup Zones Per Borough (Trips & Total Fare)
-- =====================================================
SELECT Borough, Zone, trip_count, total_fare
FROM (
    SELECT l.Borough, l.Zone,
           COUNT(*) AS trip_count,
           SUM(t.fare_amount) AS total_fare,
           ROW_NUMBER() OVER (
               PARTITION BY l.Borough 
               ORDER BY COUNT(*) DESC
           ) AS rn
    FROM green_trips t
    JOIN locations l ON t.PULocationID = l.LocationID
    GROUP BY l.Borough, l.Zone
) ranked
WHERE rn <= 3
ORDER BY trip_count DESC;   -- or ORDER BY total_fare DESC


-- ======================================================
-- 10. Same Zone Trips Metrics (Intra-Zone Journeys)
-- ======================================================
SELECT 
    l.Zone AS pickup_zone,
    lc.Zone AS dropoff_zone,
    COUNT(*) AS trip_count,
    SUM(t.fare_amount) AS total_fare,
    ROUND(AVG(t.fare_amount), 2) AS avg_fare_per_trip
FROM green_trips t
JOIN locations l  ON t.PULocationID = l.LocationID
JOIN locations lc ON t.DOLocationID = lc.LocationID
WHERE t.PULocationID = t.DOLocationID
GROUP BY l.Zone, lc.Zone
ORDER BY total_fare DESC
LIMIT 5;

-- ======================================
-- End of File
-- ======================================
