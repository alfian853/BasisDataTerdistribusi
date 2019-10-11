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



create database BdtDB;
use BdtDB;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";


drop table if exists categories;
CREATE TABLE categories (
    id int(11) NOT NULL,
    name varchar(255),
    parent_id int(11),
    primary key(id) 
);

drop table if exists inventories;
CREATE TABLE inventories (
    id int(11) auto_increment NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    description text,
    image varchar(255),
    name varchar(255),
    price int(11) NOT NULL,
    quantity int(11) NOT NULL,
    `type` varchar(255),
    category_id int(11) NOT NULL
, PRIMARY KEY(id)
) ;

drop table if exists inventories_document;
CREATE TABLE inventories_document (
    inventory_id int(11) NOT NULL,
    file_name varchar(255),
    inventory_last_update timestamp NOT NULL,
    foreign key(inventory_id) references inventories(id) on delete cascade
) ;

drop table if exists warehouses;
CREATE TABLE warehouses (
    id int(11) NOT NULL,
    address varchar(255),
    name varchar(255),
    primary key(id)
) ;

drop table if exists inventory_units;
CREATE TABLE inventory_units (
    id varchar(255) NOT NULL,
    rack varchar(255),
    inventory_id int(11) NOT NULL,
    warehouse_id int(11) NOT NULL,
    foreign key(inventory_id) references inventories(id) on delete cascade,
    foreign key(warehouse_id) references warehouses(id) on delete cascade
) ;

load data local infile '/vagrant/data/categories.csv' into table categories fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventories.csv' into table inventories fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventories_document.csv' into table inventories_document fields terminated by ',' lines terminated by '\n';
load data local infile '/vagrant/data/inventory_units.csv' into table inventory_units fields terminated by ',' lines terminated by '\n';

update categories set parent_id = null where id = 1



