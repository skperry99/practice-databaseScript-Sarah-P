START TRANSACTION;

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Menus;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS MenuItems;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20)
);

-- Create Locations table
CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Create MenuItems table
CREATE TABLE MenuItems (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL
);

-- Create Menus table to link menu items to locations
CREATE TABLE Menus (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    location_id INT NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

-- Create Orders table, linking to both the customer and the specific restaurant location
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    location_id INT NOT NULL,
    order_date_time DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Create an OrderItems table to store the specific menu items in each order
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

-- Add Locations info
INSERT INTO Locations (location_name, address) VALUES
('Lord of the Fries', '123 Main St'),
('Grillenium Falcon', '456 Elm St'),
('Buns of Anarchy', '789 Oak Ave');

-- Add Customers info
INSERT INTO Customers (first_name, last_name, email, phone_number) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '555-1234'),
('Bob', 'Johnson', 'bob.johnson@example.com', '555-5678'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-8765');

-- Add MenuItems info
INSERT INTO MenuItems (item_name, description, price) VALUES
('Classic Burger', '1/4 lb beef patty with lettuce, tomato, and onion', 10.50),
('Spicy Chicken Sandwich', 'Grilled chicken with spicy sauce', 11.25),
('Fries', 'Crispy french fries', 4.00),
('Caesar Salad', 'Romaine lettuce with caesar dressing and croutons', 8.75),
('Milkshake', 'Vanilla, chocolate, or strawberry', 6.00);

-- Add Menus for each location
-- Lord of the Fries menu
INSERT INTO Menus (location_id, item_id) VALUES
(1, 1), -- Classic Burger
(1, 3), -- Fries
(1, 5); -- Milkshake
-- Grillenium Falcon menu
INSERT INTO Menus (location_id, item_id) VALUES
(2, 2), -- Spicy Chicken Sandwich
(2, 3), -- Fries
(2, 4); -- Caesar Salad
-- Buns of Anarchy menu
INSERT INTO Menus (location_id, item_id) VALUES
(3, 1), -- Classic Burger
(3, 3), -- Fries
(3, 5); -- Milkshake

-- Insert data into Orders table
INSERT INTO Orders (customer_id, location_id, order_date_time, total_amount) VALUES
(1, 1, '2025-01-15 12:30:customerscustomers00', 14.50), -- Alice at Lord of the Fries
(2, 2, '2025-01-20 18:00:00', 11.25), -- Bob at Grillenium Falcon
(1, 3, '2025-02-01 19:45:00', 10.50); -- Alice at Buns of Anarchy

-- Insert data into OrderItems table
INSERT INTO OrderItems (order_id, item_id, quantity, price) VALUES
(1, 1, 1, 10.50), -- Alice's order: 1 Classic Burger
(1, 3, 1, 4.00), -- Alice's order: 1 Fries
(2, 2, 1, 11.25), -- Bob's order: 1 Spicy Chicken Sandwich
(3, 1, 1, 10.50); -- Alice's second order: 1 Classic Burger

COMMIT;

