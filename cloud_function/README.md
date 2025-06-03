# Forex Data Loader - Cloud Function

A Google Cloud Function that automatically fetches gold price data (XAU/EUR) from the Swissquote API and loads it into BigQuery for tracking.
I wrote this with the help of Claude.ai

## Overview

Automatic collecting live forex data and storing it in BigQuery. 
The Cloud Function fetches real-time gold prices (daily) and inserts them into a structured table with timestamps for historical analysis.

## Architecture

```
Swissquote API → Cloud Function → BigQuery Table
     ↓              ↓               ↓
 Live Data    Data Processing   Data Storage
```

## Data Schema

**Table**: `theta-turbine-457814-c5.Live_price.gold_price`

| Column | Type | Description |
|--------|------|-------------|
| `timestamp` | TIMESTAMP | When the data was loaded (UTC) |
| `spreadProfile` | STRING | Spread profile identifier |
| `bid` | FLOAT | Bid price for XAU/EUR |
| `ask` | FLOAT | Ask price for XAU/EUR |
| `bidSpread` | FLOAT | Bid spread value |
| `askSpread` | FLOAT | Ask spread value |

## Deployment

### Prerequisites

1. **Google Cloud Project**:
2. **APIs Enabled**:
   - Cloud Functions API
   - BigQuery API
   - Cloud Build API
3. **BigQuery Dataset**: `Live_price`
4. **BigQuery Table**: `gold_price`

### Setup Instructions

1. **Clone/Create the project files**:
   ```bash
   mkdir forex-cloud-function
   cd forex-cloud-function
   ```

2. **Create main.py** 

3. **Create requirements.txt**:

4. **Deploy the function**:
   ```bash
   gcloud functions deploy fetch-gold-prices \
       --runtime python311 \
       --trigger-http \
       --allow-unauthenticated \
       --entry-point fetch_gold_prices \
       --memory 256MB \
       --timeout 60s \
       --region us-central1
   ```

### Create BigQuery Resources
(if not exists)

## Scheduling

### Set up daily execution:

```bash
gcloud scheduler jobs create http forex-data-daily-job \
    --location us-central1 \
    --schedule "0 9 * * *" \
    --uri "https://us-central1-theta-turbine-457814-c5.cloudfunctions.net/fetch-gold-prices" \
    --http-method GET \
    --time-zone "UTC" \
    --description "Load forex data daily at 9 AM UTC"
```

## Testing

### Manual Test:
```bash
curl "https://us-central1-theta-turbine-457814-c5.cloudfunctions.net/fetch-gold-prices"
```

### Check Logs:
```bash
gcloud functions logs read fetch-gold-prices --limit 20
```


## Monitoring

### Cloud Console Locations:

- **Cloud Functions**: Console → Cloud Functions → fetch-gold-prices
- **Cloud Scheduler**: Console → Cloud Scheduler → forex-data-daily-job  
- **BigQuery**: Console → BigQuery → Live_price → gold_price
- **Logs**: Console → Logging → Logs Explorer
