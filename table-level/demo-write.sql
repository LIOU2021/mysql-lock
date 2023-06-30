use wallet;

lock table products write;

INSERT INTO products (name) VALUES
('product_a'),
('product_b');

select * from products;
UNLOCK TABLES;