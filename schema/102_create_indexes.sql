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

-- Create indexes for sales
CREATE INDEX idx_sales_number ON sales(sale_number);
CREATE INDEX idx_sales_date ON sales(sale_date);
CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_prescription ON sales(prescription_number) WHERE prescription_number IS NOT NULL;

-- Create indexes for sale_items
CREATE INDEX idx_sale_items_sale_id ON sale_items(sale_id);
CREATE INDEX idx_sale_items_product_id ON sale_items(product_id);

-- Create indexes for purchase_orders
CREATE INDEX idx_po_number ON purchase_orders(po_number);
CREATE INDEX idx_po_supplier ON purchase_orders(supplier_id);
CREATE INDEX idx_po_status ON purchase_orders(status);

-- Create index for purchase_order_items
CREATE INDEX idx_po_items_po_id ON purchase_order_items(po_id);

-- Create indexes for expiration_alerts
CREATE INDEX idx_alerts_expiration_date ON expiration_alerts(expiration_date);
CREATE INDEX idx_alerts_date ON expiration_alerts(alert_date);
CREATE INDEX idx_alerts_type ON expiration_alerts(alert_type);
CREATE INDEX idx_alerts_unacknowledged ON expiration_alerts(is_acknowledged) WHERE is_acknowledged = FALSE;

-- Create indexes for stock_movements
CREATE INDEX idx_movements_date ON stock_movements(movement_date);
CREATE INDEX idx_movements_type ON stock_movements(movement_type);
CREATE INDEX idx_movements_product ON stock_movements(product_id);
CREATE INDEX idx_movements_inventory ON stock_movements(inventory_id);
