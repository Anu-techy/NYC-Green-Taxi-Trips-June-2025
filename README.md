## 🛠️ 1. Data Preprocessing & EDA in MySQL

The SQL scripts in [`queries/`](queries/) cover both **data cleaning** and **EDA/insights**.  

### Contents:
1. **Peak Pickup Hours** – busiest hours and corresponding revenue.  
2. **Top Pickup & Dropoff Hotspots** – high-demand zones.  
3. **Impact of Congestion Fee** – revenue comparison between fee and non-fee trips.  
4. **Revenue Segmentation by Distance** – short, medium, and long trip contributions.  
5. **Borough-Wise Analysis** – trips, fares, and congestion by borough.  
6. **Pickup–Dropoff Zone Pairs** – most frequent OD pairs and total fares.  
7. **Same-Zone Trips** – intra-zone travel metrics.  

📂 Files:  
- `Cleaning_Queries.sql` → Preprocessing and handling nulls  
- `nyc_green_taxi_analysis.sql` → Insights and exploratory queries  
- `stored_procedures.sql` → Null counts, borough details  

📝 Query results are compiled in [`results.doc`](results.doc).  

---

## 📈 2. Power BI Dashboard

An interactive **Power BI dashboard** was created to visualize insights derived from MySQL analysis.  

**Filters Available:**  
- Borough  
- Time of Day  
- Distance Category  

**Visuals Include:**  
- Heatmap of pickup/dropoff hotspots  
- Revenue by trip distance  
- Congestion fee impact on revenue  
- Borough-wise revenue and trip count breakdown  

📷 *Screenshots of the dashboard are attached in the repo.*  

---

## 📂 Project Structure
nyc-green-taxi-analysis/
┣ queries/
┃ ┣ Cleaning_Queries.sql
┃ ┣ nyc_green_taxi_analysis.sql
┃ ┗ stored_procedures.sql
┣ dashboards/
┃ ┗ powerbi_dashboard.pbix
┣ results/
┃ ┗ results.doc
┣ README.md



## 🚀 Key Insights
- **Peak demand:** Evening hours (4–7 PM).  
- **Hotspots:** East Harlem dominates pickups and dropoffs.  
- **Congestion fee:** Despite fewer trips, contributes ~40% of revenue.  
- **Revenue split:** Short trips generate ~67% of revenue.  
- **Borough share:** Manhattan leads in trips and total fare.  

---

## 👩‍💻 Author
Analysis & Dashboard by *Anusha*  
give the attachments details in a table

---


3. insights of the dashboard attached
