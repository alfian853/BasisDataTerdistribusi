# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

sudo apt install libclass-methodmaker-perl

sudo cp /vagrant/mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb .

sudo dpkg -i mysql-cluster-community-data-node_7.6.6-1ubuntu18.04_amd64.deb

sudo ufw allow from 192.168.16.73
sudo ufw allow from 192.168.16.77
sudo ufw allow from 192.168.16.78
sudo ufw allow from 192.168.16.79

sudo cp /vagrant/config/datanode/my.cnf /etc/my.cnf
sudo cp /vagrant/config/datanode/ndbdb.service /etc/systemd/system/ndbd.service

sudo mkdir -p /usr/local/mysql/datadir

sudo ndbd

sudo pkill -f ndbd
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
