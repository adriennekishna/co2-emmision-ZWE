# ==============================================================================
# Title: CO2 Emissions Analysis - Zimbabwe
# Author: [Adrienne Kishna P. Calimbo]
# Date: November 2026
# ==============================================================================

# 1. Install and load required packages
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

# Create a directory to store output figures
if (!dir.exists("figures")) dir.create("figures")

# 2. Load the Our World in Data (OWID) CO2 dataset directly
url <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
co2_data <- read.csv(url)

# 3. Filter data for Zimbabwe (from 1950 to most recent available year)
zimbabwe_co2 <- co2_data %>%
  filter(country == "Zimbabwe", year >= 1950) %>%
  select(
    year, 
    co2,                # Annual total CO2 emissions (million tonnes)
    co2_per_capita,     # CO2 emissions per person (tonnes)
    coal_co2,           # Emissions from coal
    oil_co2,            # Emissions from oil
    cement_co2          # Emissions from cement
  )

# Inspect the dataset and summary statistics
head(zimbabwe_co2)
tail(zimbabwe_co2)
summary(zimbabwe_co2)

# ==============================================================================
# 4. Generate & Save Line Plots
# ==============================================================================

# --- FIGURE 1: Annual Total CO2 Emissions Over Time ---
plot1 <- ggplot(zimbabwe_co2, aes(x = year, y = co2)) +
  geom_line(color = "#1b7837", linewidth = 1.2) +
  geom_point(color = "#1b7837", size = 1.5, alpha = 0.7) +
  labs(
    title = "Annual Total CO2 Emissions in Zimbabwe (1950–Present)",
    subtitle = "Territorial emissions from fossil fuels and industry",
    x = "Year",
    y = "Annual CO2 Emissions (Million Tonnes)",
    caption = "Source: Our World in Data / Global Carbon Budget"
  ) +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))

ggsave("figures/01_zimbabwe_total_co2.png", plot = plot1, width = 8, height = 5, dpi = 300)

# --- FIGURE 2: Per Capita CO2 Emissions Over Time ---
plot2 <- ggplot(zimbabwe_co2, aes(x = year, y = co2_per_capita)) +
  geom_area(fill = "#a6dba0", alpha = 0.5) +
  geom_line(color = "#005a32", linewidth = 1.1) +
  labs(
    title = "Per Capita CO2 Emissions in Zimbabwe (1950–Present)",
    subtitle = "Average annual carbon dioxide emissions per person",
    x = "Year",
    y = "CO2 Emissions per Capita (Tonnes)",
    caption = "Source: Our World in Data / Global Carbon Budget"
  ) +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))

ggsave("figures/02_zimbabwe_per_capita_co2.png", plot = plot2, width = 8, height = 5, dpi = 300)

# --- FIGURE 3: CO2 Emissions by Fuel/Industry Source ---
zimbabwe_sources <- zimbabwe_co2 %>%
  select(year, Coal = coal_co2, Oil = oil_co2, Cement = cement_co2) %>%
  pivot_longer(cols = c(Coal, Oil, Cement), names_to = "Source", values_to = "Emissions") %>%
  filter(!is.na(Emissions))

plot3 <- ggplot(zimbabwe_sources, aes(x = year, y = Emissions, color = Source)) +
  geom_line(linewidth = 1.1) +
  scale_color_manual(values = c("Coal" = "#252525", "Oil" = "#d95f02", "Cement" = "#7570b3")) +
  labs(
    title = "Zimbabwe CO2 Emissions by Fuel & Industry Type",
    subtitle = "Breakdown of annual emissions across Coal, Oil, and Cement",
    x = "Year",
    y = "CO2 Emissions (Million Tonnes)",
    color = "Source",
    caption = "Source: Our World in Data / Global Carbon Budget"
  ) +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"), legend.position = "top")

ggsave("figures/03_zimbabwe_co2_by_source.png", plot = plot3, width = 8, height = 5, dpi = 300)

print("All figures generated successfully in the 'figures/' folder!")
