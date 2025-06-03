
## Overview
A simple data pipeline that tracks my gold holdings in real-time. Built with just Python & SQL.

# Building a Real-Time Data Pipeline to Track My Gold Holdings
As someone who holds physical gold as part of my investment portfolio, I found myself constantly checking spot prices and manually calculating the current value of my holdings. So I decided to build a real-time data pipeline that would track my gold's value automatically and provide useful insights.
**The Challenge**
Gold prices fluctuate constantly during market hours, and keeping track of my holdings' value manually is both time-consuming and prone to errors. I needed a solution that would:
* Fetch real-time gold prices from reliable sources
* Calculate the current value of my specific holdings (accounting for different purities and weights)
* Store historical data for trend analysis
* Provide a dashboard for easy monitoring

Other requirement:
* No cost or low cost
* Keep manual task as minimal
  
**Architecture Overview**
  
![Frame 1](https://github.com/user-attachments/assets/536acab5-86a9-42fe-b745-f93a95783dda)

* datasources
  * Gold Price data: [Forex](https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR) , a free API swissquote database, covering daily gold price.
  * Other data: [GoogleSheet], store some sensitive data , such as portfolio, costs, etc.
* extract: python script to run in Cloud Function per schedule to fetch gold price
* load: all is stored in BigQuery
* Transformation: DBT
* BI: Tableau (tobe finished).

## Step 1: Choosing Data Sources
I choose [Forex API](https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR) as it is free and covering daily gold price.

I track my holdings using GoogleSheet, the benefits is is easliy to load to BigQuery

Step 2: Modeling my holdings

Gold comes in different forms and purity such as bullion, coin etc. Hence it's essiential to properly modeling my holdings. 

I created a Google Sheet with the following structure:
![image](https://github.com/user-attachments/assets/be5b645b-a627-4879-875e-b202d397f089)

Purity is not included as I want to keep manual data entry as minimal. The purity will be calculated based of type/despcrition in transform step

Step 3: Extra & Load to BigQuery

See [Cloud Function] for API Integration 
See [How to Connect Sheets to BigQuery ](https://support.google.com/docs/answer/9702507?hl=en)

Step 5: Transform in dbt

![image](https://github.com/user-attachments/assets/0d809761-a93a-4421-b1d2-39085fb8f1b1)

*Topics that I covered:
  *Connected my github. BigQuery API to dbt
  *Created delopment enviromnent 
  *Used Source to simplify the code and reference them in my models
  *Created multiple Macros to avoid repetition and reuse code more easily
  *Used Common table expressions (CTE)
  *Included Custom Generic Tests 
*Topics to be continued:
  *Setting up hooks (pre-hook, post-hook) and an Audit table to log all action running in deployments
  *Creating Snapshots to track changes in variables over time
  *Creating a dev and production environment to be able to separate my code if I work in a team
  *Using tags on my models in order to use them when I schedule JOBS in dbt cloud
  *Limited my data to reduce the time of tests and runs

Next Step: 

Visualize the trend on tableau
