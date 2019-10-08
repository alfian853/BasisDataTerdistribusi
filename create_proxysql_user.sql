CREATE USER 'bdtuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES on BdtDB.* to 'bdtuser'@'%';
FLUSH PRIVILEGES;

