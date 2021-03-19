# Downloading real time Cryptocurrency Option Data from Deribit
#### Last Update February 21, 2021 ####
#### Matteo Bottacini, [matteo.bottacini@usi.ch](mailto:matteo.bottacini@usi.ch) ####


# Project description

This project is to download cryptocurrency option data available on [Deribit](https://www.deribit.com) via a public API.
The project is run on an Ubuntu remote server with the implementation of `Python 3`, `Shell` and `SQLite`.

The scripts do the following:
* Connects with [Deribit](https://www.deribit.com) via a public API and `json` queries;
* Setups Ubuntu remote server;
* Stores data in `.csv` files;
* Adds cron-jobs to run Python scripts;
* Stores data in a `SQLite` database;
* Adds `.log` file for traceback.

1. [test](#test)
## test


Folder structure:
~~~~
Deribit-Option-Data/
    csv_files/
        btc_option_data.csv
        eth_option_data.csv
    deliverable/
        option-data-download.py
        server-setup.sh
    README.md
    SQLite-database-management.md
    ubuntu-server-setup.md
~~~~

## Deliverable ##
The script `option-data-download.py`:
* downloads available data of Bitcoin and Ethereum Options;
* appends new data to existing `.csv` files in `../csv_files/..`;
* connects to the `SQLite` databse `option-data.db` on the Ubuntu remote server;
* creates/updates `btc_option_data` and `eth_option_data` tables in the database.

The script `server-setup.sh`:
* Bash setup script for Ubuntu servers;
* speicific documentation at `../ubuntu-server-setup.md`.

## csv_files ##
Data stroed in this directory are for local purposes.
These files are not in the Ubuntu server.

The `.csv` files are:
* Bitcoin Option data are stored in `btc_option_data.csv`;
* Ethereum Option data are stored in `eth_option_data.csv`.

## References ##

Deribit API: https://docs.deribit.com/?python#deribit-api-v2-0-1
