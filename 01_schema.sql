-- ==========================
-- Customers
-- ==========================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255) NOT NULL
);

-- ==========================
-- Restaurants
-- ==========================
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    cuisine VARCHAR(30) NOT NULL
);

-- ==========================
-- Riders
-- ==========================
CREATE TABLE riders (
    rider_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(15),
    driving_licence_id_no VARCHAR(25) NOT NULL UNIQUE
);

-- ==========================
-- Orders
-- ==========================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,

    restaurant_id INT NOT NULL,
    customer_id INT NOT NULL,
    rider_id INT NOT NULL,

    -- Later you can convert this to ENUM or a status lookup table
    status VARCHAR(15) NOT NULL,

    -- Stored in paise (e.g. ₹149.50 => 14950)
    total_amount INT NOT NULL,

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
        ON DELETE NO ACTION,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE NO ACTION,

    FOREIGN KEY (rider_id)
        REFERENCES riders(rider_id)
        ON DELETE NO ACTION
);

-- ==========================
-- Order Items
-- ==========================
CREATE TABLE order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,

    item_name VARCHAR(100) NOT NULL,

    quantity INT NOT NULL,

    -- Price of this line item in paise
    amount INT NOT NULL,

    PRIMARY KEY (order_id, item_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);