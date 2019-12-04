# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

sudo apt install libaio1 libmecab2

sudo mkdir install

sudo tar -xvf /vagrant/mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar -C install/
sudo cd install
sudo dpkg -i mysql-common_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-client_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-client_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-server_7.6.6-1ubuntu18.04_amd64.deb


sudo ufw allow from 192.168.16.73


CREATE USER 'bdtuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'bdtuser'@'%' WITH GRANT OPTION;

