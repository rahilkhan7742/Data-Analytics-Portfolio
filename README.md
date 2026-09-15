# Data-Analytics-Portfolio
# Project 1: EV Market & Adoption Analysis 

An end-to-end Data Analytics project analyzing over 109K+ Electric Vehicle (EV) registration records using MySQL and Power BI. This project evaluates brand dominance, technology adoption rates (BEV vs. PHEV), battery range performance, 

## Tools Used
- Power Query (data cleaning)
- SQL (querying and analysis)
- Power BI (DAX Functions,dashboard design)

## Dataset
- Source: Washington State Electric Vehicle Population Data 
- Records analyzed: 109K+ (at time of download; source dataset 
  updates periodically, so current record count may differ)
- Key fields used: Make, Model Year, City, State,  Clean Alternative Fuel Vehicl (CAFV) Eligibility, 
  Electric Range

---
## Key Findings
- Tesla is the leading manufacturer, with a 46% share (49,941 vehicles) of the analyzed dataset
- Top adopting cities: Seattle, Bellevue, Redmond, Vancouver, Kirkland — all within Washington State
- CAFV eligibility: 53.54% eligible, 32.92% eligibility unknown (due to missing/incomplete battery-range data), 13.54% not 
  eligible due to low battery range
  
 EV Technology Split & Range Performance Gap:
   -The market shows high adoption of BEVs (75.65%) over PHEVs.
  - Custom DAX calculations reveal that BEVs deliver an average electric range of 193.51 miles, compared to just 30.95 miles for PHEVs—a crucial factor driving consumer choice toward pure electrics.

* Heavy Volume Bias in Top Manufacturers:
  * The top 3 brands (Tesla, Nissan, and Chevrolet) control ~66.5% of the total EV market share, highlighting a steep gap between early market leaders and emerging competitors.

---


##  How to Replicate This Project

1. Database Setup: 
   * Import the dataset into MySQL Workbench under the table name electric_vehicle_population.
   * Run the provided MYEVPRO.sql file to verify insights.
2. Dashboard Visuals: 
   * Open the .pbix file in Power BI Desktop to inspect data models, DAX measures, and visual layouts.


📌 Conclusion: Consumers and manufacturers are shifting rapidly toward pure electric tech. Hybrids are acting as a temporary bridge, not the long-term destination.











 --- 


# Project 2:Hotel Booking & Cancellation Analysis (SQL + Power BI)


## Overview
This is a personal portfolio project analyzing hotel booking and cancellation data using SQL and Power BI. This is NOT based on a 
real client engagement — it uses a public sample  hotel booking dataset to demonstrate data cleaning, analysis, and dashboard-
building skills.

## Dataset
- Source: Random Dataset Downloaded
- Records analyzed: 5,000 bookings
- Key fields used: Booking Channel, Status, Loyalty Level, 
  Booking Value, Cancellation Status, Lead Time

## Tools Used
- SQL (analysis and querying)
- Power Query (data cleaning)
- Power BI (Charts, DAX, dashboard design)

## Key Findings
- Total booking value: $1.33M across 5,000 bookings
- Total room nights: 9,000
- Cancellation rate: 28.72% (1,440 total cancellations)
- Potential lost revenue from cancellations: $427K
- Top booking channel by revenue: Velora.com, followed by GDS and "At the hotel"
- Revenue by loyalty tier: Non-member segment contributed the  highest revenue ($518.11K), followed by Essential ($277.91K), 
  Preferred ($144.24K), Premier ($114.88K), Select ($114.33K),  Elite ($106.53K), and Iconic ($49.36K)
- Most cancellations occurred for bookings made less than a week  before the stay date (lead time analysis)
- Monthly potential lost revenue peaked in October 2024

## How Potential Lost Revenue Was Calculated
Potential Lost Revenue = CALCULATE(SUM(bookings[Revenue]),bookings[Status] = "Cancelled")

## Assumptions & Limitations
- Cancelled bookings are treated as potential revenue loss. This figure does NOT confirm actual business loss — cancelled rooms 
  may have been resold, in which case the real revenue impact would be lower.
- Findings are based on the dataset above and are not from a real client engagement.
- Data covers September 1, 2024 – November 4, 2024 only.



















