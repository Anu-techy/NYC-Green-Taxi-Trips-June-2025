# NYC Green Taxi Trips Analysis 🚖

This project explores **New York City Green Taxi trip data** to uncover patterns, business insights, and opportunities for operational improvements.  

The workflow includes:  
1. **Data Preprocessing in MySQL** – cleaning, feature engineering, and exploratory analysis using SQL.  
2. **Interactive Power BI Dashboard** – visualization of trip patterns, revenues, and hotspots.  

---

## 📊 Dataset
- **Source:** [NYC Taxi & Limousine Commission (TLC) Trip Record Data](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page)  
- **Dictionary:** [Data Dictionary (Green Taxi)](https://www.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_green.pdf)  
- Covers trip details like pickup/dropoff locations, timestamps, fares, distance, and congestion fees.

---

## 🛠️ 1. Data Preprocessing & EDA in MySQL
All queries are included in [`queries/nyc_green_taxi_analysis.sql`](queries/nyc_green_taxi_analysis.sql).  
The script is organized into the following sections:

1. **Peak Pickup Hours** – find the busiest hours and corresponding revenue.  
2. **Top Pickup & Dropoff Hotspots** – identify high-demand zones.  
3. **Impact of Congestion Fee** – compare revenue from fee vs. non-fee trips.  
4. **Revenue Segmentation by Distance** – short, medium, and long trip contributions.  
5. **Borough-Wise Analysis** – trips, fares, and congestion impact by borough.  
6. **Pickup–Dropoff Zone Pairs** – most frequent OD pairs and total fares.  
7. **Same-Zone Trips** – intra-zone travel metrics.  
