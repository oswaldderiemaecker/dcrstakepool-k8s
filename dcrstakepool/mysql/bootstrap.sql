CREATE USER IF NOT EXISTS 'stakepool'@'%%' IDENTIFIED BY '<%STAKEPOOL_MYSQL_DB_PASSWORD%>';
GRANT ALL PRIVILEGES ON *.* TO 'stakepool'@'%%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS stakepool;