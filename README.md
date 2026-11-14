# Zimbabwe CO₂ Emissions Analysis

## 📌 Project Overview
This repository documents an exploratory data analysis of **Zimbabwe's historical and recent carbon dioxide (CO₂) emissions** using **R** and the `tidyverse` (`ggplot2`) package. Data is sourced directly from the [Our World in Data (OWID) CO₂ and Greenhouse Gas Emissions dataset](https://github.com/owid/co2-data).

---

## 📊 Key Findings & Visualizations

### 1. Historical Annual CO₂ Emissions (1970–2025)
- Zimbabwe's territorial CO₂ emissions peaked in the early 1990s (~19.1 million tonnes in 1992), declined through the 2000s economic contraction (reaching ~8.3 Mt in 2008), and have steadily rebounded to ~16–17.3 Mt in recent years.
- Globally, Zimbabwe contributes roughly **0.03%–0.04%** of annual global CO₂ emissions.

![Zimbabwe Annual CO2 Emissions](fig1_zimbabwe_co2_trend.png)

### 2. Per Capita CO₂ Emissions
- While total emissions have rebounded, population growth means per capita emissions (~0.7–1.02 tonnes per person) remain lower than their 1970s and early-1990s highs (~1.75 tonnes per person).

![Zimbabwe Per Capita CO2 Emissions](fig2_zimbabwe_per_capita.png)

### 3. Emissions by Fuel & Industry Source
- **Coal** is the dominant driver of Zimbabwe's fossil fuel emissions (tied to thermal power generation like Hwange Power Station), followed by **Oil** (transport and liquid fuels) and **Cement** manufacturing.

![Zimbabwe CO2 Emissions by Source](fig3_zimbabwe_by_source.png)

---

## 🛠️ Methodology & Steps
1. **Data Acquisition:** Loaded the live CSV dataset directly from OWID's GitHub repository via `read_csv()`.
2. **Data Wrangling:** Filtered observations for `country == "Zimbabwe"` from `1970` onward and selected total emissions, per capita metrics, and fuel-specific variables (`coal_co2`, `oil_co2`, `cement_co2`).
3. **Visualization:** Built three custom charts using `ggplot2` and exported them at 300 DPI via `ggsave()`.

## 📂 Repository Structure
- `README.md` — Project documentation, methodology, and embedded visual outputs.
- `zimbabwe_co2_analysis.R` — Complete, reproducible R script.
- `fig1_zimbabwe_co2_trend.png` — Line/area plot of annual CO₂ emissions.
- `fig2_zimbabwe_per_capita.png` — Bar chart of per capita emissions over time.
- `fig3_zimbabwe_by_source.png` — Bar chart comparing emissions by fuel source.
