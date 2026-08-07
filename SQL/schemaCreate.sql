DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;


##Added constraints PRIMARY KEY, NOT NULL, DEFAULT, CHECK, UNIQUE
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    AGE INT ,
    EMAIL VARCHAR(50) UNIQUE,
    city          VARCHAR(50),
    signup_date   DATE DEFAULT (CURRENT_DATE()),
   CONSTRAINT chk_PersonAge CHECK (Age >= 18)
);


INSERT INTO customers (customer_id, customer_name,age,email, city, signup_date) VALUES
(1, 'Aarav Mehta', 31,'abc@123.com','Mumbai', '2024-01-15'),
(2, 'Diya Sharma', 43,'a@123.com','Delhi', '2024-02-10'),
(3, 'Kabir Singh', 19,'ac@123.com','Bangalore', '2024-02-20'),
(4, 'Ananya Iyer', 28,'abc.123','Chennai', '2024-03-05'),
(5, 'Vihaan Reddy', 34,'abc@123.co.uk','Hyderabad', '2024-03-18'),
(6, 'Ishita Nair', 51,'abc@xyz.com','Kochi', '2024-04-01'),
(7, 'Reyansh Gupta', 23,'abc@.com','Delhi', '2024-04-22'),
(8, 'Myra Kapoor', 20,'abc@123','Mumbai', '2024-05-10'),
(9, 'Arjun Rao', 36,'abc@bell.com','Bangalore', '2024-05-25'),
(10, 'Saanvi Joshi',27, 'abc@123.cof','Pune', '2024-06-12');

INSERT INTO customers (customer_id, customer_name,age,email, city) VALUES
(11, 'Aarav Mehta', 31,'abcd@123.com','Mumbai');

CREATE TABLE products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    unit_price    DECIMAL(10,2)
);

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Wireless Mouse', 'Electronics', 599.00),
(102, 'Mechanical Keyboard', 'Electronics', 2499.00),
(103, 'USB-C Cable', 'Electronics', 199.00),
(104, 'Laptop Stand', 'Accessories', 899.00),
(105, 'Notebook Set', 'Stationery', 249.00),
(106, 'Desk Lamp', 'Home', 799.00),
(107, 'Water Bottle', 'Lifestyle', 349.00),
(108, 'Backpack', 'Lifestyle', 1599.00),
(109, 'Bluetooth Speaker', 'Electronics', 1299.00),
(110, 'Office Chair', 'Home', 4999.00);

-- ============================================================
-- TABLE 3: orders (order header)
-- ============================================================
CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    order_date    DATE DEFAULT (CURRENT_DATE()),
    order_status  VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, order_status) VALUES
(1001, 1, '2024-06-01', 'Delivered'),
(1002, 2, '2024-06-02', 'Delivered'),
(1003, 1, '2024-06-05', 'Delivered'),
(1004, 3, '2024-06-07', 'Cancelled'),
(1005, 4, '2024-06-10', 'Delivered'),
(1006, 5, '2024-06-12', 'Delivered'),
(1007, 2, '2024-06-15', 'Delivered'),
(1008, 6, '2024-06-18', 'Pending'),
(1009, 7, '2024-06-20', 'Delivered'),
(1010, 3, '2024-06-22', 'Delivered'),
(1011, 8, '2024-06-25', 'Delivered'),
(1012, 1, '2024-07-01', 'Delivered'),
(1013, 9, '2024-07-03', 'Delivered'),
(1014, 4, '2024-07-05', 'Cancelled'),
(1015, 10, '2024-07-08', 'Delivered'),
(1016, 5, '2024-07-10', 'Delivered'),
(1017, 2, '2024-07-12', 'Pending'),
(1018, 6, '2024-07-15', 'Delivered'),
(1019, 7, '2024-07-18', 'Delivered'),
(1020, 3, '2024-07-20', 'Delivered');

-- ============================================================
-- TABLE 4: order_items (line items, order-item grain)
-- ============================================================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id      INT,
    product_id    INT,
    quantity      INT,
    unit_price    DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 2, 599.00),
(2, 1001, 103, 1, 199.00),
(3, 1002, 102, 1, 2499.00),
(4, 1003, 105, 3, 249.00),
(5, 1003, 107, 2, 349.00),
(6, 1004, 108, 1, 1599.00),
(7, 1005, 104, 1, 899.00),
(8, 1005, 106, 1, 799.00),
(9, 1006, 109, 1, 1299.00),
(10, 1007, 101, 1, 599.00),
(11, 1007, 110, 1, 4999.00),
(12, 1008, 105, 5, 249.00),
(13, 1009, 103, 4, 199.00),
(14, 1010, 107, 1, 349.00),
(15, 1010, 108, 1, 1599.00),
(16, 1011, 102, 1, 2499.00),
(17, 1011, 101, 1, 599.00),
(18, 1012, 109, 2, 1299.00),
(19, 1013, 106, 1, 799.00),
(20, 1014, 104, 1, 899.00),
(21, 1015, 110, 1, 4999.00),
(22, 1016, 105, 2, 249.00),
(23, 1017, 107, 3, 349.00),
(24, 1018, 101, 1, 599.00),
(25, 1018, 103, 2, 199.00),
(26, 1019, 108, 1, 1599.00),
(27, 1020, 109, 1, 1299.00),
(28, 1020, 106, 1, 799.00);

ALTER TABLE order_items ADD COLUMN LastUpdatedDate DATE;
-- ============================================================
-- TABLE 5: employees (standalone table, ideal for window functions)
-- ============================================================
CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department    VARCHAR(50),
    hire_date     DATE,
    salary        DECIMAL(10,2)
);

INSERT INTO employees (employee_id, employee_name, department, hire_date, salary) VALUES
(1, 'Rohan Verma', 'Engineering', '2021-03-01', 85000.00),
(2, 'Priya Nambiar', 'Engineering', '2021-07-15', 92000.00),
(3, 'Karan Malhotra', 'Engineering', '2022-01-10', 78000.00),
(4, 'Sneha Pillai', 'Sales', '2020-11-20', 65000.00),
(5, 'Aditya Kumar', 'Sales', '2021-05-05', 71000.00),
(6, 'Neha Desai', 'Sales', '2022-08-18', 68000.00),
(7, 'Vikram Rao', 'Marketing', '2021-02-14', 60000.00),
(8, 'Pooja Krishnan', 'Marketing', '2022-04-22', 63000.00),
(9, 'Siddharth Menon', 'Engineering', '2023-01-30', 82000.00),
(10, 'Kavya Pillai', 'Sales', '2023-06-10', 69000.00);
