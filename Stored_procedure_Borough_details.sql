/******************************************************
-- Stored procedure to get top zone details for a given Borough
*******************************************************/
DELIMITER $$

CREATE PROCEDURE GetTopPickupZonesByBorough ( 
    IN borough_name VARCHAR(50), 
    IN top_n INT 
)
BEGIN
    SELECT l.Borough, l.Zone, 
           COUNT(*) AS trip_count, 
           SUM(t.fare_amount) AS total_fare, 
           ROUND(SUM(t.fare_amount)/COUNT(*), 2) AS avg_fare_per_trip 
    FROM green_trips t 
    JOIN locations l ON t.PULocationID = l.LocationID 
    WHERE l.Borough = borough_name 
    GROUP BY l.Borough, l.Zone 
    ORDER BY trip_count DESC 
    LIMIT top_n;
END$$

DELIMITER ;

CALL GetTopPickupZonesByBorough('Queens', 5);

+---------+-----------------+------------+------------+-------------------+
| Borough | Zone            | trip_count | total_fare | avg_fare_per_trip |
+---------+-----------------+------------+------------+-------------------+
| Queens  | Forest Hills    |       1886 |   33153.95 |             17.58 |
| Queens  | Elmhurst        |       1630 |   29638.65 |             18.18 |
| Queens  | Jamaica         |       1421 |   35040.66 |             24.66 |
| Queens  | Jackson Heights |        554 |   10430.28 |             18.83 |
| Queens  | Kew Gardens     |        508 |    8505.34 |             16.74 |
+---------+-----------------+------------+-------
