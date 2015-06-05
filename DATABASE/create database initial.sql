create database mysite;

CREATE USER 'webapp'@'localhost' IDENTIFIED BY 'w3b@pp!';

GRANT ALL PRIVILEGES ON mysite.* TO 'webapp'@'localhost' WITH GRANT OPTION;



CREATE USER 'webapp'@'%' IDENTIFIED BY 'w3b@pp!';

GRANT ALL PRIVILEGES ON mysite.* TO 'webapp'@'%' WITH GRANT OPTION;