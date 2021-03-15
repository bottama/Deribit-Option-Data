# Bash setup script for Ubuntu servers

This is a setup script to automate the setup and provisioning of Ubuntu servers. It does the following:
* Adds SQLite, Python3, pip and cron to the server;
* Installs Python modules;
* Adds a Python script;
* Setups a cron job to run a python script;
* Adds `.log` file for traceback.

# Installation
SSH into your server and install SQLite, Python3, pip and cron if not installed:
```bash
sudo apt-get update
sudo apt install sqlite3
sudo apt install python3
sudo apt-get install -y python3-pip
sudo apt-get install cron
```

Install Python modules:
```bash
pip3 install pandas
pip3 install tqdm
pip3 install sqlite3
```

Create directories: `/src`, `/deliverables`, `/logs`, `csv_files`, `/zip_files`
```bash
mkdir src
mkdir deliverables
mkdir logs
mkdir csv_files
mkdir zip_files
```

Create sub-directories: `/zip_files/btc_option_data` and `/zip_files/eth_option_data`
```bash
cd zip_files
mkdir btc_option_data
mkdir eth_option_data
cd # back home
```

Add `/src/option-data-download.py` Python script to Ubuntu remote server:
```bash
cd src
pico option-data-download.py  #copy and paste the source code
```

Add `/src/move_files.sh` shell script to Ubuntu remote server:
```bash
cd src
pico move_files.sh  #copy and paste the source code
```

# Setup cron jobs:
Create a cronjob that run the python script `/src/option-data-download.py` 5 minutes in the crontab page and add `.log` file for traceback in the `/logs` directory.
`crontab -e` in your server and then:

```bash
# download option data every 5 minutes and store log files
*/5 * * * * python3 "src/option-data-download.py" >> logs/option-data-5min-download-log.log
```

At the end of each day convert the `sqlite3` tables inside `/deliverables/option-data-5min.db` into `.csv` and move them in `/csv_files`.
Note that: the python script takes up to 2 minutes in my server, the last time is run at 23:55:00, then the code needs to be run between 23:58 and 23:59.

```bash
# at the end of each day create a .csv file with daily values:
58 23 * * * sqlite3 -header -csv /home/bottama/deliverables/option-data-5min.db "select * from btc_option_data;" > csv_files/btc_option_data.csv
58 23 * * * sqlite3 -header -csv /home/bottama/deliverables/option-data-5min.db "select * from eth_option_data;" > csv_files/eth_option_data.csv
```

Initialize the database `/deliverables/option-data.db` before midnight so that it is ready for the next day observations:

```bash
# initialize the data base at 23:59
59 23 * * * rm /home/bottama/deliverables/option-data-5min.db
```

Zip the `/csv_files/btc_option_data.csv` and the `/csv_files/eth_option_data.csv` with compression level `9` (default is 6) at the beginning of each day.

```bash
# zip the csv file at 00.05
5 0 * * * zip -9 -r btc_option_data.zip ./csv_files/btc_option_data.csv
5 0 * * * zip -9 -r eth_option_data.zip ./csv_files/eth_option_data.csv
```

Rename the zipped files and move Bitcoin data into `/zip_files/btc_option_data` and Ethereum data into `/zip_files/eth_option_data` using the `SHELL` script `/src/move_files.sh`. The files are renamed with the date of the day the data was downloaded.

```bash
# move the zipped files to the zip_files folder and rename it with timestamp (YYYYMMDD) at 00.15
15 00 * * * sh /home/bottama/src/move_files.sh
```

Remove the `.csv` files at the beginning of each day.
```bash
# remove the csv files at 00.30
30 0 * * * rm /home/bottama/csv_files/btc_option_data.csv
30 0 * * * rm /home/bottama/csv_files/eth_option_data.csv
```

Finally quit the `crontab` page by digit `^X` and save the file.
The full crontab code can be found at `/src/crontab-setup.sh`.


# Access log
Access the `.log` file `option-data-download-log.log`.

```bash
cat option-data-download-log.log

# other commands:
[q]  #to quit.
[/]  #“text” and [enter] to search a pattern.
[G]  #to go to the end of the file.
[gg] #to go to begining of the file.
```


# Supported versions
This setup script has been tested against Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-56-generic x86_64)
