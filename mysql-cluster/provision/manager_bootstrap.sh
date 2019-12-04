# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

cp /vagrant/mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb .
sudo dpkg -i mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb

sudo ufw allow from 192.168.16.74
sudo ufw allow from 192.168.16.75
sudo ufw allow from 192.168.16.76


sudo mkdir /var/lib/mysql-cluster

sudo cp /vagrant/config/ndb-manager/config.ini /var/lib/mysql-cluster/config.ini

sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini

sudo pkill -f ndb_mgmd

sudo cp /vagrant/config/ndb-manager/ndb_mgmd.service /etc/systemd/system/ndb_mgmd.service

sudo systemctl daemon-reload
sudo systemctl enable ndb_mgmd
sudo systemctl start ndb_mgmd


sudo wget https://github.com/sysown/proxysql/releases/download/v1.4.4/proxysql_1.4.4-ubuntu16_amd64.deb
sudo dpkg -i proxysql_*
rm proxysql_*
sudo apt-get update
sudo apt-get install mysql-client
sudo systemctl start proxysql

sudo mysql -u admin -padmin -h 127.0.0.1 -P 6032 < /vagrant/config/ndb-manager/proxysql.sql


