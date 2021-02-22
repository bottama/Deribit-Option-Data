# SQLite DataBase Management

This is a setup script to view the basics for the SQLite DataBase management. It does the following:
* Access SQLite in the Ubuntu remote server;
* Access the SQLite DataBase;
* Manages SQLite tables;

# Access
SSH into your server and enter SQLite:
```bash
# default SQLite browser 
sqlite3

# suggested SQLite browser
sqlite3 -column -header
```

Open the `option-data.db` DataBase:
```bash
.open option-data.db
```

# DataBase Management
Show the tables inside the DataBase:
```bash
.tables
```

Get the structure of the tables `btc_option_data` and `eth_option_data` inside the DataBase:
```bash
# BTC option data structure
.schema btc_option_data

# ETH option_data
.schema eth_option_data
```

Show tables via SQL commands:
```bash
# show all elements
SELECT * FROM btc_option_data;
SELECT * FROM eth_option_data;

# show 5 entries
SELECT * FROM btc_option_data LIMIT 5;
SELECT * FROM eth_option_data LIMIT 5;

# get instrument name, market price and timestamp
SELECT instrument_name, mark_price, timestamp FROM btc_option_data;
SELECT instrument_name, mark_price, timestamp FROM eth_option_data;

# get all the available data for a specific instrument
SELECT * FROM btc_option_data WHERE instrument_name = 'BTC-24SEP21-7000-P';
```

# Quit 
Exit SQLite
```bash
.quit
```

# Supported version
This setup script has been tested against SQLite version 3.31.1
