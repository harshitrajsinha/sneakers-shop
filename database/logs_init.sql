-- Create logs database
-- CREATE DATABASE IF NOT EXISTS logs_db;

-- Connect to logs_db
\c logs_db;

-- Create payment logs table
CREATE TABLE IF NOT EXISTS payment_logs (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    transaction_id VARCHAR(100) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create event logs table for general logging
CREATE TABLE IF NOT EXISTS event_logs (
    id SERIAL PRIMARY KEY,
    event_type VARCHAR(50) NOT NULL,
    data JSONB,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for better query performance
-- CREATE INDEX idx_payment_logs_timestamp ON payment_logs(timestamp);
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'idx_payment_logs_timestamp'
          AND n.nspname = 'public' -- or your schema name
    ) THEN
        CREATE INDEX idx_payment_logs_timestamp ON payment_logs(timestamp);
    END IF;
END
$$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'idx_payment_logs_product_id'
          AND n.nspname = 'public' -- or your schema name
    ) THEN
        CREATE INDEX idx_payment_logs_product_id ON payment_logs(product_id);
    END IF;
END
$$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'idx_event_logs_timestamp'
          AND n.nspname = 'public' -- or your schema name
    ) THEN
        CREATE INDEX idx_event_logs_timestamp ON event_logs(timestamp);
    END IF;
END
$$;
-- CREATE INDEX idx_payment_logs_product_id ON payment_logs(product_id);
-- CREATE INDEX idx_event_logs_timestamp ON event_logs(timestamp);

-- Create products table in logs_db for analytics joins
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


TRUNCATE TABLE products CASCADE;

-- Insert product data for analytics (sync with main products table)
INSERT INTO products (id, name, brand, price) VALUES
(1, 'Air Max 270', 'Nike', 12999.00),
(2, 'Adidas Ultraboost 22', 'Adidas', 16999.00),
(3, 'Chuck Taylor All Star', 'Converse', 4999.00),
(4, 'Old Skool', 'Vans', 5999.00),
(5, 'Air Jordan 1 Mid', 'Jordan', 10999.00),
(6, 'Stan Smith', 'Adidas', 6999.00),
(7, 'React Element 55', 'Nike', 8999.00),
(8, 'NMD_R1', 'Adidas', 13999.00),
(9, 'Blazer Mid 77', 'Nike', 7999.00),
(10, 'Gazelle', 'Adidas', 5499.00),
(11, 'Air Force 1', 'Nike', 8499.00),
(12, 'Superstar', 'Adidas', 6499.00),
(13, 'Dunk Low', 'Nike', 9999.00),
(14, 'Authentic', 'Vans', 4499.00),
(15, 'Yeezy Boost 350', 'Adidas', 24999.00),
(16, 'Classic Leather', 'Reebok', 4999.00),
(17, 'Cortez', 'Nike', 5999.00),
(18, 'Forum Low', 'Adidas', 7499.00),
(19, 'Pegasus 38', 'Nike', 9499.00),
(20, 'Falcon', 'Adidas', 8499.00);