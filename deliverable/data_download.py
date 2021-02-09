""" Download CC-Option Data from Deribit via public API """

"""
Matteo Bottacini -- matteo.bottacini@usi.ch
Last Update: February 9, 2021
"""

# import modules
import json
import requests
import pandas as pd
from tqdm import tqdm


# functions
def get_option_name_and_settlement(coin):
    """

    :param coin: crypto-currency coin name ('BTC', 'ETH')
    :return: 2 lists:
                        1.  list of traded options for the selected coin;
                        2.  list of settlement period for the selected coin.
    """

    # requests public API
    query = requests.get("https://test.deribit.com/api/v2/public/get_instruments?currency=" + coin + "&kind=option")
    query = json.loads(query.text)

    # get option name
    name = pd.json_normalize(query['result'])['instrument_name']
    name = list(name)

    # get option settlement period
    settlement_period = pd.json_normalize(query['result'])['settlement_period']
    settlement_period = list(settlement_period)

    return name, settlement_period



def get_option_data(coin):
    """

    :param coin: crypto-currency coin name ('BTC', 'ETH')
    :return: pandas data frame with all option data for a given coin
    """

    # get option name and settlement
    coin_name = get_option_name_and_settlement(coin)[0]
    settlement_period = get_option_name_and_settlement(coin)[1]

    # initialize data frame
    coin_df = []

    # initialize progress bar
    pbar = tqdm(total=len(coin_name))

    # loop to download data for each Option Name
    for i in range(len(coin_name)):

        # download option data -- requests and convert json to pandas
        r = requests.get('https://test.deribit.com/api/v2/public/get_order_book?instrument_name=' + coin_name[i])
        result = json.loads(r.text)
        df = pd.json_normalize(result['result'])

        # add settlement period
        df['settlement_period'] = settlement_period[i]

        # append data to data frame
        coin_df.append(df)

        # update progress bar
        pbar.update(1)

    # finalize data data frame
    coin_df = pd.concat(coin_df)

    # close the progress bar
    pbar.close()

    return coin_df


# download data -- BTC and ETH Options
btc_data = get_option_data('BTC')
eth_data = get_option_data('ETH')

# export data to .csv -- append to existing
btc_data.to_csv('../csv_files/btc_option_data.csv', index=0, mode='a', header=False)
eth_data.to_csv('../csv_files/eth_option_data.csv', index=0, mode='a', header=False)