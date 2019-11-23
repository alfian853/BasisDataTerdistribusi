# Copy APT sources list
sudo cp /vagrant/sources/sources.list /etc/apt/

sudo apt-get update

sudo apt-get install redis

sudo cp /vagrant/provision/slave2_redis.conf /etc/redis/redis.conf
sudo cp /vagrant/provision/slave2_sentinel.conf /etc/redis/sentinel.conf

sudo redis-server /etc/redis/redis.conf
sudo redis-server /etc/redis/sentinel.conf --sentinel


