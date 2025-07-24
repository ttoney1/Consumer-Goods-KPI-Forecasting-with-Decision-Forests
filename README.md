# Consumer-Goods-KPI-Forecasting-with-Decision-Forests
# 📘 Consumer Goods KPI Forecasting with Decision Forests

## 🔍 Overview
This R script runs an advanced analytics workflow for a consumer goods client, using **Decision Forest (Random Forest)** models to forecast critical KPIs. It imports raw data, trains models, and exports outputs for interactive reporting in **Power BI**.

---

## 🧠 Objectives

- Generate synthetic operational and marketing data
- Train three Decision Forest models to predict:
  - On-Time In-Full (OTIF) delivery status
  - Inventory levels
  - Marketing ROI
- Export results and feature importance to CSV for dashboard use

---

## 🛠️ Requirements

### R Packages Used

- `randomForest` — model training
- `dplyr` — data wrangling
- `readr` — data export

### Install Packages

```r
install.packages(c("randomForest", "dplyr", "readr"))

