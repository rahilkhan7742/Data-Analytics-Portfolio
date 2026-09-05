# Data-Analytics-Portfolio
# Project 1: EV Market & Brand Compliance Analysis 

An end-to-end Data Analytics project analyzing over 150K+ Electric Vehicle (EV) registration records using MySQL and Power BI. This project evaluates brand dominance, technology adoption rates (BEV vs. PHEV), battery range performance, and regulatory compliance risks across EV manufacturers.


## Tech Stack & Tools Used
* Database Engine: MySQL Workbench
* Analytics & Visualization: Power BI Desktop
* Querying Techniques: CTEs, Window Functions (DENSE_RANK, ROW_NUMBER, LAG), Aggregations, Conditional Logic (CASE, COALESCE)
* Data Modeling: DAX (Data Analysis Expressions), Custom Calculated Columns & Measures

---

## 💡 Key Business Insights

* Market Monopoly vs. Regulatory Compliance Risk:
  * Tesla dominates the overall EV landscape with a 45.62% market share. However, it holds a CAFV Eligibility Rate of only 51.14%.
  * Data auditing reveals that legacy manufacturers lead in verified compliance: Nissan (87.27%) and Chevrolet (87.11%) show near-perfect eligibility rates, proving a stronger alignment with verified battery-range criteria.

* EV Technology Split & Range Performance Gap:
  * The market shows high adoption of BEVs (75.65%) over PHEVs.
  * Custom DAX calculations reveal that BEVs deliver an average electric range of 193.51 miles, compared to just 30.95 miles for PHEVs—a crucial factor driving consumer choice toward pure electrics.

* Heavy Volume Bias in Top Manufacturers:
  * The top 3 brands (Tesla, Nissan, and Chevrolet) control ~66.5% of the total EV market share, highlighting a steep gap between early market leaders and emerging competitors.

---


## 🚀 How to Replicate This Project

1. Database Setup: 
   * Import the dataset into MySQL Workbench under the table name electric_vehicle_population.
   * Run the provided MYEVPRO.sql file to verify insights.
2. Dashboard Visuals: 
   * Open the .pbix file in Power BI Desktop to inspect data models, DAX measures, and visual layouts.


📌 Conclusion: Consumers and manufacturers are shifting rapidly toward pure electric tech. Hybrids are acting as a temporary bridge, not the long-term destination.











 --- 


#Project 2:Hotel Revenue Leakage & Cancellation Analysis (SQL + Power BI)


##  Executive Project Summary
This project delivers an end-to-end analytics solution addressing financial leakage, booking cancellations, and customer tier performance for a hospitality portfolio. Using SQL MySQL for data extraction/transformation and Power BI for visual reporting, raw transaction data was transformed into actionable operational insights.

---

## 📊 Core Business KPIs
* Total Booking Volume: 5K Bookings
* Total Realized Revenue: $1.33M
* Total Room Nights: 9K Nights
* Total Cancellations: 1.44K Bookings
* Overall Cancellation Rate: 28.72%
* Direct Revenue Loss: $427K (due to cancellations)

---

## 🛠️ End-to-End Analytics Workflow

​63% Loss Leakage via 2 Channels: Out of $427K total lost revenue, Velora.com (31.89%) and GDS (31.08%) account for ~$270K (~63%) of all lost revenue.

​High-Volume Non-Member Reliance: Non-member accounts bring the largest revenue share ($518.11K), but registered tiers (Essential $277.91K, Premier $114.88K) deliver higher daily rate consistency.

​Last-Minute Cancellation Risk: Over 2,500+ bookings occur within 1 week of arrival, making short lead times the highest operational threat for drop-offs
















