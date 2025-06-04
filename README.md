# Building a Real-Time Data Pipeline to Track My Gold Holdings

## Overview

A simple data pipeline that tracks my gold holdings in real-time. Built with just Python & SQL.

As someone who holds physical gold as part of my investment portfolio, I found myself constantly checking spot prices and manually calculating the current value of my holdings. So I decided to build a real-time data pipeline that would track my gold's value automatically and provide useful insights.

## The Challenge

Gold prices fluctuate constantly during market hours, and keeping track of my holdings' value manually is both time-consuming and prone to errors. I needed a solution that would:

* Fetch real-time gold prices from reliable sources
* Calculate the current value of my specific holdings (accounting for different purities and weights)
* Store historical data for trend analysis
* Provide a dashboard for easy monitoring

### Other Requirements

* No cost or low cost
* Keep manual task as minimal

## Architecture Overview

![Frame 1](https://github.com/user-attachments/assets/536acab5-86a9-42fe-b745-f93a95783dda)

### Components

* **Data Sources**
  * **Gold Price Data**: [Forex API](https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR) - a free API from Swissquote database, covering daily gold price
  * **Other Data**: Google Sheets - store sensitive data such as portfolio, costs, etc.
* **Extract**: Python script running in Cloud Function on schedule to fetch gold price
* **Load**: All data stored in BigQuery
* **Transformation**: dbt
* **BI**: Tableau (to be finished)

## Implementation Steps

### Step 1: Choosing Data Sources

I chose the [Forex API](https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR) as it is free and covers daily gold price data.

I track my holdings using Google Sheets, which has the benefit of being easily loaded into BigQuery.

### Step 2: Modeling My Holdings

Gold comes in different forms and purity such as bullion, coins, etc. Hence it's essential to properly model my holdings.

I created a Google Sheet with the following structure:

![Holdings Structure](https://github.com/user-attachments/assets/be5b645b-a627-4879-875e-b202d397f089)

**Note**: Purity is not included as I want to keep manual data entry minimal. The purity will be calculated based on type/description in the transform step.

### Step 3: Extract & Load to BigQuery

* See [Cloud Function] for API Integration
* See [How to Connect Sheets to BigQuery](https://support.google.com/docs/answer/9702507?hl=en)

### Step 4: Transform in dbt

* configuge models:
![dbt Transformation](https://github.com/user-attachments/assets/0d809761-a93a-4421-b1d2-39085fb8f1b1)
* Staging Layer:
 * Raw gold price data from the Forex API
 * Portfolio holdings from Google Sheets
 * Basic cleaning and standardization
 
* Intermediate Layer probably includes:
 * Purity calculations based on gold type/description
 * Current value calculations (weight × purity × price)
 * Data rules (ex. weight > 0)
  
* Marts Layer focuses on:
  *Final models for Tableau dashboards

## Next Steps
* Visualize the trend on Tableau (not yet done)


