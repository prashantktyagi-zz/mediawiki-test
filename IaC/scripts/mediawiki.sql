CREATE DATABASE mediawiki;
CREATE USER 'mediawiki'@'%' IDENTIFIED BY 'mediawiki_user_password';
GRANT CREATE, ALTER, INDEX, DROP, UPDATE, DELETE  ON `mediawiki`.* TO 'mediawiki'@'%';
FLUSH PRIVILEGES;