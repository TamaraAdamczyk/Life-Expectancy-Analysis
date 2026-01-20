# Life-Expectancy-Analysis
This project aims to explore life expectancy at birth across local areas in England using publicly available dataset from Fingertips platform. This project uses tidyverse for data wrangling and manipulation and ggplot2 for visualization.

# INTRODUCTION
This project aims to explore life expectancy at birth across local areas in England using publicly available dataset from Fingertips platform. Overarching goal is to practice skills in data cleaning, exploratory analysis, and visualization using RStudio. 

# METHODS

This project uses tidyverse for data wrangling and manipulation and ggplot2 for visualization.

The analysis proceeds through a series of structured stages, including:
- Data import and preparation
- Evaluation of missing values and data completeness
- Exploration of value distributions
- Visualisation of temporal trends
- Ranking and comparison of local areas
- Assessment of between‑area variation over time

Firstly, data is imported into RStudio. The original format is csv. Column names from the original table are renamed for ease of use. Original headers contain spaces, characters, numbers, punctuation and capital letters which make further analysis and code writing more laborious and error-prone. Also, dataset uses raw indicator ID i.e. 90366. It is important to identify the full name of it and assign the name, otherwise graphs will look like 'Distribution of indicator 90366' which is not very informative to anyone reading the report.

For the purposes of this analysis, single year time periods were used. The dataset includes both single year values and multi year periods, with the latter representing rolling averages. Rolling averages smooth short term fluctuations, and they are not directly comparable to true annual estimates. The aim of the analysis is to examine year on year trends, identify specific annual changes, and compare areas on a like for like basis. Using only single year values ensures that all areas are assessed using the same temporal resolution and avoids mixing different types of estimates. This is why the code filters to single year periods rather than using the full dataset.

Next step is to assess variables with incomplete data i.e. N/A, NULLs, blank cells etc. Any fields with substantial missingness may affect analysis or require cleaning. It is important to perform assessment of missing variables as a part of data quality check. There is high missingness in several variables but most of missing values are in non-essential fields. This means that essential analytical fields, e.g. Area Name or Time period are consistently populated with values and complete therefore indicating good data quality for the purpose of this analysis.

# RESULTS
## Distribution of Life Expectancy Across Local Areas
Histogram is created to show distribution of life expectancy values across all areas. This is helpful to see where most areas cluster, whether there are any unusually high or low values.
<img width="3072" height="1152" alt="image" src="https://github.com/user-attachments/assets/d7256047-9a09-4a0c-9637-61e61f883e1d" />

The histogram shows that life expectancy is fairly consistent across England with the peak around ~80 years. The distribution is approximately normal without extreme skewness or heavy tails. Only a small number of areas fall at the lower or higher extremes indicating limited outliers.

## Year‑by‑Year Variation in Life Expectancy
A box plot is created to visualize medians, interquartile ranges, and overall spread of values, and any potential outliers. It provides an overview of how life expectancy is distributed across all areas in a given year.
<img width="3072" height="1152" alt="image" src="https://github.com/user-attachments/assets/3b70fd16-5e17-4d25-b012-a40fb8968be1" />

Life expectancy at birth shows a long-term rise from 2001 to 2014, followed by a period of stagnation and then decline during the COVID-19 pandemic (from 2020). The boxplots show steady upward movement in the median and upper quartile during the early 2000s and 2010s with improvements slowing after 2015. Variation between areas remains persistent across the analysed time-period, with occasional narrowing followed by widening during 2020-2021. Data suggests long-term improvement interrupted by 2014-2018 stagnation and subsequently a pandemic-related shock, with persevering geographic inequalities.

## Long‑Term Trends in Selected Areas
A multi-series line graph is created to show year-by-year trends in life expectancy for selected areas. England is used as a ‘benchmark’ to which other areas are compared, code is created to capture ‘the worst’ area with the lowest life expectancy and ‘the best area’ with the highest life expectancy. Firstly, areas are selected according to the most recent data (2023) and trends are presented across the range of available years.
<img width="3072" height="1152" alt="image" src="https://github.com/user-attachments/assets/c48459f1-c0cd-43ee-bb92-66353595009b" />

The chart illustrates a persistent and substantial gap between the highest-performing area, Richmond upon Thames, and the lowest-performing area, Blackpool. Liverpool and Manchester are consistently below the England’s average. This graph provides another proof of persistent geographic inequalities in life expectancy with no evidence of the gap narrowing across the measured period.

## Ranking of Areas: Highest and Lowest Life Expectancy
A dot plot is created to illustrate top 10 and bottom 10 performing areas in England for year 2023, and compare their life expectancies.
<img width="3072" height="1152" alt="image" src="https://github.com/user-attachments/assets/8b066092-ee5c-4490-a003-38b7dce15a80" />

This dot plot shows approximately 10-year difference in life expectancy between the best and worst areas. The top performing areas are generally affluent, southern and rural/semi-rural while the lowest performing areas are generally northern-located post-industrial towns. These results highlight regional disparities in health outcomes consistent with public-health evidence. Areas with lowest life expectancy tend to be characterized by lower incomes, higher deprivation rates, poorer housing, and greater prevalence of chronic illnesses.

## Changes in Between‑Area Variation Over Time
A time-series line chart is created to show how the standard deviation of life expectancy changes over time (year by year). It is a clear way to assess whether areas are becoming more similar or more unequal over time.

<img width="3072" height="1152" alt="image" src="https://github.com/user-attachments/assets/a1b2d10d-1a97-43df-be00-a9ea16120602" />

The standard deviation values are relatively small, suggesting that life expectancy across England is tightly clustered. The overall national distribution remains uniform, and most areas fall within a narrow range. Between-area variation was declining from 2001 to 2012, however after 2012 it has started increasing gradually illustrating geographic inequalities have widened over time, which is the most apparent during and after the pandemic period.

Conclusions and key findings: 
- The life expectancy is generally consistent across England, with a small standard deviation and uniform distribution peaking around 80 years.
- However, inequalities persist, with a 10-year age gap between the highest and the lowest areas.
- Areas with longest life expectancy are clustered in the South of England and are affluent. Areas with shortest life expectancy are located mainly in the North of England, more deprived and post-industrial.
- Trends over time show no improvement in narrowing of the gap. Relative positions of areas remain stable across measured period (2001-2023).
- COVID-19 pandemic had a negative impact on the median life expectancy across all areas, simultaneously variation increased between areas suggesting uneven impacts across communities.
