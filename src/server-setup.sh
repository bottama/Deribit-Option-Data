# Set up Linux Ubuntu remote server

# Matteo Bottacini, matteo.bottacini@usi.ch
# last update: March 15, 2021

# create a connection with the remote server
ssh user@host 

# install SQLite, Python3, pip and cron
sudo apt-get update
sudo apt install sqlite3
sudo apt install python3
sudo apt-get install -y python3-pip
sudo apt-get install cron

# install python modules
pip3 install pandas
pip3 install tqdm
pip3 install sqlite3

# create directory: "src", "deliverables", "logs", "csv_files", "zip_files"
mkdir src
mkdir deliverables
mkdir logs
mkdir csv_files
mkdir zip_files

# create sub-directory: "btc_option_data" and "eth_option_data" in "zip_files"
cd zip_files
mkdir btc_option_data
mkdir eth_option_data
cd # back home

# add python script to "src" to download data
cd src
pico download-option-data.py # copy and paste the code

# add "move_files.sh" to "src" to move zipped renamed files
pico move_files.sh # copy and paste the code
