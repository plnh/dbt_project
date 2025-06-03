
# dbt Project

## Overview
![Frame 1](https://github.com/user-attachments/assets/536acab5-86a9-42fe-b745-f93a95783dda)

A simple data pipeline that tracks my gold holdings in real-time. Built with just Python & SQL.

**Datasource:**
* datasources
  * Gold Price data: [Forex](https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR) , a free API swissquote database, covering daily gold price.
  * Other data: [GoogleSheet], store some sensitive data , such as portfolio, costs, etc.
* extract & load: BigQuery, Cloud Function
* Transformation: DBT.
* BI: Tableau (tobe finished).
**Performance Issues:**
- Check query execution plans
- Review model materializations
- Consider incremental strategies
- Optimize join patterns

## Features
![image](https://github.com/user-attachments/assets/0d809761-a93a-4421-b1d2-39085fb8f1b1)

