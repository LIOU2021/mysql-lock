create database wallet;
use wallet;
CREATE TABLE accounts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE,
  balance DECIMAL(10, 2)
);

CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) UNIQUE
);

INSERT INTO accounts (username, balance) VALUES
('A', 1000.00),
('B', 500.00),
('C', 200.00),
('D', 300.00);