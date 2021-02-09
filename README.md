# Downloading real time Cryptocurrency Option Data from Deribit
#### Last Update February 9, 2021 ####
#### Matteo Bottacini, [matteo.bottacini@usi.ch](mailto:matteo.bottacini@usi.ch) ####

Folder structure:
~~~~
Deribit_OptionData/
    csv_files/
        btc_option_data.csv
        eth_option_data.csv
    deliverable/
        data_download.py
    README.md
~~~~

## Deliverable ##
Data are downloaded through Deribit.com via a public API.
In the script `data_download.py` are downloaded available data of Bitcoin and Ethereum Options.
Data collected are then appended to existing `.csv` files in `../csv_files/..`.

## csv_files ##
Bitcoin Option data are stored in `btc_option_data.csv`.
Ethereum Option data are stored in `eth_option_data.csv`.

## References ##

Deribit API: https://docs.deribit.com/?python#deribit-api-v2-0-1
