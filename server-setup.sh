# Set up Linux Ubuntu remote server

# Matteo Bottacini, matteo.bottacini@usi.ch
# last update: February 21, 2021

# create a connection with the remote server
ssh ---------------

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

# set up cronjob
crontab -e

# cronjob option-data-download
# downoad data at midnight
00 00 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when Tokyo opens
0 1 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when shangai opens
30 2 * * * python3 "option-data-download.py" >> option-data-download-log.log

# Shnagai Closes
0 8 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when Paris open
0 9 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when US open
30 15 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when Tokyo closes
0 7 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when Paris and london closes
30 17 * * * python3 "option-data-download.py" >> option-data-download-log.log

# download data when US closes
0 22 * * * python3 "option-data-download.py" >> option-data-download-log.log
