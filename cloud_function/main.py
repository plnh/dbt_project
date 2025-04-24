import requests
from datetime import datetime
from google.cloud import bigquery

def fetch_gold_prices(request):
    # Your API URL here
    url = "https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR"  
    response = requests.get(url)
    data = response.json()

    entry = data[0]
    timestamp = datetime.utcfromtimestamp(entry["ts"] / 1000)

    rows = []
    for price in entry["spreadProfilePrices"]:
        rows.append({
            "timestamp": timestamp.isoformat(),
            "spreadProfile": price["spreadProfile"],
            "bid": price["bid"],
            "ask": price["ask"],
            "bidSpread": price["bidSpread"],
            "askSpread": price["askSpread"]
        })

    client = bigquery.Client()
    table_id = "theta-turbine-457814-c5.gold_data.gold_spreads"
    errors = client.insert_rows_json(table_id, rows)

    if errors:
        print(f"BigQuery insert errors: {errors}")
        return "Failed", 500

    return "Success", 200

