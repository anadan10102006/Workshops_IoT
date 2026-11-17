CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL
);


INSERT INTO products (name, price) VALUES
('Apple', 3500.00),
('Orange', 7500.00),
('Watermelon', 12000.00),
('Cherry', 8500.00),
('Lemon', 1800.00);


