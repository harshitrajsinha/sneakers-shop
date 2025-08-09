-- Create main database for products
-- CREATE DATABASE IF NOT EXISTS  sneaker_db;

-- Connect to sneaker_db
\c sneaker_db;

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    style VARCHAR(100) NOT NULL,
    color VARCHAR(50) NOT NULL,
    size VARCHAR(20) NOT NULL,
    material VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    image_url VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

TRUNCATE TABLE products CASCADE;

-- Insert 20 sample sneaker products
INSERT INTO products (id, name, brand, style, color, size, material, price, description, image_url) VALUES
(1, 'Air Max 270', 'Nike', 'Running', 'Black/White', '8-12', 'Mesh/Synthetic', 12999.00, 'Comfortable running shoes with Air Max technology', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300'),
(2, 'Adidas Ultraboost 22', 'Adidas', 'Running', 'Core Black', '7-13', 'Primeknit', 16999.00, 'Premium running shoes with Boost technology', 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300'),
(3, 'Chuck Taylor All Star', 'Converse', 'Casual', 'Classic White', '6-12', 'Canvas', 4999.00, 'Iconic casual sneakers for everyday wear', 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300'),
(4, 'Old Skool', 'Vans', 'Skate', 'Black/White', '7-13', 'Suede/Canvas', 5999.00, 'Classic skate shoes with waffle outsole', 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=300'),
(5, 'Air Jordan 1 Mid', 'Jordan', 'Basketball', 'Chicago Red', '8-14', 'Leather', 10999.00, 'Mid-top basketball shoes with iconic design', 'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=300'),
(6, 'Stan Smith', 'Adidas', 'Tennis', 'White/Green', '6-12', 'Leather', 6999.00, 'Classic tennis shoes with minimalist design', 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300'),
(7, 'React Element 55', 'Nike', 'Lifestyle', 'Wolf Grey', '7-12', 'Mesh/Synthetic', 8999.00, 'Modern lifestyle shoes with React cushioning', 'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=300'),
(8, 'NMD_R1', 'Adidas', 'Lifestyle', 'Triple Black', '7-13', 'Primeknit', 13999.00, 'Street-style shoes with Boost midsole', 'https://images.unsplash.com/photo-1562917433-6eb8b9187d63?w=300'),
(9, 'Blazer Mid 77', 'Nike', 'Lifestyle', 'White/Black', '6-12', 'Leather', 7999.00, 'Vintage basketball-inspired casual shoes', 'https://images.unsplash.com/photo-1597045566677-8cf032ed6634?w=300'),
(10, 'Gazelle', 'Adidas', 'Casual', 'Navy Blue', '6-12', 'Suede', 5499.00, 'Retro-inspired casual sneakers', 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300'),
(11, 'Air Force 1', 'Nike', 'Basketball', 'Triple White', '7-13', 'Leather', 8499.00, 'Classic basketball shoes for everyday wear', 'https://images.unsplash.com/photo-1511556532299-8f662fc26c06?w=300'),
(12, 'Superstar', 'Adidas', 'Casual', 'White/Black', '6-12', 'Leather', 6499.00, 'Iconic shell-toe sneakers', 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300'),
(13, 'Dunk Low', 'Nike', 'Skateboard', 'Panda', '7-12', 'Leather', 9999.00, 'Classic skateboard shoes with retro appeal', 'https://images.unsplash.com/photo-1605348532760-6753d2c43329?w=300'),
(14, 'Authentic', 'Vans', 'Casual', 'Checkered', '6-12', 'Canvas', 4499.00, 'Classic lace-up shoes with signature pattern', 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=300'),
(15, 'Yeezy Boost 350', 'Adidas', 'Lifestyle', 'Cream White', '7-13', 'Primeknit', 24999.00, 'Designer lifestyle shoes with Boost technology', 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=300'),
(16, 'Classic Leather', 'Reebok', 'Casual', 'Pure White', '7-12', 'Leather', 4999.00, 'Simple and clean casual sneakers', 'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=300'),
(17, 'Cortez', 'Nike', 'Running', 'White/Red', '6-12', 'Nylon/Suede', 5999.00, 'Vintage-inspired running shoes', 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5b?w=300'),
(18, 'Forum Low', 'Adidas', 'Basketball', 'Cloud White', '7-13', 'Leather', 7499.00, 'Retro basketball shoes with ankle strap', 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=300'),
(19, 'Pegasus 38', 'Nike', 'Running', 'Black/Grey', '7-12', 'Mesh', 9499.00, 'Reliable running shoes for daily training', 'https://images.unsplash.com/photo-1606890737304-57a1ca8a5b62?w=300'),
(20, 'Falcon', 'Adidas', 'Lifestyle', 'Raw White', '6-11', 'Mesh/Synthetic', 8499.00, 'Chunky lifestyle sneakers with retro vibes', 'https://images.unsplash.com/photo-1595341888016-a392ef81b2de?w=300');