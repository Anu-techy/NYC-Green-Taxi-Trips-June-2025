# NYC Green Taxi Trips Analysis 🚖 (June 2025)

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
Cleaning queries, EDA insights, and stored procedures are provided in  
[`queries/nyc_green_taxi_analysis.sql`](queries/nyc_green_taxi_analysis.sql).  

The SQL script is organized into the following sections:  
1. **Peak Pickup Hours** – busiest hours and corresponding revenue.  
2. **Top Pickup & Dropoff Hotspots** – high-demand zones.  
3. **Impact of Congestion Fee** – revenue comparison between fee and non-fee trips.  
4. **Revenue Segmentation by Distance** – short, medium, and long trip contributions.  
5. **Borough-Wise Analysis** – trips, fares, and congestion by borough.  
6. **Pickup–Dropoff Zone Pairs** – most frequent OD pairs and total fares.  
7. **Same-Zone Trips** – intra-zone travel metrics.  

> ⚡ Note: Query outputs are **not embedded in the SQL file**.  
> To showcase results professionally, consider:  
> - Storing outputs in `/results` as CSV.  
> - Embedding key summaries in this README as Markdown tables.  

---

## 📈 2. Power BI Dashboard
An interactive **Power BI dashboard** was created to visualize key insights.  

**Filters:**  
- Borough  
- Time of Day  
- Distance Category  

**Visuals:**  
- Heatmap of pickup/dropoff hotspots  
- Revenue by trip distance  
- Congestion fee impact on revenue  
- Borough-wise revenue and trip count breakdown  

📷 *Screenshots of the dashboard are attached in the repo.*  
The `.pbix` file is included in [`dashboards/`](dashboards/).  

---

## 📂 Project Structure
nyc-green-taxi-analysis/
┣ queries/
┃ ┗ nyc_green_taxi_analysis.sql # SQL queries for EDA & insights
┣ dashboards/
┃ ┗ powerbi_dashboard.pbix # Power BI dashboard
┣ results/ # (Optional) CSV/MD outputs of queries
┣ README.md # Project documentation
3. insights of the dashboard attached
