# Zimbabwe CO₂ Emissions Analysis
# Reproducible exploratory analysis using Our World in Data (OWID).

# Install required packages once if needed:
# install.packages(c("tidyverse", "scales"))

library(tidyverse)
library(scales)

# Download the OWID CO2 dataset.
owid_url <- "https://github.com/owid/co2-data/raw/refs/heads/master/owid-co2-data.csv"
co2_data <- readr::read_csv(owid_url, show_col_types = FALSE)

# Keep Zimbabwe from 1970 onward and the variables used in this analysis.
zimbabwe <- co2_data %>%
  filter(country == "Zimbabwe", year >= 1970) %>%
  select(year, co2, co2_per_capita, coal_co2, oil_co2, cement_co2) %>%
  arrange(year)

if (nrow(zimbabwe) == 0) {
  stop("No Zimbabwe observations were found in the downloaded OWID dataset.")
}

# Create an output folder for the figures.
dir.create("figures", showWarnings = FALSE)

# 1. Annual territorial CO2 emissions (million tonnes).
p_total <- zimbabwe %>%
  filter(!is.na(co2)) %>%
  ggplot(aes(x = year, y = co2)) +
  geom_line(linewidth = 1, color = "#2878A5") +
  labs(
    title = "Annual CO2 Emissions in Zimbabwe",
    subtitle = "Territorial fossil CO2 emissions, 1970 onward",
    x = "Year",
    y = "CO2 emissions (million tonnes)",
    caption = "Source: Our World in Data CO2 and Greenhouse Gas Emissions dataset"
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/fig1_zimbabwe_co2_trend.png", p_total,
       width = 9, height = 5.5, dpi = 300)

# 2. Annual CO2 emissions per person (tonnes per person).
p_per_capita <- zimbabwe %>%
  filter(!is.na(co2_per_capita)) %>%
  ggplot(aes(x = year, y = co2_per_capita)) +
  geom_line(linewidth = 1, color = "#3A8D6D") +
  labs(
    title = "CO2 Emissions per Capita in Zimbabwe",
    subtitle = "Annual territorial fossil CO2 emissions per person",
    x = "Year",
    y = "Tonnes of CO2 per person",
    caption = "Source: Our World in Data CO2 and Greenhouse Gas Emissions dataset"
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/fig2_zimbabwe_per_capita.png", p_per_capita,
       width = 9, height = 5.5, dpi = 300)

# 3. Emissions by selected source: coal, oil, and cement.
source_data <- zimbabwe %>%
  select(year, coal_co2, oil_co2, cement_co2) %>%
  pivot_longer(
    cols = c(coal_co2, oil_co2, cement_co2),
    names_to = "source",
    values_to = "co2"
  ) %>%
  mutate(
    source = recode(
      source,
      coal_co2 = "Coal",
      oil_co2 = "Oil",
      cement_co2 = "Cement"
    )
  ) %>%
  filter(!is.na(co2))

p_sources <- ggplot(source_data, aes(x = year, y = co2, color = source)) +
  geom_line(linewidth = 0.9) +
  labs(
    title = "Zimbabwe CO2 Emissions by Selected Source",
    subtitle = "Coal, oil, and cement-related emissions",
    x = "Year",
    y = "CO2 emissions (million tonnes)",
    color = "Source",
    caption = "Source: Our World in Data CO2 and Greenhouse Gas Emissions dataset"
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/fig3_zimbabwe_by_source.png", p_sources,
       width = 9, height = 5.5, dpi = 300)

# Print the latest available observation for a quick data check.
latest <- zimbabwe %>%
  filter(!is.na(co2)) %>%
  slice_max(year, n = 1, with_ties = FALSE) %>%
  select(year, co2, co2_per_capita)

print(latest)
message("Analysis complete. Figures saved in the figures/ folder.")
