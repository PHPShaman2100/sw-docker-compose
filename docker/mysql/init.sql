CREATE DATABASE IF NOT EXISTS gateway;
CREATE USER IF NOT EXISTS 'gateway_user'@'%' IDENTIFIED BY 'gateway_user_password';
GRANT ALL PRIVILEGES ON gateway.* TO 'gateway_user'@'%';