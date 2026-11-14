# Zimbabwe CO₂ Emissions Analysis

## Project Overview
This project explores historical and recent carbon dioxide (CO₂) emissions in **Zimbabwe** using R. It uses the Our World in Data (OWID) CO₂ and Greenhouse Gas Emissions dataset and the `tidyverse` / `ggplot2` packages.

## Research Focus
The analysis examines:
1. Zimbabwe's annual territorial CO₂ emissions from 1970 onward.
2. CO₂ emissions per person over time.
3. Emissions from selected sources: coal, oil, and cement.

## Data Source
- [Our World in Data — CO₂ and Greenhouse Gas Emissions dataset](https://github.com/owid/co2-data)

The R script downloads the dataset when it runs. Results depend on the latest data available from OWID at that time.

## Methodology
1. Download the OWID dataset from its public GitHub repository.
2. Filter the data to observations for Zimbabwe from 1970 onward.
3. Select total CO₂ emissions, per-capita emissions, and the coal, oil, and cement emissions variables.
4. Create three time-series visualizations with `ggplot2`.
5. Save the figures as PNG files at 300 DPI in the `figures/` folder.

## How to Run
Install R, then install the required packages if they are not already available:

```r
install.packages(c("tidyverse", "scales"))
```

Run the script from the repository's root directory:

```r
source("zimbabwe_co2_analysis.R")
```

The script creates the `figures/` directory (if needed) and saves:
- `figures/fig1_zimbabwe_co2_trend.png`
- `figures/fig2_zimbabwe_per_capita.png`
- `figures/fig3_zimbabwe_by_source.png`

## Repository Structure
- `README.md` — Project overview, data source, and instructions.
- `zimbabwe_co2_analysis.R` — Reproducible R analysis script.
- `figures/` — Output folder created by the script for the three visualizations.

## Notes
This repository currently contains the analysis script and project documentation. The figures are generated when the script is run in an R environment with an internet connection. Numerical findings and interpretations should be added after reviewing the generated charts and the corresponding data.
