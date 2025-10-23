START TRANSACTION;

-- Drop tables if they already exist to ensure a clean slate
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create Orders table with foreign keys
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into Customers table
INSERT INTO Customers (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com');

-- Insert data into Products table
INSERT INTO Products (product_name, price) VALUES
('Laptop', 1200.00),
('Mouse', 25.00),
('Keyboard', 75.00);

-- Insert data into Orders table
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-15', 1225.00),
(2, '2025-01-20', 75.00),
(1, '2025-02-01', 50.00);

COMMIT;