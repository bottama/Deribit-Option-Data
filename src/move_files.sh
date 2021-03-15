#!/bin/sh
mv btc_option_data.zip /zip_files/btc_option_data/$(date -d "-1 day" +"%Y%m%d").zip
mv eth_option_data.zip /zip_files/eth_option_data/$(date -d "-1 day" +"%Y%m%d").zip

