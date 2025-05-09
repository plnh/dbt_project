
# Networth Tracker Demo (Airflow + BigQuery + dbt)

This demo project automates the end-to-end workflow for retrieving, transforming, and analyzing personal financial data using **Apache Airflow**, **BigQuery**, **Google Sheets**, and **dbt**.

## Overview

The pipeline includes the following steps:

1. Fetch metal prices and stock data from external APIs.
2. Load data into Google BigQuery*.
3. Fetch personal asset allocations from Google Sheets.
4. Transform** data using dbt:
   - Normalize prices(e.g stock, metal asset).
   - Calculate real-time value of the portfolio.

All steps are orchestrated using Apache Airflow.


