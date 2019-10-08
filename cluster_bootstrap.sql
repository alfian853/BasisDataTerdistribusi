SET SQL_LOG_BIN=0;
CREATE USER 'repl'@'%' IDENTIFIED BY 'password' REQUIRE SSL;
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;
CHANGE MASTER TO MASTER_USER='repl', MASTER_PASSWORD='password' FOR CHANNEL 'group_replication_recovery';
INSTALL PLUGIN group_replication SONAME 'group_replication.so';

SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;


# load database seed
load data local infile '/vagrant/data/categories.csv' into table categories fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventories.csv' into table inventories fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventories_document.csv' into table inventories_document fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventory_units.csv' into table inventory_units fields terminated by ',' lines terminated by '\n';

update categories set parent_id = null where id = 1
