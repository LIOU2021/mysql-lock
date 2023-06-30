use wallet;

lock table products read;

select * from products;

-- Error Code: 1099. Table 'products' was locked with a READ lock and can't be updated
INSERT INTO products (name) VALUES
('product_a'),
('product_b');

-- Error Code: 1099. Table 'products' was locked with a READ lock and can't be updated
DELETE FROM products;

UNLOCK TABLES;