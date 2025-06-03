import requests
import json
from datetime import datetime
from google.cloud import bigquery

def fetch_gold_prices(request):
    try:
        # Your API URL here
        url = "https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument/XAU/EUR"  
        response = requests.get(url)
        data = response.json()
        
        # DEBUG: Print the actual response structure
        print(f"API Response Status: {response.status_code}")
        print(f"API Response Type: {type(data)}")
        print(f"API Response Content: {json.dumps(data, indent=2)}")
        
        # Check if data is a list and has elements
        if isinstance(data, list) and len(data) > 0:
            entry = data[0]
            print(f"First entry: {json.dumps(entry, indent=2)}")
            print(f"Available keys in entry: {list(entry.keys())}")
        else:
            print(f"Data is not a list or is empty. Type: {type(data)}")
            if isinstance(data, dict):
                print(f"Available keys: {list(data.keys())}")
            return f"Unexpected data format: {type(data)}", 400
        
        # Use current time as load timestamp
        load_timestamp = datetime.utcnow()
        print(f"Load timestamp: {load_timestamp}")
        
        
        # Check for spreadProfilePrices
        if "spreadProfilePrices" in entry:
            print(f"Found spreadProfilePrices: {entry['spreadProfilePrices']}")
            rows = []
            for price in entry["spreadProfilePrices"]:
                print(f"Processing price entry: {price}")
                rows.append({
                    "timestamp": load_timestamp.isoformat(),
                    "spreadProfile": price["spreadProfile"],
                    "bid": price["bid"],
                    "ask": price["ask"],
                    "bidSpread": price["bidSpread"],
                    "askSpread": price["askSpread"]
                })
        else:
            print("No spreadProfilePrices found")
            # Try to create a simple row with basic bid/ask if available
            rows = []
            bid = entry.get('bid') or entry.get('bidPrice')
            ask = entry.get('ask') or entry.get('askPrice')
            
            if bid and ask:
                print(f"Creating simple row with bid: {bid}, ask: {ask}")
                rows.append({
                    "timestamp": load_timestamp.isoformat(),
                    "spreadProfile": "default",
                    "bid": bid,
                    "ask": ask,
                    "bidSpread": 0,
                    "askSpread": 0
                })
            else:
                print("No bid/ask prices found either")
                return f"No price data found in response", 400
        
        print(f"Prepared {len(rows)} rows for BigQuery: {rows}")
        
        # Insert into BigQuery
        client = bigquery.Client()
        table_id = "theta-turbine-457814-c5.Live_price.gold_price"
        
        print(f"Attempting to insert into table: {table_id}")
        errors = client.insert_rows_json(table_id, rows)
        
        if errors:
            print(f"BigQuery insert errors: {errors}")
            return f"BigQuery insert failed: {errors}", 500
        
        print(f"Successfully inserted {len(rows)} rows")
        return f"Success: Inserted {len(rows)} rows", 200
        
    except Exception as e:
        print(f"Error occurred: {str(e)}")
        import traceback
        print(f"Full traceback: {traceback.format_exc()}")
        return f"Error: {str(e)}", 500
