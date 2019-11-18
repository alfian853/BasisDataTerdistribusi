# BasisDataTerdistribusi

## Arsitektur
![alt text](https://github.com/alfian853/BasisDataTerdistribusi/blob/master/screenshots/arsitektur.png)

## Spesifikasi
Masing-masing Server memiliki spesifikasi sebagai berikut:

Operating System : Ubuntu(64-bit)

Base Memory : 1024 MB

## Instalasi

1. jalankan vagrant dengan command
> vagrant up

2. cek isi databasenya dengan
> vagrant ssh db4

> sudo mysql -u bdtuser -ppassword

mysql> use BdtDB;

mysql> select * from inventories;

maka akan muncul output seperti ini

![alt_text](https://github.com/alfian853/BasisDataTerdistribusi/blob/master/screenshots/cek_db.png)

ulangilah proses pengecekan tersebut ke db5 dan db6

3. selanjutnya clone repository github phalcon-clean-code
> git clone https://github.com/alfian853/phalcon-clean-code.git

notes :
repository tersebut diclone di folder vagrant untuk mempermudah konfigurasi karna bisa diedit dengan high level text editor

3. beri akses read/write untuk mencegah volt write error 
> sudo chmod 777 -R phalcon-clean-code

4. masuk ke folder phalcon-clean-code/src
> cd phalcon-clean-code/src

5. jalankan composer install
> composer install

6. ssh ke virtual machine "proxy" dengan command
> vagrant ssh proxy

7. copylah file konfigurasi apache ke folder sites-available apache dengan command 
> cp /vagrant/phalcon-clean-code.conf /etc/apache2/sites-avaliable/phalcon-clean-code.conf

notes : sesuaikan config DocumentRoot dengan path project phalcon-clean-code

![alt_text](https://github.com/alfian853/BasisDataTerdistribusi/blob/master/screenshots/apacheconf.png)

8. aktifkan konfigurasi tersebut dengan
> sudo a2ensite phalcon-clean-code
> sudo service apache2 reload

9. buka file .env di phalcon-clean-code/src/apps/.env

10. isilah config tersebut dengan value berikut:

![alt_text](https://github.com/alfian853/BasisDataTerdistribusi/blob/master/screenshots/phalcon-env.png)

11. coba akses url ini di browser : 192.168.16.73:8008
![alt_text](https://github.com/alfian853/BasisDataTerdistribusi/blob/master/screenshots/hasil.png)


