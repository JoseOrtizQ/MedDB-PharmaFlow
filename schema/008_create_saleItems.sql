-- 8. SALE ITEMS TABLE
CREATE TABLE sale_items (
    sale_item_id SERIAL PRIMARY KEY,
    sale_id INTEGER NOT NULL REFERENCES sales(sale_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    inventory_id INTEGER REFERENCES inventory(inventory_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    discount_percentage DECIMAL(5,2) DEFAULT 0.00 CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    discount_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (discount_amount >= 0),
    line_total DECIMAL(10,2) NOT NULL CHECK (line_total >= 0),
    expiration_date DATE,
    batch_number VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW()
);
