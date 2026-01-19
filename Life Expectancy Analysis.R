library(tidyverse)
df <- read_csv("C:/Users/tamci/OneDrive/Desktop/R projects/Life Expectancy Analysis/indicator-90366-all-areas.data.csv")

df <- df %>%
  rename(
    IndicatorID = `Indicator ID`,
    IndicatorName = `Indicator Name`,
    ParentCode = `Parent Code`,
    ParentName = `Parent Name`,
    AreaCode = `Area Code`,
    AreaName = `Area Name`,
    AreaType = `Area Type`,
    CategoryType = `Category Type`,
    Timeperiod = `Time period`,
    LowerCI95 = `Lower CI 95.0 limit`,
    UpperCI95 = `Upper CI 95.0 limit`,
    LowerCI998 = `Lower CI 99.8 limit`,
    UpperCI998 = `Upper CI 99.8 limit`,
    ValueNote = `Value note`,
    RecentTrend = `Recent Trend`,
    ComparedToEngland = `Compared to England value or percentiles`,
    TimeperiodSortable = `Time period Sortable`,
    NewData = `New data`,
    ComparedToGoal = `Compared to goal`,
    TimeperiodRange = `Time period range`
  )

indicator_title <- unique(df$IndicatorName)
indicator_title

missing_summary <- df %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(),
               names_to = "variable",
               values_to = "missing_count") %>%
  arrange(desc(missing_count))

missing_summary

ggplot(df, aes(x = Value)) +
  geom_histogram(bins = 30, fill = "#2C7BB6", colour = "white") +
  theme_minimal() +
  labs(
    title = paste("Distribution of", indicator_title),
    x = "Years",
    y = "Count"
  )

df_single_year <- df %>%
  filter(!stringr::str_detect(Timeperiod, "-"))

ggplot(df_single_year, aes(x = Timeperiod, y = Value)) +
  geom_boxplot(fill = "#ABD9E9") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 14, face = "bold")
  ) +
  labs(
    title = paste(indicator_title, "by year"),
    x = "Time period",
    y = "Years"
  )

#Filtering to single year periods only
df_single_year <- df %>%
  filter(!stringr::str_detect(Timeperiod, "-"))

#Identifying the latest single year period
latest_period <- max(df_single_year$Timeperiod, na.rm = TRUE)

#Filtering to this year
df_latest <- df_single_year %>%
  filter(Timeperiod == latest_period)

best_area <- df_latest %>% slice_max(Value, n = 1) %>% pull(AreaName)
worst_area <- df_latest %>% slice_min(Value, n = 1) %>% pull(AreaName)

best_area
worst_area

#Selecting areas
areas <- c("England", "Liverpool", "Manchester", best_area, worst_area)

#Plotting trends
df_single_year %>%
  filter(AreaName %in% areas) %>%
  ggplot(aes(Timeperiod, Value, colour = AreaName, group = AreaName)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = paste("Trends in", indicator_title),
    subtitle = "Year-by-year trends",
    x = "Time period",
    y = "Years",
    colour = "Area"
  )

#Filtering to single year periods
df_single_year <- df %>%
  filter(!stringr::str_detect(Timeperiod, "-"))

#Identifying the latest single year period
latest_period <- max(df_single_year$Timeperiod, na.rm = TRUE)

#Filtering to this year
df_latest_unique <- df_single_year %>%
  filter(Timeperiod == latest_period)

#Selecting top and bottom 10 areas
top10 <- df_latest_unique %>% slice_max(Value, n = 10)
bottom10 <- df_latest_unique %>% slice_min(Value, n = 10)

df_top_bottom <- bind_rows(top10, bottom10)

#Creating a plot
ggplot(df_top_bottom, aes(x = reorder(AreaName, Value), y = Value)) +
  geom_point(size = 3, colour = "#2C7BB6") +
  coord_flip() +
  theme_minimal() +
  labs(
    title = paste("Top 10 and Bottom 10 Areas for", indicator_title, "-", latest_period),
    x = "Area",
    y = "Years"
  )

df_single_year <- df %>%
  filter(!stringr::str_detect(Timeperiod, "-"))
variation_single_year <- df_single_year %>%
  group_by(Timeperiod) %>%
  summarise(
    sd_value = sd(Value, na.rm = TRUE)
  )
ggplot(variation_single_year, aes(x = Timeperiod, y = sd_value, group = 1)) +
  geom_line(colour = "#2C7BB6", linewidth = 1.2) +
  geom_point(colour = "#2C7BB6", size = 2) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = "Between-Area Variation in Life Expectancy",
    x = "Year",
    y = "Standard deviation (years)"
  )
