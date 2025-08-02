-- Create indexes for products
CREATE INDEX idx_products_code ON products(product_code);
CREATE INDEX idx_products_name ON products USING gin(to_tsvector('english', product_name));
CREATE INDEX idx_products_generic_name ON products USING gin(to_tsvector('english', generic_name));
CREATE INDEX idx_products_active ON products(is_active) WHERE is_active = TRUE;

-- Create indexes for inventory
CREATE INDEX idx_inventory_product_id ON inventory(product_id);
CREATE INDEX idx_inventory_expiration_date ON inventory(expiration_date) WHERE status = 'active';
CREATE INDEX idx_inventory_batch_number ON inventory(batch_number);
CREATE INDEX idx_inventory_status ON inventory(status);
CREATE INDEX idx_inventory_product_expiration ON inventory(product_id, expiration_date);

-- Create indexes for customers
CREATE INDEX idx_customers_code ON customers(customer_code);
CREATE INDEX idx_customers_phone ON customers(phone);
CREATE INDEX idx_customers_name ON customers(last_name, first_name);

-- Create indexes for users
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(is_active) WHERE is_active = TRUE;
